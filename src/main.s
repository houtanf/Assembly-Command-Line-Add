# Adds command line arguments and returns result as the exit code.


.intel_syntax noprefix
.section .text
.globl _start
.globl my_atoi

_start:
  mov r12, qword ptr [rsp]  # move argc into rdx
  lea rbx, qword ptr [rsp + 8] # get argv base

  push rbp
  mov rbp, rsp

  xor r15, r15    # zero out to use as accumilator
loop:
  dec r12
  test r12, r12   # check if index is at 0
  jz return       # info no arguments left, jump to end

  mov rdi, qword ptr [rbx + 8 * r12] # move char* base
  call my_atoi
  add r15, rax
  
  jmp loop

return:
  mov rsp, rbp
  pop rbp
  mov rdi, r15    # set result as return code
  mov rax, 60
  syscall


my_atoi:
  mov r11, rdi
find_null:      # loop till r11 points to string terminating char
  cmp byte ptr [r11], 0
  je parse_init
  inc r11
  jmp find_null

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
  
