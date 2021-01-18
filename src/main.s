.intel_syntax noprefix
.section .text
.globl my_atoi

my_atoi:
  push rbp
  mov rbp, rsp

  mov rax, 1

  mov rsp, rbp
  pop rbp
  ret
  

.globl _start

_start:
  mov rdx, qword ptr [rsp]  # move argc into rdx
  mov rbx, qword ptr [rsp + 8] # get argv base

  push rbp
  mov rbp, rsp

  xor rdi, rdi    # zero out to use as accumilator
loop:
  cmp rdx, 1
  jle return       # info no arguments left, jump to end

  push qword ptr [rbx + 8 * rdx]
  call my_atoi
  add rsp, 8
  add rdi, rax
  
  sub rdx, 1 
  jmp loop

return:
  mov rsp, rbp
  pop rbp
  mov rax, 60
  syscall
