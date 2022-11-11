from hex_strgen import gen_hex_str

output_file = "plaintext.txt"

case_num = 105

f = open(output_file, 'w')

for i in range(case_num):
    cur_str = gen_hex_str()
    f.write(cur_str + '\n')

print("Plaintext file write complete.")
f.close()
