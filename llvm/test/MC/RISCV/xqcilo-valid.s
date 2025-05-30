# Xqcilo - Qualcomm uC Large Offset Load Store extension
# RUN: llvm-mc %s -triple=riscv32 -mattr=+experimental-xqcilo -M no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ENC,CHECK-INST,CHECK-NOALIAS %s
# RUN: llvm-mc -filetype=obj -triple riscv32 -mattr=+experimental-xqcilo < %s \
# RUN:     | llvm-objdump --mattr=+experimental-xqcilo -M no-aliases --no-print-imm-hex -d - \
# RUN:     | FileCheck -check-prefix=CHECK-INST %s
# RUN: llvm-mc %s -triple=riscv32 -mattr=+experimental-xqcilo -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ENC,CHECK-INST,CHECK-ALIAS %s
# RUN: llvm-mc -filetype=obj -triple riscv32 -mattr=+experimental-xqcilo < %s \
# RUN:     | llvm-objdump --mattr=+experimental-xqcilo --no-print-imm-hex -d - \
# RUN:     | FileCheck -check-prefix=CHECK-INST %s

# RUN: llvm-mc %s -triple=riscv32 -mattr=+zcb,+experimental-xqcilo -M no-aliases -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ENC-ZCB,CHECK-INST-ZCB,CHECK-NOALIAS-ZCB %s
# RUN: llvm-mc -filetype=obj -triple riscv32 -mattr=+zcb,+experimental-xqcilo < %s \
# RUN:     | llvm-objdump --mattr=+zcb,+experimental-xqcilo -M no-aliases --no-print-imm-hex -d - \
# RUN:     | FileCheck -check-prefix=CHECK-INST-ZCB %s
# RUN: llvm-mc %s -triple=riscv32 -mattr=+zcb,+experimental-xqcilo -show-encoding \
# RUN:     | FileCheck -check-prefixes=CHECK-ENC-ZCB,CHECK-INST-ZCB,CHECK-ALIAS-ZCB %s
# RUN: llvm-mc -filetype=obj -triple riscv32 -mattr=+zcb,+experimental-xqcilo < %s \
# RUN:     | llvm-objdump --mattr=+experimental-xqcilo --no-print-imm-hex -d - \
# RUN:     | FileCheck -check-prefix=CHECK-INST-ZCB %s

# CHECK-INST: qc.e.lb a1, 3000(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x85,0x3b,0x02,0x00]

# CHECK-INST-ZCB: qc.e.lb a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x85,0x3b,0x02,0x00]
qc.e.lb x11, 3000(x10)

# CHECK-INST: qc.e.lb a1, -33554432(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x05,0x00,0x00,0x80]

# CHECK-INST-ZCB: qc.e.lb a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x05,0x00,0x00,0x80]
qc.e.lb x11, -33554432(x10)

# CHECK-INST: qc.e.lb a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0xf5,0x3f,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.lb a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0xf5,0x3f,0xff,0x7f]
qc.e.lb x11, 33554431(x10)


# CHECK-INST: qc.e.lbu        a1, 3000(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x85,0x7b,0x02,0x00]

# CHECK-INST-ZCB: qc.e.lbu        a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x85,0x7b,0x02,0x00]
qc.e.lbu x11, 3000(x10)

# CHECK-INST: qc.e.lbu        a1, -33554432(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x05,0x40,0x00,0x80]

# CHECK-INST-ZCB: qc.e.lbu        a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x05,0x40,0x00,0x80]
qc.e.lbu x11, -33554432(x10)

# CHECK-INST: qc.e.lbu        a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0xf5,0x7f,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.lbu        a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0xf5,0x7f,0xff,0x7f]
qc.e.lbu x11, 33554431(x10)


# CHECK-INST: qc.e.lh a1, 3000(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x85,0xbb,0x02,0x00]

# CHECK-INST-ZCB: qc.e.lh a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x85,0xbb,0x02,0x00]
qc.e.lh x11, 3000(x10)

# CHECK-INST: qc.e.lh a1, -33554432(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x05,0x80,0x00,0x80]

