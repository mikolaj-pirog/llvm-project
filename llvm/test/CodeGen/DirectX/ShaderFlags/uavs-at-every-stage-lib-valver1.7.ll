; RUN: opt -S --passes="print-dx-shader-flags" 2>&1 %s | FileCheck %s
; RUN: llc %s --filetype=obj -o - | obj2yaml | FileCheck %s --check-prefix=DXC

; This test ensures that a library shader with a UAV gets the module and
; shader feature flag UAVsAtEveryStage when the DXIL validator version is < 1.8

target triple = "dxil-pc-shadermodel6.5-library"

; CHECK:      Combined Shader Flags for Module
; CHECK-NEXT: Shader Flags Value: 0x00010000

; CHECK: Note: shader requires additional functionality:
; CHECK:        UAVs at every shader stage

; CHECK: Function test : 0x00010000
define void @test() "hlsl.export" {
  ; RWBuffer<float> Buf : register(u0, space0)
  %buf0 = call target("dx.TypedBuffer", float, 1, 0, 1)
       @llvm.dx.resource.handlefrombinding.tdx.TypedBuffer_f32_1_0t(
           i32 0, i32 0, i32 1, i32 0, i1 false, ptr null)
  ret void
}

!dx.valver = !{!1}
!1 = !{i32 1, i32 7}

!llvm.module.flags = !{!0}
!0 = !{i32 1, !"dx.resmayalias", i32 1}

; DXC: - Name:            SFI0
; DXC-NEXT:     Size:            8
; DXC-NEXT:     Flags:
; DXC:       UAVsAtEveryStage:         true
; DXC:       NextUnusedBit:   false
; DXC: ...
