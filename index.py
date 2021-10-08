from minizinc import Instance, Model, Solver

# Load n-Queens model from file
bowling = Model("./bowling.mzn")

# Find the MiniZinc solver configuration for Gecode
gecode = Solver.lookup("gecode")

# Create an Instance of the n-Queens model for Gecode
instance = Instance(gecode, bowling)

# Assign 4 to n
instance["cible"] = 220
result = instance.solve()
# Output the array q
print(result)