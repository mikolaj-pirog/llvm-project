; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 5
; RUN: llc --mtriple=loongarch64  %s -o - | FileCheck %s

declare i32 @llvm.lround.i32.f64(double)

;; We support lround with i32 as return type on LoongArch64. This is needed by flang.
define i32 @lround_i32_f64(double %a) nounwind {
; CHECK-LABEL: lround_i32_f64:
; CHECK:       # %bb.0:
; CHECK-NEXT:    addi.d $sp, $sp, -16
; CHECK-NEXT:    st.d $ra, $sp, 8 # 8-byte Folded Spill
; CHECK-NEXT:    pcaddu18i $ra, %call36(lround)
; CHECK-NEXT:    jirl $ra, $ra, 0
; CHECK-NEXT:    ld.d $ra, $sp, 8 # 8-byte Folded Reload
; CHECK-NEXT:    addi.d $sp, $sp, 16
; CHECK-NEXT:    ret
  %1 = call i32 @llvm.lround.i32.f64(double %a)
  ret i32 %1
}
