[bits 32]

[global kernel_start]
[extern kernel_main]

MULTIBOOT_MODULE_ALIGN      equ  1<<0
MULTIBOOT_MEMORY_MAP        equ  1<<1
MULTIBOOT_GRAPHICS_FIELDS   equ  1<<2
MULTIBOOT_ADDRESS_FIELDS    equ  1<<16

MULTIBOOT_HEADER_MAGIC      equ  0x1BADB002
MULTIBOOT_HEADER_FLAGS      equ  MULTIBOOT_MODULE_ALIGN | MULTIBOOT_MEMORY_MAP
MULTIBOOT_HEADER_CHECKSUM   equ  -(MULTIBOOT_HEADER_MAGIC + MULTIBOOT_HEADER_FLAGS)

KERNEL_STACKSIZE            equ  0x4000
 
section .text
 
align 4

dd MULTIBOOT_HEADER_MAGIC
dd MULTIBOOT_HEADER_FLAGS
dd MULTIBOOT_HEADER_CHECKSUM
 
kernel_start:
    mov esp, KERNEL_STACK+KERNEL_STACKSIZE
    push eax
    push ebx
    call kernel_main
    cli
    hlt
 
section .bss
 
align 32
KERNEL_STACK:
    resb KERNEL_STACKSIZE