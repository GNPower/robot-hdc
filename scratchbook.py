

import struct
def binary(num):
    return ''.join('{:0>8b}'.format(c) for c in struct.pack('!f', num))

print(binary(3))

one   = "00111111100000000000000000000000"
two   = "01000000000000000000000000000000"
three = "01000000010000000000000000000000"