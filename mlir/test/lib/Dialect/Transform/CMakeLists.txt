set(LLVM_TARGET_DEFINITIONS TestTransformDialectExtension.td)
mlir_tablegen(TestTransformDialectExtension.h.inc -gen-op-decls)
mlir_tablegen(TestTransformDialectExtension.cpp.inc -gen-op-defs)
mlir_tablegen(TestTransformDialectExtensionTypes.h.inc -gen-typedef-decls -typedefs-dialect=transform)
mlir_tablegen(TestTransformDialectExtensionTypes.cpp.inc -gen-typedef-defs -typedefs-dialect=transform)
add_public_tablegen_target(MLIRTestTransformDialectExtensionIncGen)

add_mlir_library(MLIRTestTransformDialect
  TestPassStateExtensionCommunication.cpp
  TestTransformDialectExtension.cpp
  TestTransformDialectInterpreter.cpp
  TestTransformStateExtension.cpp

  EXCLUDE_FROM_LIBMLIR

  DEPENDS
  MLIRTestTransformDialectExtensionIncGen
)
mlir_target_link_libraries(MLIRTestTransformDialect PUBLIC
  MLIRIR
  MLIRPass
  MLIRPDLDialect
  MLIRTransformDebugExtension
  MLIRTransformDialect
  MLIRTransformDialectTransforms
  MLIRTransformLoopExtension
  MLIRTransformPDLExtension
)
