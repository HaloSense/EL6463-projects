import random

hex_set = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
def gen_hex_str(str_len = 16):

    
    str_hex = ""

    for i in range(str_len):
        str_hex = str_hex + hex_set[random.randint(0, 15)]

    if len(str_hex) != str_len:
        print("Output length incorrect!")
        return "0000000000000000"
    else:
        return str_hex