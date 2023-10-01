import numpy as np

from hdc.hypervector import HV_Rand
from hdc.encoder import ENC_ExtendMultiplyRnd

a = HV_Rand(dimension=1000)
b = HV_Rand(dimension=1000)
print(f"a[0] - {a[0]}")
print(f"a[:10] - {a[:10]}")
print(f"b[:10] - {b[:10]}")
c = a + b
print(f"c[:10] - {c[:10]}")
c <<= 5
print(f"c[:10] - {c[:10]}")

sim = a.cosine_similarity(b)
print(f"cosine similarity: {sim}")

#APPLE = np.array([15])
APPLE = np.arange(15, 150, 1)
#ORAGE = np.array([16])
ORAGE = np.arange(20, 155, 1)
#BANANA = np.array([17])
BANANA = np.arange(25, 160, 1)
#PEAR = np.array([18])
PEAR = np.arange(30, 165, 1)
#KIWI = np.array([19])
KIWI = np.arange(35, 170, 1)

#POTATO = np.array([990])
POTATO = np.arange(200, 400, 2)
#ZUCCINI = np.array([991])
ZUCCINI = np.arange(300, 500, 2)
#BROCCOLI = np.array([992])
BROCCOLI = np.arange(400, 600, 2)
#BEAN = np.array([993])
BEAN = np.arange(500, 700, 2)
#ASPARAGUS = np.array([994])
ASPARAGUS = np.arange(600, 800, 2)

apple_hv = ENC_ExtendMultiplyRnd(APPLE, 1000).get_hv()
#apple_hv <<= 0
orange_hv = ENC_ExtendMultiplyRnd(ORAGE, 1000).get_hv()
#orange_hv <<= 1
banana_hv = ENC_ExtendMultiplyRnd(BANANA, 1000).get_hv()
#banana_hv <<= 2
pear_hv = ENC_ExtendMultiplyRnd(PEAR, 1000).get_hv()
#pear_hv <<= 3
kiwi_hv = ENC_ExtendMultiplyRnd(KIWI, 1000).get_hv()
#kiwi_hv <<= 4

potato_hv = ENC_ExtendMultiplyRnd(POTATO, 1000).get_hv()
#potato_hv <<= 0
zuccini_hv = ENC_ExtendMultiplyRnd(ZUCCINI, 1000).get_hv()
#zuccini_hv <<= 1
broccoli_hv = ENC_ExtendMultiplyRnd(BROCCOLI, 1000).get_hv()
#broccoli_hv <<= 2
bean_hv = ENC_ExtendMultiplyRnd(BEAN, 1000).get_hv()
#bean_hv <<= 3
asparagus_hv = ENC_ExtendMultiplyRnd(ASPARAGUS, 1000).get_hv()
#asparagus_hv <<= 4


fruit_hv = apple_hv + orange_hv + banana_hv + pear_hv + kiwi_hv
#fruit_hv = apple_hv + (orange_hv << 1) + (banana_hv << 2) + (pear_hv << 3) + (kiwi_hv << 4)
vegetable_hv = potato_hv + zuccini_hv + broccoli_hv + asparagus_hv
#vegetable_hv = potato_hv + (zuccini_hv << 1) + (broccoli_hv << 2) + (bean_hv << 3) + (asparagus_hv << 4)


print("\n\nTesting With A Known HV:\n")
#test_hv = ENC_ExtendMultiplyRnd(APPLE, 1000).get_hv()
test_hv = potato_hv

fruit_sim = test_hv.cosine_similarity(fruit_hv)
vegetable_sim = test_hv.cosine_similarity(vegetable_hv)
print(f"Fruit Sim: {fruit_sim}")
print(f"Vegetable Sim: {vegetable_sim}")
if fruit_sim > vegetable_sim:
    print("I Think This Is A Fruit")
else:
    print("I Think This Is A Vegetable")

print("\n\nTesting With An Unknown HV:\n")
ARTICHOKE = np.arange(601, 801, 2) << 1
test2_hv = ENC_ExtendMultiplyRnd(ARTICHOKE, 1000).get_hv()

fruit_sim2 = test2_hv.cosine_similarity(fruit_hv)
vegetable_sim2 = test2_hv.cosine_similarity(vegetable_hv)
print(f"Fruit Sim: {fruit_sim}")
print(f"Vegetable Sim: {vegetable_sim}")
if fruit_sim > vegetable_sim:
    print("I Think This Is A Fruit")
else:
    print("I Think This Is A Vegetable")