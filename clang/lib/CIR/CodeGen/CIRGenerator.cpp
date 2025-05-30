//===--- CIRGenerator.cpp - Emit CIR from ASTs ----------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This builds an AST and converts it to CIR.
//
//===----------------------------------------------------------------------===//

#include "CIRGenModule.h"

#include "mlir/Dialect/OpenACC/OpenACC.h"
#include "mlir/IR/MLIRContext.h"

#include "clang/AST/DeclGroup.h"
#include "clang/CIR/CIRGenerator.h"
#include "clang/CIR/Dialect/IR/CIRDialect.h"
#include "clang/CIR/Dialect/OpenACC/RegisterOpenACCExtensions.h"

using namespace cir;
using namespace clang;

void CIRGenerator::anchor() {}

CIRGenerator::CIRGenerator(clang::DiagnosticsEngine &diags,
                           llvm::IntrusiveRefCntPtr<llvm::vfs::FileSystem> vfs,
                           const CodeGenOptions &cgo)
    : diags(diags), fs(std::move(vfs)), codeGenOpts{cgo} {}
CIRGenerator::~CIRGenerator() = default;

void CIRGenerator::Initialize(ASTContext &astContext) {
  using namespace llvm;

  this->astContext = &astContext;

  mlirContext = std::make_unique<mlir::MLIRContext>();
  mlirContext->loadDialect<cir::CIRDialect>();
  mlirContext->getOrLoadDialect<mlir::acc::OpenACCDialect>();

  // Register extensions to integrate CIR types with OpenACC.
  mlir::DialectRegistry registry;
  cir::acc::registerOpenACCExtensions(registry);
  mlirContext->appendDialectRegistry(registry);

  cgm = std::make_unique<clang::CIRGen::CIRGenModule>(
      *mlirContext.get(), astContext, codeGenOpts, diags);
}

bool CIRGenerator::verifyModule() const { return cgm->verifyModule(); }

mlir::ModuleOp CIRGenerator::getModule() const { return cgm->getModule(); }

bool CIRGenerator::HandleTopLevelDecl(DeclGroupRef group) {
  if (diags.hasUnrecoverableErrorOccurred())
    return true;

  for (Decl *decl : group)
    cgm->emitTopLevelDecl(decl);

  return true;
}

void CIRGenerator::CompleteTentativeDefinition(VarDecl *d) {
  if (diags.hasErrorOccurred())
    return;

  cgm->emitTentativeDefinition(d);
}
