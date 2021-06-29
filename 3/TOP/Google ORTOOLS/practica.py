#Libreria
from ortools.linear_solver import pywraplp

solver = pywraplp.Solver.CreateSolver('SCIP')

M1 = solver.BoolVar('M1')
M2 = solver.BoolVar('M2')
M3 = solver.BoolVar('M3')
M4 = solver.BoolVar('M4')
M5 = solver.BoolVar('M5')
M6 = solver.BoolVar('M6')
M7 = solver.BoolVar('M7')
M8 = solver.BoolVar('M8')

G1 = solver.BoolVar('G1')
G2 = solver.BoolVar('G2')
G3 = solver.BoolVar('G3')
G4 = solver.BoolVar('G4')
G5 = solver.BoolVar('G5')
G6 = solver.BoolVar('G6')
G7 = solver.BoolVar('G7')
G8 = solver.BoolVar('G8')

Y = solver.BoolVar('Y')

solver.Minimize(300*(M1+M2+M3+M4+M5+M6+M7+M8) + 500*(G1+G2+G3+G4+G5+G6+G7+G8) - 300*Y)

solver.Add(G1+G2+G3+G4+G5+G6+G7+G8 <= 2)
solver.Add(M1+M2+M3+M4+M5+M6+M7+M8 >= 3*Y)

solver.Add(M1+G1 >= 1)
solver.Add(G1+G2+G3+G4+G5+M3+M5 >= 1)
solver.Add(G5+G6+G7+G8+M7>=1)
solver.Add(G2+G4+M2+M4 >= 1)
solver.Add(G2+G3+G4+G5+G6+M3+M4+M6 >= 1)
solver.Add(G6+G7+G8+M6+M7+M8 >= 1)

solver.Add(G1+M1 <= 1)
solver.Add(G2+M2 <= 1)
solver.Add(G3+M3 <= 1)
solver.Add(G4+M4 <= 1)
solver.Add(G5+M5 <= 1)
solver.Add(G6+M6 <= 1)
solver.Add(G7+M7 <= 1)
solver.Add(G8+M8 <= 1)

print("Numero de restricciones =", solver.NumConstraints())

status = solver.Solve();

if status == solver.OPTIMAL:
        print(solver.Objective().Value())
        print(M1.solution_value())
        print(M2.solution_value())
        print(M3.solution_value())
        print(M4.solution_value())
        print(M5.solution_value())
        print(M6.solution_value())
        print(M7.solution_value())
        print(M8.solution_value())
        print(G1.solution_value())
        print(G2.solution_value())
        print(G3.solution_value())
        print(G4.solution_value())
        print(G5.solution_value())
        print(G6.solution_value())
        print(G7.solution_value())
        print(G8.solution_value())
        print(Y.solution_value())