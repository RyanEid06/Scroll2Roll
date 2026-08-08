# Plinko Probability and Multiplier Audit

Scroll2Roll Plinko uses a fair deterministic left/right engine step at every
row. A board with `n` rows has `2^n` equally likely paths and bucket `k` has
exact probability `C(n, k) / 2^n`. The engine result is generated before
animation; rendering follows the stored path.

Multipliers are integer basis points (`10000` = 1.00x). Settlement is
`floor(stake * multiplier / 10000)`. The profiles start from symmetric scores:

- Low: `10000 + distance^2 * 100`.
- Medium: `5000 + distance^2 * 300`.
- High: `1000 + distance^4 * 10`.

Here `distance = abs(2 * bucket - rows)`. Every score table is normalized to a
target 9600-basis-point return using exact binomial weights, then each bucket is
floored to an integer basis-point multiplier. The resulting exact theoretical
return is 9599 basis points for every table except 10-row Medium, which is 9600.
Tests recompute these values from the shipped engine formulas for every row and
risk profile.

The tables below list buckets from left edge to right edge. Values are basis
points and are intentionally symmetric.

| Rows | Risk | Expected BP | Bucket multipliers (basis points) |
| ---: | --- | ---: | --- |
| 8 | Low | 9599 | 14577, 12088, 10311, 9244, 8888, 9244, 10311, 12088, 14577 |
| 8 | Medium | 9599 | 31394, 20497, 12713, 8043, 6486, 8043, 12713, 20497, 31394 |
| 8 | High | 9599 | 145947, 48556, 12382, 4034, 3478, 4034, 12382, 48556, 145947 |
| 9 | Low | 9599 | 15941, 13122, 11009, 9600, 8895, 8895, 9600, 11009, 13122, 15941 |
| 9 | Medium | 9599 | 36529, 24561, 15584, 9600, 6607, 6607, 9600, 15584, 24561, 36529 |
| 9 | High | 9599 | 196755, 73875, 21415, 5346, 2983, 2983, 5346, 21415, 73875, 196755 |
| 10 | Low | 9599 | 17454, 14312, 11869, 10123, 9076, 8727, 9076, 10123, 11869, 14312, 17454 |
| 10 | Medium | 9600 | 42000, 29040, 18960, 11760, 7440, 6000, 7440, 11760, 18960, 29040, 42000 |
| 10 | High | 9599 | 255157, 106004, 35267, 8993, 2930, 2526, 2930, 8993, 35267, 106004, 255157 |
| 11 | Low | 9599 | 19113, 15654, 12886, 10810, 9427, 8735, 8735, 9427, 10810, 12886, 15654, 19113 |
| 11 | Medium | 9599 | 47768, 33889, 22785, 14457, 8906, 6130, 6130, 8906, 14457, 22785, 33889, 47768 |
| 11 | High | 9599 | 320892, 145001, 54443, 15782, 3940, 2198, 2198, 3940, 15782, 54443, 145001, 320892 |
| 12 | Low | 9599 | 20914, 17142, 14057, 11657, 9942, 8914, 8571, 8914, 9942, 11657, 14057, 17142, 20914 |
| 12 | Medium | 9599 | 53804, 39069, 27013, 17637, 10939, 6920, 5581, 6920, 10939, 17637, 27013, 39069, 53804 |
| 12 | High | 9599 | 393751, 190866, 79294, 26381, 6727, 2192, 1889, 2192, 6727, 26381, 79294, 190866, 393751 |
| 13 | Low | 9599 | 22853, 18775, 15376, 12658, 10619, 9260, 8580, 8580, 9260, 10619, 12658, 15376, 18775, 22853 |
| 13 | Medium | 9599 | 60080, 44548, 31604, 21249, 13483, 8305, 5716, 5716, 8305, 13483, 21249, 31604, 44548, 60080 |
| 13 | High | 9599 | 473572, 243569, 110061, 41324, 11979, 2990, 1668, 1668, 2990, 11979, 41324, 110061, 243569, 473572 |
| 14 | Low | 9599 | 24926, 20547, 16842, 13810, 11452, 9768, 8757, 8421, 8757, 9768, 11452, 13810, 16842, 20547, 24926 |
| 14 | Medium | 9599 | 66573, 50295, 36521, 25252, 16486, 10226, 6469, 5217, 6469, 10226, 16486, 25252, 36521, 50295, 66573 |
| 14 | High | 9599 | 560232, 303069, 146909, 61032, 20305, 5178, 1687, 1454, 1687, 5178, 20305, 61032, 146909, 303069, 560232 |
| 15 | Low | 9599 | 27130, 22455, 18448, 15109, 12438, 10434, 9099, 8431, 8431, 9099, 10434, 12438, 15109, 18448, 22455, 27130 |
| 15 | Medium | 9599 | 73263, 56286, 41734, 29608, 19907, 12631, 7781, 5355, 5355, 7781, 12631, 19907, 29608, 41734, 56286, 73263 |
| 15 | High | 9599 | 653637, 369322, 189951, 85833, 32227, 9342, 2332, 1301, 1301, 2332, 9342, 32227, 85833, 189951, 369322, 653637 |
| 16 | Low | 9599 | 29462, 24496, 20193, 16551, 13572, 11255, 9600, 8606, 8275, 8606, 9600, 11255, 13572, 16551, 20193, 24496, 29462 |
| 16 | Medium | 9599 | 80130, 62497, 47216, 34285, 23706, 15477, 9600, 6073, 4897, 6073, 9600, 15477, 23706, 34285, 47216, 62497, 80130 |
| 16 | High | 9599 | 753714, 442288, 239265, 115980, 48183, 16030, 4088, 1332, 1148, 1332, 4088, 16030, 48183, 115980, 239265, 442288, 753714 |

These are play-money entertainment tables, not promises of short-session
results. Individual deterministic paths may land at any bucket, and credits
have no monetary value.
