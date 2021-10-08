from minizinc import Instance, Model, Solver

def solveInstance(cible: int):
    # define the constants
    file_name = "./bowling.mzn"
    solver_name = "gecode"

    # Load n-Queens model from file
    bowling = Model(file_name)

    # Find the MiniZinc solver configuration for Gecode
    gecode = Solver.lookup(solver_name)

    # Create an Instance of the n-Queens model for Gecode
    instance = Instance(gecode, bowling)

    # Map cible parameter to the mzn variable
    instance["cible"] = cible

    # solve and return the string list result
    result = instance.solve()
    return result

# result = solveInstance(140)
# print(type(result))