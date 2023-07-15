class_name dasar extends primitif

var trans = transformasi.new()

export var margin_left = 50
export var margin_top  = 50

var screen_width = OS.window_size.x 
var screen_height = OS.window_size.y

func persegi(xa, ya, s):
	var res = PoolVector2Array()
	# Kiri Bawah ke Kiri Atas (Sisi Kiri)
	var px = convert_to_pixel(xa, ya, xa, ya+s, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kiri Atas ke Kanan Atas (Sisi Atas)
	px = convert_to_pixel(xa, ya+s, xa+s, ya+s, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Atas ke Kanan Bawah (Sisi Kanan)
	px = convert_to_pixel(xa+s, ya+s, xa+s, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Bawah ke Kiri Bawah (Sisi Bawah)
	px = convert_to_pixel(xa+s, ya, xa, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	return res

func persegipanjang(xa, ya, p, l):
	var res = PoolVector2Array()
	# Kiri Bawah ke Kiri Atas (Sisi Kiri)
	var px = convert_to_pixel(xa, ya, xa, ya+l, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kiri Atas ke Kanan Atas (Sisi Atas)
	px = convert_to_pixel(xa, ya+l, xa+p, ya+l, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Atas ke Kanan Bawah (Sisi Kanan)
	px = convert_to_pixel(xa+p, ya+l, xa+p, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Bawah ke Kiri Bawah (Sisi Bawah)
	px = convert_to_pixel(xa+p, ya, xa, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	return res

func trapesium_siku(xa, ya, sisi):
	var res = PoolVector2Array()
	var kurang = sisi/2
	# Kiri Bawah ke Kanan Bawah (Sisi Bawah)
	var px = convert_to_pixel(xa, ya, xa+sisi, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Bawah ke Kanan Atas (Sisi Miring Kanan)
	px = convert_to_pixel(xa+sisi, ya, xa+sisi-kurang, ya+sisi, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Atas ke Kiri Atas (Sisi Bawah)
	px = convert_to_pixel(xa+sisi-kurang, ya+sisi, xa, ya+sisi, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kiri Atas ke Kiri Bawah
	px = convert_to_pixel(xa, ya+sisi, xa, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	return res

func segitiga_siku(xa, ya, sisi):
	var res = PoolVector2Array()
	var kurang = sisi/2
	# Kiri Bawah ke Kiri Atas (Sisi Kiri)
	var px = convert_to_pixel(xa, ya, xa+kurang, ya+kurang, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kiri Atas ke bawah (Sisi Miring)
	px = convert_to_pixel(xa+kurang, ya+kurang, xa+kurang, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Bawah ke Kiri (Sisi Bawah)
	px = convert_to_pixel(xa, ya, xa+kurang, ya, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	return res

func circle(xp, yp, radius, full):
	var x = 0
	var y = radius
	var p = 1 - radius
	var res = PoolVector2Array()
	var px
	if full == 1:
		res.append_array(_circle_plot(xp, yp, x, y))
	elif full == 0:
		res.append_array(_half_circle_plot(xp, yp, x, y))

	while (x < y):
		x += 1
		if (p < 0):
			p += 2 * x + 1
		else:
			y -= 1
			p += 2 * (x - y) + 1
		if full == 1:
			res.append_array(_circle_plot(xp, yp, x, y))
		elif full == 0:
			res.append_array(_half_circle_plot(xp, yp, x, y))
	return res

func _circle_plot(xp, yp, x, y):
	var res = PoolVector2Array()

	res.append(Vector2(xp + x, yp + y))
	res.append(Vector2(xp - x, yp + y))
	res.append(Vector2(xp + x, yp - y))
	res.append(Vector2(xp - x, yp - y))

	res.append(Vector2(xp + y, yp + x))
	res.append(Vector2(xp - y, yp + x))
	res.append(Vector2(xp + y, yp - x))
	res.append(Vector2(xp - y, yp - x))
	
	return res

func _half_circle_plot(xp, yp, x, y):
	var res = PoolVector2Array()

	res.append(Vector2(xp + x, yp + y))
	res.append(Vector2(xp + x, yp - y))
	res.append(Vector2(xp + y, yp + x))
	res.append(Vector2(xp + y, yp - x))
	
	return res

func ellipse(xp, yp, Rx, Ry):
	var Rx2 = Rx*Rx
	var Ry2 = Ry*Ry
	var twoRx2 = 2*Rx2
	var twoRy2 = 2*Ry2
	var p 
	var x = 0
	var y = Ry
	var px = 0
	var py = twoRx2 * y
	var res = PoolVector2Array()

	res.append_array(_ellipse_plot(xp, yp, x, y))

	# Region 1
	p = round(Ry2 - (Rx2 * Ry) + (0.25 * Rx2))
	while (px < py):
		x += 1
		px += twoRy2
		if (p < 0):
			p += Ry2 + px
		else:
			y -= 1
			py -= twoRx2
			p += Ry2 + px - py
		res.append_array(_ellipse_plot(xp, yp, x, y))
		
	# Region 2
	p = round(Ry2 * (x+0.5) * (x+0.5) + Rx2 * (y-1) * (y-1) - Rx2 * Ry2)
	while (y > 0):
		y -= 1
		py -= twoRx2
		if (p > 0):
			p += Rx2 - py
		else:
			x += 1
			px += twoRy2
			p += Rx2 - py + px
		res.append_array(_ellipse_plot(xp, yp, x, y))
	return res

func _ellipse_plot(xp, yp, x, y):
	var res = PoolVector2Array()
	
	res.append(Vector2(xp + x, yp + y))
	res.append(Vector2(xp - x, yp + y))
	res.append(Vector2(xp + x, yp - y))
	res.append(Vector2(xp - x, yp - y))
	
	return res

func baju(midpoint, size):
	var res = PoolVector2Array()
	var p = 80*size 	# panjang sisi
	var l = 100*size	# lebar sisi
	# Kiri Bawah ke Kiri Atas (Sisi Kiri)
	var px = convert_to_pixel(midpoint.x, midpoint.y, midpoint.x, (midpoint.y)+l, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Atas ke Kanan Bawah (Sisi Kanan)
	px = convert_to_pixel((midpoint.x)+p, (midpoint.y)+l, (midpoint.x)+p, midpoint.y, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Kanan Bawah ke Kiri Bawah (Sisi Bawah)
	px = convert_to_pixel((midpoint.x)+p, midpoint.y, midpoint.x, midpoint.y, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Lengan Kiri
	px = convert_to_pixel(midpoint.x, (midpoint.y)+l, (midpoint.x)-(p/2), (midpoint.y)+(l/1.3), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	px = convert_to_pixel((midpoint.x)-(p/2), (midpoint.y)+(l/1.3), (midpoint.x)-(p/1.5), (midpoint.y)+(l*1.1), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	px = convert_to_pixel((midpoint.x)-(p/1.5), (midpoint.y)+(l*1.1), midpoint.x, (midpoint.y)+(l*1.4), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Lengan Kanan
	px = convert_to_pixel((midpoint.x)+p, (midpoint.y)+l, (midpoint.x)+p+(p/2), (midpoint.y)+(l/1.3), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	px = convert_to_pixel((midpoint.x)+p+(p/2), (midpoint.y)+(l/1.3), (midpoint.x)+p+(p/1.5), (midpoint.y)+(l*1.1), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	px = convert_to_pixel((midpoint.x)+p+(p/1.5), (midpoint.y)+(l*1.1), (midpoint.x)+p, (midpoint.y)+(l*1.4), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Bagian Bahu
	px = convert_to_pixel(midpoint.x, (midpoint.y)+(l*1.4), (midpoint.x)+(p/4), (midpoint.y)+(l*1.4), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	px = convert_to_pixel((midpoint.x)+p, (midpoint.y)+(l*1.4), (midpoint.x)+(3*p/4), (midpoint.y)+(l*1.4), margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	# Bagian Neck
	px = convert_to_pixel((midpoint.x)+(p/4), (midpoint.y)+(l*1.4), (midpoint.x)+(p/2), (midpoint.y)+(l*1.4)-10, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	px = convert_to_pixel((midpoint.x)+(3*p/4), (midpoint.y)+(l*1.4), (midpoint.x)+(p/2), (midpoint.y)+(l*1.4)-10, margin_left, margin_top)
	res.append_array(lineDDA(px[0], px[1], px[2], px[3]))
	
	return res	

func machine(midpoint,size):
	var p = 200*size	# panjang sisi
	var l = 400*size	# lebar sisi
	var res = PoolVector2Array()
	
	# KERANGKA MESIN UTAMA -> OBJEK 1
	var machine = persegipanjang(midpoint.x,midpoint.y,p,l)
	res.append_array(machine)
	
	# SHADOW PERSPECTIVE 
	var machine2 = persegipanjang(midpoint.x-p*0.2,midpoint.y,p*0.2,l*0.9)
	res.append_array(machine2)
	
	# SHADOW PERSPECTIVE LENGKUNGAN
	var machine3 = segitiga_siku((midpoint.x)-(0.2*p),midpoint.y+(l*0.9),2*(0.2*p))
	res.append_array(machine3)
	
	return res

func machine_inside(midpoint, size):
	var p1 = 200*size	# sisi panjang 1
	var l1 = 400*size	# sisi lebar 1
	var p2 = 0.7*p1		# sisi panjang 2
	var l2 = 0.7*l1		# sisi lebar 2
	var p3 = 1.5*l1		# sisi panjang 3
	var l3 = 0.3*p1		# sisi lebar 3
	var beda_p = p1-p2	# jarak antara titik awal sisi panjang 1 dan sisi panjang 2
	var beda_l = l1-l2	# jarak antara titik awal sisi lebar 1 dan sisi lebar 2
	var res = PoolVector2Array()
	
	# BOLONGAN MESIN
	var machine = persegipanjang(midpoint.x+(beda_p/2),midpoint.y+(beda_l/1.5),p2,l2)
	res.append_array(machine)
	
	# CONVEYOR
	var conveyor = persegipanjang(midpoint.x+(beda_p/2),midpoint.y+(beda_l),p3,l3)
	res.append_array(conveyor)
	
	# KAKI CONVEYOR
	conveyor = persegipanjang(midpoint.x+(beda_p/2)+p3/1.05,midpoint.y,p3/50,beda_l)
	res.append_array(conveyor)
	
	return res

func bolt(midpoint,size):
	var p1 = 200*size	# sisi panjang 1
	var l1 = 400*size	# sisi lebar 1
	var p2 = 0.7*p1		# sisi panjang 2
	var l2 = 0.7*l1		# sisi lebar 2
	var p3 = 1.5*l1		# sisi panjang 3
	var l3 = 0.3*p1		# sisi lebar 3
	var beda_p = p1-p2	# jarak antara titik awal sisi panjang 1 dan sisi panjang 2
	var beda_l = l1-l2	# jarak antara titik awal sisi lebar 1 dan sisi lebar 2
	var radius = l3/3	# radius untuk lingkaran (baut conveyor)
	var res = PoolVector2Array()
	
	# CONVEYOR BOLT 1
	var conveyor_bolt = circle(midpoint.x+(beda_p/2)+p3/2.7+margin_left,midpoint.y+margin_top+l2+(beda_l/1.7),radius,1)
	res.append_array(conveyor_bolt)
	
	# TRANSLASI UNTUK MENGHASILKAN CONVEYOR BOLT BARU
	var counter = 0
	var translate = 4
	var conveyor_bolt2
	while counter < 4:
		trans.matrix3x3SetIdentity(trans.theMatrix)
		trans.translate2(radius*translate,0)
		conveyor_bolt2 = trans.transformPoints2(conveyor_bolt.size(),conveyor_bolt)
		res.append_array(conveyor_bolt2)
		translate += 4
		counter += 1
		
	return res

func package(midpoint,size):
	var p1 = 200*size	# sisi panjang 1
	var l1 = 400*size	# sisi lebar 1
	var p2 = 0.7*p1		# sisi panjang 2
	var l2 = 0.7*l1		# sisi lebar 2
	var p3 = 1.5*l1		# sisi panjang 3
	var l3 = 0.3*p1		# sisi lebar 3
	var beda_p = p1-p2	# jarak antara titik awal sisi panjang 1 dan sisi panjang 2
	var beda_l = l1-l2	# jarak antara titik awal sisi lebar 1 dan sisi lebar 2
	var radius = l3/3	# radius untuk lingkaran (baut conveyor)
	var s = p1/2		# panjang sisi paket
	var res = PoolVector2Array()
	
	# PAKET TAMPAK DEPAN
	var package = persegi(midpoint.x+(beda_p),midpoint.y+(beda_l)+l3,s)
	res.append_array(package)
	
	# PAKET SHADOW LENGKUNGAN KIRI ATAS
	var package2 = segitiga_siku(midpoint.x+(beda_p),midpoint.y+(beda_l)+s+l3,s/4)
	res.append_array(package2)
	
	# PAKET SHADOW LENGKUNGAN KANAN ATAS
	package2 = segitiga_siku(midpoint.x+(beda_p)+s,midpoint.y+(beda_l)+s+l3,s/4)
	res.append_array(package2)
	
	# PAKET SHADOW SISI ATAS
	package2 = persegipanjang(midpoint.x+(beda_p)+s/8,midpoint.y+(beda_l)+s+l3,s,s/8)
	res.append_array(package2)
	
	# PAKET SHADOW SISI SAMPING KANAN
	package2 = persegipanjang(midpoint.x+(beda_p)+s,midpoint.y+(beda_l)+l3,s/8,s)
	res.append_array(package2)
	
	return res

func car(midpoint):
	var p = 200
	var l = 150
	var s = 100
	var res = PoolVector2Array()
	var body
	
	body = persegipanjang(midpoint.x,midpoint.y+l/3,p,l)
	res.append_array(body)
	
	var head = trapesium_siku(midpoint.x+p,(midpoint.y+l/3)+(s*0.2),s)
	res.append_array(head)
	
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(0.6, 0.6, Vector2(midpoint.x+p,(midpoint.y+l/3)+(s*0.2)))
	trans.translate2(s*0.43,s*0.9)
	var windshield = trans.transformPoints2(head.size(), head)
	res.append_array(windshield)
	
	var bumper = persegipanjang(midpoint.x+p,midpoint.y+l/3,s,s*0.2)
	res.append_array(bumper)
	
	var lower = persegipanjang(midpoint.x-p/15, (midpoint.y+l/3)-(s/5), s+p+(2*p/15),s/5)
	res.append_array(lower)
	
	return res

func tier(midpoint):
	var p = 200
	var l = 150
	var s = 100
	var res = PoolVector2Array()
	
	# MEMBUAT BAN1 
	var tire = circle(midpoint.x+(p*1.4),midpoint.y+(l*2.85),s/4,1)
	res.append_array(tire)
	# MEMBUAT JARI JARI BAN 1
	var hubcap = ellipse(midpoint.x+(p*1.4),midpoint.y+(l*2.85),s/25,s/4)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.rotate2(45,Vector2(midpoint.x+(p*1.4),midpoint.y+(l*2.85)))
	hubcap = trans.transformPoints2(hubcap.size(), hubcap)
	res.append_array(hubcap)
	# MEMBUAT JARI JARI BAN 1 
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.rotate2(90,Vector2(midpoint.x+(p*1.4),midpoint.y+(l*2.85)))
	var hubcap2 = trans.transformPoints2(hubcap.size(), hubcap)
	res.append_array(hubcap2)

	return res

func expedition_car(midpoint,size):
	var res = PoolVector2Array()
	var s = 100*size
	
	# MEMANGGIL FUNGSI UNTUK MENGGAMBAR MOBIL EKSPEDISI
	var car1 = car(midpoint)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(size, size, Vector2(midpoint.x,midpoint.y))
	var car2 = trans.transformPoints2(car1.size(), car1)
	res.append_array(car2)
	
	# MEMANGGIL FUNGSI UNTUK MENGGAMBAR BAN MOBIL EKSPEDISI 1
	var tier1 = tier(midpoint)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(size, size, Vector2(midpoint.x,midpoint.y))
	var tier2 = trans.transformPoints2(tier1.size(), tier1)
	res.append_array(tier2)
	
	# MEMANGGIL FUNGSI UNTUK MENGGAMBAR BAN MOBIL EKSPEDISI 2
	var tierr1 = tier(midpoint)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(size, size, Vector2(midpoint.x,midpoint.y))
	trans.translate2(-(s/4)*7,0)
	var tierr2 = trans.transformPoints2(tierr1.size(), tierr1)
	res.append_array(tierr2)
	
	return res
