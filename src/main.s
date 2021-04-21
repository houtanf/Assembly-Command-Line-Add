# Adds command line arguments and returns result as the exit code.


.intel_syntax noprefix
.section .text
.globl my_atoi

my_atoi:
  mov r11, rdi
find_null:      # loop till r11 points to string terminating char
  cmp byte ptr [r11], 0
  je parse_init
  inc r11
  jnz find_null

parse_init:
  xor rax, rax    # zero out accumilator
  mov r10, 1      # muiltiplication factor
  
parse_loop:
  dec r11
  movzx rcx, byte ptr [r11]

  sub rcx, 48     # char digit to int
  imul rcx, r10
  add rax, rcx
  imul r10, 10

  cmp rdi, r11
  jne parse_loop

  ret
  

.globl _start

_start:
  mov r12, qword ptr [rsp]  # move argc into rdx
  lea rbx, qword ptr [rsp + 8] # get argv base

  push rbp
  mov rbp, rsp

  xor r15, r15    # zero out to use as accumilator
loop:
  dec r12
  cmp r12, 0
  jle return       # info no arguments left, jump to end

  #push qword ptr [rbx + 8 + 8 * r12]
  mov rdi, qword ptr [rbx + 8 * r12]
  #lea rdi, qword ptr [rbx + r12 * 8]
  call my_atoi
  #add rsp, 8
  add r15, rax
  
  jmp loop

return:
  mov rsp, rbp
  pop rbp
  mov rdi, r15    # set result as return code
  mov rax, 60
  syscall
