import numpy as np
import scipy.stats
import matplotlib.pyplot as plt

from hdc.hypervector import *
from hdc.train import *
from hdc.encoder import *

N = 10_000

print("Create a Hypervector")
x = HV_Rand(N, type="bipolar")
print(x)

print("Create another Hypervector")
y = HV_Rand(N, type="bipolar")
print(y)

print("We expect about half of the elements of two randomly-chosen wectors to match")
vec_sum = np.sum(x.hv == y.hv)
print(f"{vec_sum} matching elements")
similarity = x.cosine_similarity(y)
print(f"cosine similarity: {similarity}")


print("\n\nOur first option is Bundling (Aggregation), for bipolar vectors we use element-wise majority")
bundler = Bundler("majority")
bundle_vec = bundler.bundle(x,y)
print(bundle_vec)

print("\n\nOur second option is Binding, for bipolar vectors we use element-wise multiplication")
binder = Binder("multiply")
bind_vec = binder.bind(x,y)
print(bind_vec)
print("Binding is also reversable, in this case we will recover the first Hypervector we created (x)")
rec_vec = binder.bind(bind_vec, y)
print(rec_vec)

print("\n\nOur last option is Shifting. This creates a new vector almost orthogonal to the original")
shift_vec = x << 1
shift_sum = np.sum(x.hv == shift_vec.hv)
print(shift_vec)
print(f"{shift_sum} matching elements")
shift_similarity = x.cosine_similarity(shift_vec)
print(f"cosine similarity: {shift_similarity}")

print("\n\nWe can also encode a range of values instead of a single value (say a set of HVs for a number from 1-10 instead of a single HV for an Apple)")
print("We do this by first splitting the range into k sections, then we generate a random HV and split it into k sections")
print("For every step through the sections in our number range, we replace a new part of the HV with new random entries")
enc = Encoder()
enc.create_range_encoding("test", "binary", 10000, 0, 10, 10)
a1 = enc.encode_range("test", 1)
a2 = enc.encode_range("test", 2)
a3 = enc.encode_range("test", 3)
a4 = enc.encode_range("test", 4)
a5 = enc.encode_range("test", 5)
a6 = enc.encode_range("test", 6)
a7 = enc.encode_range("test", 7)
a8 = enc.encode_range("test", 8)
a9 = enc.encode_range("test", 9)
a10 = enc.encode_range("test", 10)
def cs(a: Hypervector, b: Hypervector):
    return a.cosine_similarity(b)
mat = [
    [cs(a10, a1), cs(a10, a2), cs(a10, a3), cs(a10, a4), cs(a10, a5), cs(a10, a6), cs(a10, a7), cs(a10, a8), cs(a10, a9), cs(a10, a10)],
    [cs(a9, a1), cs(a9, a2), cs(a9, a3), cs(a9, a4), cs(a9, a5), cs(a9, a6), cs(a9, a7), cs(a9, a8), cs(a9, a9), cs(a9, a10)],
    [cs(a8, a1), cs(a8, a2), cs(a8, a3), cs(a8, a4), cs(a8, a5), cs(a8, a6), cs(a8, a7), cs(a8, a8), cs(a8, a9), cs(a8, a10)],
    [cs(a7, a1), cs(a7, a2), cs(a7, a3), cs(a7, a4), cs(a7, a5), cs(a7, a6), cs(a7, a7), cs(a7, a8), cs(a7, a9), cs(a7, a10)],
    [cs(a6, a1), cs(a6, a2), cs(a6, a3), cs(a6, a4), cs(a6, a5), cs(a6, a6), cs(a6, a7), cs(a6, a8), cs(a6, a9), cs(a6, a10)],
    [cs(a5, a1), cs(a5, a2), cs(a5, a3), cs(a5, a4), cs(a5, a5), cs(a5, a6), cs(a5, a7), cs(a5, a8), cs(a5, a9), cs(a5, a10)],
    [cs(a4, a1), cs(a4, a2), cs(a4, a3), cs(a4, a4), cs(a4, a5), cs(a4, a6), cs(a4, a7), cs(a4, a8), cs(a4, a9), cs(a4, a10)],
    [cs(a3, a1), cs(a3, a2), cs(a3, a3), cs(a3, a4), cs(a3, a5), cs(a3, a6), cs(a3, a7), cs(a3, a8), cs(a3, a9), cs(a3, a10)],
    [cs(a2, a1), cs(a2, a2), cs(a2, a3), cs(a2, a4), cs(a2, a5), cs(a2, a6), cs(a2, a7), cs(a2, a8), cs(a2, a9), cs(a2, a10)],
    [cs(a1, a1), cs(a1, a2), cs(a1, a3), cs(a1, a4), cs(a1, a5), cs(a1, a6), cs(a1, a7), cs(a1, a8), cs(a1, a9), cs(a1, a10)]
]
plt.imshow(mat, cmap='hot', interpolation='nearest')
plt.title("Cosine Similarity Matrix for a Range Encoding")
plt.show()