unit console;

interface
    var
        xpos: Integer = 0;
        ypos: Integer = 0;

    procedure clear_screen();
    procedure write_char(c: Char);
    procedure write_string(s: PChar);
    procedure write_int(i: Integer);
    procedure write_dword(i: DWORD);

implementation
    var 
        vidmem: PChar = PChar($b8000);

    procedure clear_screen(); [public, alias: 'clear_screen'];
    var
        i: Integer;
    begin
        for i := 0 to 3999 do
            vidmem[i] := #0;
    end;

    procedure write_char(c: Char); [public; alias: 'write_char'];
    var
        offset: Integer;
    begin
        if(ypos > 24) then
            ypos := 0;
        
        if(xpos > 79) then
            xpos := 0;

        offset := (xpos shl 1) + (ypos * 160);
        vidmem[offset] := c;
        offset += 1;
        vidmem[offset] := #7;
        offset += 1;
 
        xpos := (offset mod 160);
        ypos := (offset - xpos) div 160;
        xpos := xpos shr 1;
    end;

    procedure write_string(s: PChar); [public; alias: 'write_string'];
    var
        offset: Integer,
        i: Integer;
    begin
        if (ypos > 24) then
            ypos := 0;
    
        if (xpos > 79) then
            xpos := 0;
    
        offset := (xpos shl 1) + (ypos * 160);
        i := 0;
    
        while (s[i] <> Char($0)) do
        begin
            vidmem[offset] := s[i];
            offset += 1;
            vidmem[offset] := #7;
            offset += 1;
            i += 1;
        end;
    
        xpos := (offset mod 160);
        ypos := (offset - xpos) div 160;
        xpos := xpos shr 1;
    end;

    procedure write_int(i: Integer); [public; alias: 'write_int'];
    var
        buffer: array [0..11] of Char;
        str: PChar;
        digit: DWORD;
        minus: Boolean;
    begin
        str := @buffer[11];
        str^ := #0;
 
        if (i < 0) then
        begin
            digit := -i;
            minus := True;
        end
        else
        begin
            digit := i;
            minus := False;
        end;
 
        repeat
            Dec(str);
            str^ := Char((digit mod 10) + Byte('0'));
            digit := digit div 10;
        until (digit = 0);
 
        if (minus) then
        begin
            Dec(str);
            str^ := '-';
        end;
 
        write_string(str);
    end;

    procedure write_dword(i: DWORD); [public; alias: 'write_dword'];
    var
        buffer: array [0..11] of Char;
        str: PChar;
        digit: DWORD;
    begin
        for digit := 0 to 10 do
            buffer[digit] := '0';
 
        str := @buffer[11];
        str^ := #0;
 
        digit := i;
        repeat
            Dec(str);
            str^ := Char((digit mod 10) + Byte('0'));
            digit := digit div 10;
        until (digit = 0);
 
        write_string(str);
    end;
end.