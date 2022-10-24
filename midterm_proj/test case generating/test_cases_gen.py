from lines_gen import lines_gen

if __name__ == "__main__":

    gen_target = 'lfsr';
    f_path = "test_cases_{}.csv".format(gen_target)

    all_lines = []

    f = open(f_path, 'w')
    
    data = [0,0,0,0,0,0,0,0,0,0]

    # combination 1: r = 1, e = 1
    lines_lst, data = lines_gen('re', data, 5)
    all_lines.extend(lines_lst)

    # combination 2: r = 1. e = 0
    # verification: reset is precedent over enable
    lines_lst, data = lines_gen('r', data, 5)
    all_lines.extend(lines_lst)

    # combination 3: r = 0, e = 1
    lines_lst, data = lines_gen('e', data, 70)
    all_lines.extend(lines_lst)

    # combination 4: r = 0, e = 0
    # also corner case: stop counting
    lines_lst, data = lines_gen('x', data, 5)
    all_lines.extend(lines_lst)

    # corner case: reset while counting
    lines_lst, data = lines_gen('e', data, 5)
    all_lines.extend(lines_lst)

    lines_lst, data = lines_gen('re', data, 5)
    all_lines.extend(lines_lst)

    lines_lst, data = lines_gen('e', data, 5)
    all_lines.extend(lines_lst)

    # corner case: reset while not counting
    lines_lst, data = lines_gen('x', data, 5)
    all_lines.extend(lines_lst)

    lines_lst, data = lines_gen('r', data, 5)
    all_lines.extend(lines_lst)

    print(len(all_lines))

    for line in all_lines:
        f.write(line)
    
    f.close()
    print("File generated.")
