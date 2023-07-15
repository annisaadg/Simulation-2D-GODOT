class_name transformasi extends matrix
			
#scale
func scale2(sx: float, sy: float, refpt: Vector2):
	var m=[[0,0,0],[0,0,0],[0,0,0]]
	
	matrix3x3SetIdentity(m)
	m[0][0] = sx
	m[0][2] = (1 - sx) * refpt.x
	m[1][1] = sy
	m[1][2] = (1 - sy) * refpt.y
	matrix3x3PreMultiply(m, theMatrix)
	
#rotation
func rotate2(a: float, refpt: Vector2):
	var m=[[0,0,0],[0,0,0],[0,0,0]]
	
	matrix3x3SetIdentity(m)
	a = deg2rad(a)
	m[0][0] = cos(a)
	m[0][1] = -sin(a)
	m[0][2] = refpt.x * (1 - cos(a)) + refpt.y * sin(a)
	m[1][0] = sin(a)
	m[1][1] = cos(a)
	m[1][2] = refpt.y * (1 - cos(a)) - refpt.x * sin(a)
	matrix3x3PreMultiply(m, theMatrix)

#translation
func translate2(tx: int, ty: int):
	var m=[[0,0,0],[0,0,0],[0,0,0]]

	matrix3x3SetIdentity(m)
	m[0][2] = tx
	m[1][2] = ty
	matrix3x3PreMultiply(m, theMatrix)

#transform
func transformPoints2(npts: int, pts: PoolVector2Array):
	var tmp
	
	for k in range(npts):
		tmp = theMatrix[0][0] * pts[k].x + theMatrix[0][1] * pts[k].y + theMatrix[0][2]
		pts[k].y = theMatrix[1][0] * pts[k].x + theMatrix[1][1] * pts[k].y + theMatrix[1][2]
		pts[k].x = tmp
	return pts

