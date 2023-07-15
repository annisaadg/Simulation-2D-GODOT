class_name primitif extends Reference

func lineDDA(xa : float, ya : float, xb : float, yb : float):
	print(xa)
	print(yb)
	var dx = xb - xa
	var dy = yb - ya
	var steps
	var xIncrement
	var yIncrement
	var x = xa
	var y = ya
	var res = PoolVector2Array()
	if (abs(dx) > abs(dy)) :
		steps = abs(dx)
	else : 
		steps = abs(dy)
	xIncrement = dx/ float(steps)
	yIncrement = dy/ float(steps)
	res.append(Vector2(round(x), round(y)))
	for k in steps:
		x += xIncrement
		y += yIncrement
		res.append(Vector2(round(x), round(y)))
	return res
	
func lineBersenham(xa : int, ya : int, xb : int, yb : int):
	var dx = abs(xa - xb)
	var dy = abs(ya - yb)
	var delta = dy - dx
	var p = 2 * dy - dx
	var twoDy = 2 * dy
	var twoDx = 2 * delta
	var x
	var y
	var xEnd
	var yEnd
	
	var res = PoolVector2Array()
	
	if xa > xb:
		x = xb
		y = yb
		xEnd = xa
	else:
		x = xa
		y = ya
		xEnd = xb
		
	res.append(Vector2(x, y))
	
	if xa == xb:
		x = xa
		y = ya
		yEnd = yb
		while y < yEnd :
			y += 1
			if p < 0 :
				p += twoDx
			else : 
				y += 1
				p += twoDy
			res.append(Vector2(x, y))
	else:
		while x < xEnd :
			x += 1
			if p < 0 :
				p += twoDy
			else : 
				y += 1
				p += twoDx
			res.append(Vector2(x, y))
		
	return res
	
func lineMidpoint(xa : int, ya : int, xb : int, yb : int):
	
	var dy = abs(yb-ya)
	var dx = abs(xb-xa)
	var d = 2 * dy - dx
	var incrE = 2 * dy
	var incrNE = 2 * (dy - dx)
	var x = xa;
	var y = ya;
	
	var res = PoolVector2Array()
	res.append(Vector2(x, y))
	
	if (dy <= dx):
		while ( x < xb):
			if(d <= 0):
				d += incrE
				x += 1
			else:
				d += incrNE
				x += 1
				y += 1
			res.append(Vector2(x, y))
			
	if (dx < dy):
		while ( y < yb):
			if(d <= 0):
				d += incrE
				y += 1
			else:
				d += incrNE
				y += 1
			res.append(Vector2(x, y))
	return res

# world coordinat to pixel coordinat untuk bentuk dasar
func convert_to_pixel(xa, ya, xb, yb, margin_left, margin_top):
	xa = margin_left+xa
	xb = margin_left+xb
	ya = OS.window_size.y -margin_top - ya
	yb = OS.window_size.y -margin_top - yb
	return [xa,ya,xb,yb]
	
func line_style(res, type, gap):
	var buffer = PoolVector2Array()
	var dash = 10
	var dot = 1
	
	var count = 0	
	for i in res.size():
		match type:
			# dash-dash
			1: 
				if (count < dash):
					buffer.append_array([res[i]])
					count += 1
				elif (count >= dash && count < dash+gap):
					count += 1
				else:
					count = 0

			# point-point
			2: 
				if (count < dot):
					buffer.append_array([res[i]])
					count+=1
				elif (count >= dot && count < dot+gap):
					count+=1
				else:
					count = 0
			
			# point-dash
			3: 
				if(count < dot):
					buffer.append_array([res[i]])
					count += 1
				elif(count >= dot && count < dot+gap):
					count += 1
				elif(count >= dot+gap && count < dash):
					buffer.append_array([res[i]])
					count +=1
				elif (count >= dash && count < dash+gap):
					count +=1
				else:
					count = 0
	return buffer
