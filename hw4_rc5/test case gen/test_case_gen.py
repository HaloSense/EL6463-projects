import sys

def test_case_gen(fp_name, fc_name, fo_name, p2c):
    fp = open(fp_name, 'r')
    fc = open(fc_name, 'r')
    fo = open(fo_name, 'w')

    rst = '0'
    # in_vld = '1'
    out_vld = '1'

    if p2c != 0 and p2c != 1:
        sys.stderr.write("Parameter \"p2c\" has to be 0 for plain -> cipher or 1 for cipher -> plain.")
        raise SystemExit(1)

    fp_lines = fp.read().splitlines()
    fc_lines = fc.read().splitlines()

    line_num = len(fp_lines)

    if (line_num != len(fc_lines)):
        sys.stderr.write("Input files sizes don't match.")
        raise SystemExit(1)

    for i in range(line_num):
        line_p = fp_lines[i]
        line_c = fc_lines[i]
        
        if p2c:
            # line_o = rst + ',' + in_vld + ',' + line_c + ',' + out_vld + ',' + line_p
            line_o = rst + ',' + line_c + ',' + out_vld + ',' + line_p
        else:
            # line_o = rst + ',' + in_vld + ',' + line_p + ',' + out_vld + ',' + line_c
            line_o = rst + ',' + line_p + ',' + out_vld + ',' + line_c

        fo.write(line_o + '\n')

    print("Test cases writing complete.")
    fp.close()
    fc.close()
    fo.close()

if __name__ == "__main__":

    fp_name = "plaintext.txt"
    fc_name = "cyphertext.txt"
    fo1_name = "p2c_test_cases.csv"
    fo2_name = "c2p_test_cases.csv"

    test_case_gen(fp_name, fc_name, fo1_name, 0)
    test_case_gen(fp_name, fc_name, fo2_name, 1)

    