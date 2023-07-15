class_name matrix extends Node2D

#matrix
var theMatrix=[[0,0,0],[0,0,0],[0,0,0]]
			
func matrix3x3Add(Ma, Mb):
	for r in range(3):
		for c in range(3):
			Mb[r][c] += Ma[r][c]

func matrix3x3Sub(Ma, Mb):
	for r in range(3):
		for c in range(3):
			Mb[r][c] -= Ma[r][c]

func matrix3x3PreMultiply(Ma, Mb):
	var Mtemp=[[0,0,0],[0,0,0],[0,0,0]]
	
	for r in range(3):
		for c in range(3):
			Mtemp[r][c] = Ma[r][0]*Mb[0][c] + Ma[r][1]*Mb[1][c] + Ma[r][2]*Mb[2][c]
			
	for r in range(3):
		for c in range(3):
			Mb[r][c] = Mtemp[r][c]

func matrix3x3SetIdentity(m):
	for i in range(3):
		for j in range(3):
			if(i==j):
				m[i][j] = 1
			else:
				m[i][j] = 0


