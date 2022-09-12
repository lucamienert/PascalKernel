unit kernel;

interface
    uses
        mulitboot,
        console;

    procedure kernel_main(multibootInfo: MultibootInfo, multibootMagic: DWORD); stdcall;

implementation
    procedure kernel_main(multibootInfo: MultibootInfo, multibootMagic: DWORD); stdcall; [public, alias: 'kernel_main'];
    begin
        clear_screen();
        write_string('FreePascal Kernel by Luca Mienert')

        xpos := 0;
        ypos += 1;

        if(multibootMagic <> MULTIBOOT_BOOTLOADER_MAGIC) then
        begin
            write_string('Halting System');
            asm
                cli
                htl
            end; 
        end
        else
        begin
            write_string('Booted by a multiboot-compliant boot loader!');
            xpos := 0;
            ypos += 2;
            write_string('Multiboot information:');
            xpos := 0;
            ypos += 2;
            write_string('Lower memory  = ');
            kwriteint(multibootInfo^.mem_lower);
            write_string('KB');
            xpos := 0;
            ypos += 1;
            write_string('Higher memory = ');
            kwriteint(multibootInfo^.mem_upper);
            write_string('KB');
            xpos := 0;
            ypos += 1;
            write_string('Total memory  = ');
            kwriteint(((multibootInfo^.mem_upper + 1000) div 1024) +1);
            write_string('MB');
        end;
    end;
end.