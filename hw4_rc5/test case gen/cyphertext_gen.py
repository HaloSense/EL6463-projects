from simple_function_rc5 import simple_function_rc5

fin_name = "plaintext.txt"
fout_name = "cyphertext.txt"

fin = open(fin_name, 'r')
fout = open(fout_name, 'w')

lines = fin.read().splitlines()

for line in lines:
    line_in = int(line, 16)
    result = simple_function_rc5(line_in)
    line_out = hex(result)[2:]
    fout.write(str(line_out) + '\n')

print("Ciphertext write complete.")
fin.close()
fout.close()