import math

def lines_gen(mode, data_in, for_period):
    line = ''
    lines = []

    rst = '0'
    en = '0'
    data = data_in

    msb = 0

    for i in range(for_period):
        if mode == 're':
            rst = '1'
            en = '1'
            data = (0,0,0,1,0,0,0,0,1,1)
        
        if mode == 'r':
            rst = '1'
            en = '0'
            data = (0,0,0,1,0,0,0,0,1,1)
        
        if mode == 'e':
            rst = '0'
            en = '1'
            msb = ((data[8] ^ data[7]) ^ data[4]) ^ data[1]

            data_new = [msb]
            data_new.extend(data[:9])
            data = data_new

        if mode == 'x':
            rst = '0'
            en = '0'
        
        data_out = "".join(str(i) for i in data)
        line = ",".join((rst, en, data_out))
        line = "".join((line, "\n"))

        lines.append(line)
    
    return lines, data