# CHECK-INST-ZCB: qc.e.lh a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x05,0x80,0x00,0x80]
qc.e.lh x11, -33554432(x10)

# CHECK-INST: qc.e.lh a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0xf5,0xbf,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.lh a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0xf5,0xbf,0xff,0x7f]
qc.e.lh x11, 33554431(x10)


# CHECK-INST: qc.e.lhu        a1, 3000(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x85,0xfb,0x02,0x00]

# CHECK-INST-ZCB: qc.e.lhu        a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x85,0xfb,0x02,0x00]
qc.e.lhu x11, 3000(x10)

# CHECK-INST: qc.e.lhu        a1, -33554432(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0x05,0xc0,0x00,0x80]

# CHECK-INST-ZCB: qc.e.lhu        a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0x05,0xc0,0x00,0x80]
qc.e.lhu x11, -33554432(x10)

# CHECK-INST: qc.e.lhu        a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x55,0xf5,0xff,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.lhu        a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x55,0xf5,0xff,0xff,0x7f]
qc.e.lhu x11, 33554431(x10)


# CHECK-INST: qc.e.lw a1, 3000(a0)
# CHECK-ENC: encoding: [0x9f,0x65,0x85,0x3b,0x02,0x00]

# CHECK-INST-ZCB: qc.e.lw a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x65,0x85,0x3b,0x02,0x00]
qc.e.lw x11, 3000(x10)

# CHECK-INST: qc.e.lw a1, -33554432(a0)
# CHECK-ENC: encoding: [0x9f,0x65,0x05,0x00,0x00,0x80]

# CHECK-INST-ZCB: qc.e.lw a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x65,0x05,0x00,0x00,0x80]
qc.e.lw x11, -33554432(x10)

# CHECK-INST: qc.e.lw a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x65,0xf5,0x3f,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.lw a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x65,0xf5,0x3f,0xff,0x7f]
qc.e.lw x11, 33554431(x10)


# CHECK-INST: qc.e.sb a1, 3000(a0)
# CHECK-ENC: encoding: [0x1f,0x6c,0xb5,0x7a,0x02,0x00]

# CHECK-INST-ZCB: qc.e.sb a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x1f,0x6c,0xb5,0x7a,0x02,0x00]
qc.e.sb x11, 3000(x10)

# CHECK-INST: qc.e.sb a1, -33554432(a0)
# CHECK-ENC: encoding: [0x1f,0x60,0xb5,0x40,0x00,0x80]

# CHECK-INST-ZCB: qc.e.sb a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x1f,0x60,0xb5,0x40,0x00,0x80]
qc.e.sb x11, -33554432(x10)

# CHECK-INST: qc.e.sb a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x6f,0xb5,0x7e,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.sb a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x6f,0xb5,0x7e,0xff,0x7f]
qc.e.sb x11, 33554431(x10)


# CHECK-INST: qc.e.sh a1, 3000(a0)
# CHECK-ENC: encoding: [0x1f,0x6c,0xb5,0xba,0x02,0x00]

# CHECK-INST-ZCB: qc.e.sh a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x1f,0x6c,0xb5,0xba,0x02,0x00]
qc.e.sh x11, 3000(x10)

# CHECK-INST: qc.e.sh a1, -33554432(a0)
# CHECK-ENC: encoding: [0x1f,0x60,0xb5,0x80,0x00,0x80]

# CHECK-INST-ZCB: qc.e.sh a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x1f,0x60,0xb5,0x80,0x00,0x80]
qc.e.sh x11, -33554432(x10)

# CHECK-INST: qc.e.sh a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x6f,0xb5,0xbe,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.sh a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x6f,0xb5,0xbe,0xff,0x7f]
qc.e.sh x11, 33554431(x10)


# CHECK-INST: qc.e.sw a1, 3000(a0)
# CHECK-ENC: encoding: [0x1f,0x6c,0xb5,0xfa,0x02,0x00]

