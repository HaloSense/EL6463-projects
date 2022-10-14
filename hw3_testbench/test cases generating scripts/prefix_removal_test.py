a = 93
b = bin(a)
b_str = str(b)
b_str = b_str.removeprefix('0b')
b_bin = '{:016b}'.format(a)

print(a)
print(b)
print(b_str)
print(b_bin)