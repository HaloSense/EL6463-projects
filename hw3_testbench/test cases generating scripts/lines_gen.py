def lines_gen_up(mode, cnt_in, for_period):
    line = ''
    lines = []

    rst = '0'
    en = '0'
    cnt = cnt_in

    for i in range(for_period):
        if mode == 're':
            rst = '1'
            en = '1'
            cnt = 1
        
        if mode == 'r':
            rst = '1'
            en = '0'
            cnt = 1
        
        if mode == 'e':
            rst = '0'
            en = '1'
            cnt += 1
            if cnt == 65536:
                cnt = 0

        if mode == 'x':
            rst = '0'
            en = '0'

        cnt_out = '{:016b}'.format(cnt)
        line = ",".join((rst, en, cnt_out))
        line = "".join((line, "\n"))

        lines.append(line)
    
    return lines, cnt

def lines_gen_dn(mode, cnt_in, for_period):
    line = ''
    lines = []

    rst = '0'
    en = '0'
    cnt = cnt_in

    for i in range(for_period):
        if mode == 're':
            rst = '1'
            en = '1'
            cnt = 3
        
        if mode == 'r':
            rst = '1'
            en = '0'
            cnt = 3

        if mode == 'e':
            rst = '0'
            en = '1'
            cnt -= 1
            if cnt == -1:
                cnt = 65535

        if mode == 'x':
            rst = '0'
            en = '0'

        cnt_out = '{:016b}'.format(cnt)
        line = ",".join((rst, en, cnt_out))
        line = "".join((line, "\n"))

        lines.append(line)
    
    return lines, cnt