# CHECK-INST-ZCB: qc.e.sw a1, 3000(a0)
# CHECK-ENC-ZCB: encoding: [0x1f,0x6c,0xb5,0xfa,0x02,0x00]
qc.e.sw x11, 3000(x10)

# CHECK-INST: qc.e.sw a1, -33554432(a0)
# CHECK-ENC: encoding: [0x1f,0x60,0xb5,0xc0,0x00,0x80]

# CHECK-INST-ZCB: qc.e.sw a1, -33554432(a0)
# CHECK-ENC-ZCB: encoding: [0x1f,0x60,0xb5,0xc0,0x00,0x80]
qc.e.sw x11, -33554432(x10)

# CHECK-INST: qc.e.sw a1, 33554431(a0)
# CHECK-ENC: encoding: [0x9f,0x6f,0xb5,0xfe,0xff,0x7f]

# CHECK-INST-ZCB: qc.e.sw a1, 33554431(a0)
# CHECK-ENC-ZCB: encoding: [0x9f,0x6f,0xb5,0xfe,0xff,0x7f]
qc.e.sw x11, 33554431(x10)

# Check that compressed patterns work

# CHECK-INST: lb a1, 100(a0)
# CHECK-ENC: encoding: [0x83,0x05,0x45,0x06]

# CHECK-INST-ZCB: lb a1, 100(a0)
# CHECK-ENC-ZCB: encoding: [0x83,0x05,0x45,0x06]
qc.e.lb x11, 100(x10)

# CHECK-INST: lbu a1, 200(a0)
# CHECK-ENC: encoding: [0x83,0x45,0x85,0x0c]

# CHECK-INST-ZCB: lbu a1, 200(a0)
# CHECK-ENC-ZCB: encoding: [0x83,0x45,0x85,0x0c]
qc.e.lbu x11, 200(x10)

# CHECK-INST: lh a1, 300(a0)
# CHECK-ENC: encoding: [0x83,0x15,0xc5,0x12]

# CHECK-INST-ZCB: lh a1, 300(a0)
# CHECK-ENC-ZCB: encoding: [0x83,0x15,0xc5,0x12]
qc.e.lh x11, 300(x10)

# CHECK-INST: lhu a1, 400(a0)
# CHECK-ENC: encoding: [0x83,0x55,0x05,0x19]

# CHECK-INST-ZCB: lhu a1, 400(a0)
# CHECK-ENC-ZCB: encoding: [0x83,0x55,0x05,0x19]
qc.e.lhu x11, 400(x10)

# CHECK-INST: lw a1, 500(a0)
# CHECK-ENC: encoding: [0x83,0x25,0x45,0x1f]

# CHECK-INST-ZCB: lw a1, 500(a0)
# CHECK-ENC-ZCB: encoding: [0x83,0x25,0x45,0x1f]
qc.e.lw x11, 500(x10)

# CHECK-INST: sb a1, 600(a0)
# CHECK-ENC: encoding: [0x23,0x0c,0xb5,0x24]

# CHECK-INST-ZCB: sb a1, 600(a0)
# CHECK-ENC-ZCB: encoding: [0x23,0x0c,0xb5,0x24]
qc.e.sb x11, 600(x10)

# CHECK-INST: sh a1, 700(a0)
# CHECK-ENC: encoding: [0x23,0x1e,0xb5,0x2a]

# CHECK-INST-ZCB: sh a1, 700(a0)
# CHECK-ENC-ZCB: encoding: [0x23,0x1e,0xb5,0x2a]
qc.e.sh x11, 700(x10)

# CHECK-INST: sw a1, 800(a0)
# CHECK-ENC: encoding: [0x23,0x20,0xb5,0x32]

# CHECK-INST-ZCB: sw a1, 800(a0)
# CHECK-ENC-ZCB: encoding: [0x23,0x20,0xb5,0x32]
qc.e.sw x11, 800(x10)

# CHECK-ALIAS: lw a1, 32(a0)
# CHECK-NOALIAS: c.lw a1, 32(a0)
# CHECK-ENC: encoding: [0x0c,0x51]

