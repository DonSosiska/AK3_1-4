.global lab4
.syntax unified

#define X1 #-9
#define X2 #10
#define X3 #31
#define X4 #-21

lab4:
  push {lr}
  bl task1
  bl task2
  pop {pc}

task1:
  push {lr}
  mov r0, X1
  mov r1, #0xFFFFFFFF
  mov r2, X2
  mov r3, #0
  mov r4, X3
  mov r5, #0
  mov r6, X4
  mov r7, #0xFFFFFFFF

  //4*(X1 / 2 + X2) - (X3 + 1 - X4) / 4
  asr r0, #1
  lsr r1, #1
  add r0, r2
  adc r1, r3
  lsl r0, #2
  lsl r1, #2
  add r4, #1
  adc r5, #1
  sub r4, r6
  sbc r5, r7
  asr r4, #2
  lsr r5, #2
  sub r0, r4
  sbc r1, r5
  
  bl result_correction
  pop {pc}

result_correction:
  push {lr}
  bvc step2
  lsr r0, #1
  lsr r1, #1
  
step2:
  orr r0, #0
  bne step4
  orr r1, #0
  bne step4
  mov r0, #0b10111011
  
step4:
  add r1, #0b10111011
  and r5, r1, #0xc0000000
  beq step7
  eor r5, #0xc0000000
  beq step7
  lsr r0, #1
  lsr r1, #1
  
step7:
  bvs end_correction
  push {r0}
  push {r1}
  pop {r1}
  pop {r0}

end_correction:
  pop {pc}

task2:
  push {lr}

  mov r1, #11
  mov r2, #4

first_program:
  sub r0, r1, r2
  add r0, r1, r0
  
label_3:
  mul r0, r0, r2
  bvs label_1
  sub r0, r1, r2
  b label_2
  
label_1:
  sub r0, #2
  add r1, #3
  
label_2:
  bne label_3
  bl second_program
  and r0, r1
  pop {pc}

second_program:
  push {lr}
  
label_5:
  sub r2, #1
  bcs label_4
  eor r1, r2
  
label_4:
  bvs label_5
  bl third_program  
  add r0, r1, r2
  sub r0, r1, r2
  pop {pc}

third_program:
  push {lr}
  adds r0, r1, r2
  udiv r0, r2, r1
  
  pop {pc}
