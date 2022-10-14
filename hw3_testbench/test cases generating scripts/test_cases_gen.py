from lines_gen import lines_gen_up, lines_gen_dn

if __name__ == "__main__":

    # gen_target = 'counterA';
    gen_target = 'counterB';
    f_path = "test_cases_{}.csv".format(gen_target)

    all_lines = []

    f = open(f_path, 'w')

    # case 1: reset and enable
    # lines_lst, cnt = lines_gen_up('re', 1, 5)
    lines_lst, cnt = lines_gen_dn('re', 3, 5)

    all_lines.extend(lines_lst)

    # case 2: reset and not enable
    # lines_lst, cnt = lines_gen_up('r', cnt, 5)
    lines_lst, cnt = lines_gen_dn('r', cnt, 5)

    all_lines.extend(lines_lst)

    # case 3: enable and not reset
    # lines_lst, cnt = lines_gen_up('e', cnt, 65545)
    lines_lst, cnt = lines_gen_dn('e', cnt, 65545)

    all_lines.extend(lines_lst)

    # case 4: not reset and not enable
    # lines_lst, cnt = lines_gen_up('x', cnt, 10)
    lines_lst, cnt = lines_gen_dn('x', cnt, 10)

    all_lines.extend(lines_lst)

    # case 1 again: reset and enable
    # lines_lst, cnt = lines_gen_up('r', cnt, 5)
    lines_lst, cnt = lines_gen_dn('r', cnt, 5)

    all_lines.extend(lines_lst)

    print(len(all_lines))

    for line in all_lines:
        f.write(line)
    
    f.close()
    print("File generated.")