# CHECK-ALIAS-ZCB: lw a1, 32(a0)
# CHECK-NOALIAS-ZCB: c.lw a1, 32(a0)
# CHECK-ENC-ZCB: encoding: [0x0c,0x51]
qc.e.lw x11, 32(x10)

# CHECK-ALIAS: sw a1, 124(a0)
# CHECK-NOALIAS: c.sw a1, 124(a0)
# CHECK-ENC: encoding: [0x6c,0xdd]

# CHECK-ALIAS-ZCB: sw a1, 124(a0)
# CHECK-NOALIAS-ZCB: c.sw a1, 124(a0)
# CHECK-ENC-ZCB: encoding: [0x6c,0xdd]
qc.e.sw x11, 124(x10)

# CHECK-ALIAS: lw ra, 64(sp)
# CHECK-NOALIAS: c.lwsp ra, 64(sp)
# CHECK-ENC: encoding: [0x86,0x40]

# CHECK-ALIAS-ZCB: lw ra, 64(sp)
# CHECK-NOALIAS-ZCB: c.lwsp ra, 64(sp)
# CHECK-ENC-ZCB: encoding: [0x86,0x40]
qc.e.lw x1, 64(x2)

# CHECK-ALIAS: sw a1, 252(sp)
# CHECK-NOALIAS: c.swsp a1, 252(sp)
# CHECK-ENC: encoding: [0xae,0xdf]

# CHECK-ALIAS-ZCB: sw a1, 252(sp)
# CHECK-NOALIAS-ZCB: c.swsp a1, 252(sp)
# CHECK-ENC-ZCB: encoding: [0xae,0xdf]
qc.e.sw x11, 252(x2)

# CHECK-ALIAS: lbu a1, 3(a0)
# CHECK-NOALIAS: lbu a1, 3(a0)
# CHECK-ENC: encoding: [0x83,0x45,0x35,0x00]

# CHECK-ALIAS-ZCB: lbu a1, 3(a0)
# CHECK-NOALIAS-ZCB: c.lbu a1, 3(a0)
# CHECK-ENC-ZCB: encoding: [0x6c,0x81]
qc.e.lbu x11, 3(x10)

# CHECK-ALIAS: lhu a1, 2(a0)
# CHECK-NOALIAS: lhu a1, 2(a0)
# CHECK-ENC: encoding: [0x83,0x55,0x25,0x00]

# CHECK-ALIAS-ZCB: lhu a1, 2(a0)
# CHECK-NOALIAS-ZCB: c.lhu a1, 2(a0)
# CHECK-ENC-ZCB: encoding: [0x2c,0x85]
qc.e.lhu x11, 2(x10)

# CHECK-ALIAS: lh a1, 0(a0)
# CHECK-NOALIAS: lh a1, 0(a0)
# CHECK-ENC: encoding: [0x83,0x15,0x05,0x00]

# CHECK-ALIAS-ZCB: lh a1, 0(a0)
# CHECK-NOALIAS-ZCB: c.lh a1, 0(a0)
# CHECK-ENC-ZCB: encoding: [0x4c,0x85]
qc.e.lh x11, 0(x10)

# CHECK-ALIAS: sb a1, 1(a0)
# CHECK-NOALIAS: sb a1, 1(a0)
# CHECK-ENC: encoding: [0xa3,0x00,0xb5,0x00]

# CHECK-ALIAS-ZCB: sb a1, 1(a0)
# CHECK-NOALIAS-ZCB: c.sb a1, 1(a0)
# CHECK-ENC-ZCB: encoding: [0x4c,0x89]
qc.e.sb x11, 1(x10)

# CHECK-ALIAS: sh a1, 2(a0)
# CHECK-NOALIAS: sh a1, 2(a0)
# CHECK-ENC: encoding: [0x23,0x11,0xb5,0x00]

# CHECK-ALIAS-ZCB: sh a1, 2(a0)
# CHECK-NOALIAS-ZCB: c.sh a1, 2(a0)
# CHECK-ENC-ZCB: encoding: [0x2c,0x8d]
qc.e.sh x11, 2(x10)
