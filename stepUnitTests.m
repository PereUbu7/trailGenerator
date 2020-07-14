[nextPoint, gradient] = step(@(x, y, z) [1 0.1 1], [1 1 1], [1 1 1], 0.5, 1, 1, 1);
assert(gradient == [1 0.1 1], "Error");