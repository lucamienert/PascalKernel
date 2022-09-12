unit multiboot;

interface
    const
        KERNEL_STACKSIZE = $4000;
        MULTIBOOT_BOOTLOADER_MAGIC = $2BADB002;

    type
        Pelf_section_header_table_t = ^elf_section_header_table_t;
        elf_section_header_table_t = packed record
            num: DWORD;
            size: DWORD;
            addr: DWORD;
            shndx: DWORD;
        end;
 
        Pmultiboot_info_t = ^multiboot_info_t;
        multiboot_info_t = packed record
            flags: DWORD;
            mem_lower: DWORD;
            mem_upper: DWORD;
            boot_device: DWORD;
            cmdline: DWORD;
            mods_count: DWORD;
            mods_addr: DWORD;
            elf_sec: elf_section_header_table_t;
            mmap_length: DWORD;
            mmap_addr: DWORD;
        end;
 
        Pmodule_t = ^module_t;
        module_t = packed record
            mod_start: DWORD;
            mod_end: DWORD;
            name: DWORD;
            reserved: DWORD;
        end;
 
        Pmemory_map_t = ^memory_map_t;
        memory_map_t = packed record
            size: DWORD;
            base_addr_low: DWORD;
            base_addr_high: DWORD;
            length_low: DWORD;
            length_high: DWORD;
            mtype: DWORD;
        end;

implementation