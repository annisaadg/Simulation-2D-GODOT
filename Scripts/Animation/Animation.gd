extends Node2D

####################### DEKLARASI VARIABEL GLOBAL #######################

# Import script untuk transformasi dan bentuk dasar
var trans = transformasi.new()
var twoD = dasar.new()

# Deklarasi variabel untuk melakukan animasi transformasi
var cloth_trans = 0			# translasi baju
var car_trans = 0			# translasi mobil ekspedisi	
var packet_trans = 0		# translasi paket
var tier_rotate = 0			# rotasi ban mobil pada titik pusatnya
var go_scale = 0			# kondisi penentu paket di scale atau tidak
var scale_packet = 1.0		# nilai scale awal untuk paket

export var margin_left = 50
export var margin_top  = 50

var screen_width = OS.window_size.x 
var screen_height = OS.window_size.y


###################### MEMPROSES FRAME DAN ANIMASI ######################

func _process(delta):
	if cloth_trans < 80:
		cloth_trans += 20
	else:
		cloth_trans = 0
	
	if packet_trans < 280:
		packet_trans += 20
	else:
		if packet_trans < 1000:
			if packet_trans < 300:
				packet_trans += 80
			packet_trans += 20
			go_scale = 1
			scale_packet = 2
			car_trans += 13
			tier_rotate += 20
		else:
			packet_trans = 0
			go_scale = 0
			scale_packet = 1
			car_trans = 0
			tier_rotate = 0
	update()


############# METHOD UTAMA YG DIPROSES PADA SCENE ANIMATION #############

func draw_animation():
	# Deklarasi titik/koordinat awal untuk objek mobil ekspedisi
	var xp_car = (screen_width/2) - margin_left - 300
	var yp_car = (screen_height/2) - margin_top - 200
	
	# Gambar 4 baju unpacked
	draw_clothes(-100, 150, 0.5, Color("#f04848"), cloth_trans)	
	draw_clothes(0, 150, 0.5, Color("#03f4fc"), cloth_trans)	
	draw_clothes(100, 150, 0.5, Color("#fc03db"), cloth_trans)	
	draw_clothes(200, 150, 0.5, Color("#8003fc"), cloth_trans)	
	
	# Gambar mesin packing
	draw_machines(350, 30, 0.6)
	
	# Gambar paket berisi baju
	draw_packet(340, 30, 0.6, packet_trans)
	
	# Gambar mobil ekspedisi
	var car = draw_carr(xp_car, yp_car, 1, car_trans, tier_rotate)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.translate2(170, -120)
	trans.scale2(1.5, 1.5, Vector2(0,0))
	car = trans.transformPoints2(car.size(), car)
	put_pixel_all(car, Color("#00ffaa"))
	

############## METHOD OBJEK YG DIPANGGIL PADA METHOD UTAMA ##############

# METHOD UNTUK MENGGAMBAR OBJEK BAJU
func draw_clothes(x, y, size, color, transform):
	# Deklarasi variabel
	var baju = PoolVector2Array()
	
	# Melakukan translasi
	baju = twoD.baju(Vector2(x, y), size)	
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.translate2(transform, 0)
	baju = trans.transformPoints2(baju.size(), baju)
	put_pixel_all(baju, color)

# METHOD UNTUK MENGGAMBAR OBJEK MESIN PACKING
func draw_machines(x, y, size):
	# Deklarasi variabel
	var mesin = PoolVector2Array()
	var conveyor_bolt = PoolVector2Array()
	
	# Menggambar mesin luar
	mesin = twoD.machine(Vector2(x, y), size)
	put_pixel_all(mesin, Color("#00bbff"))
	
	# Menggambar mesin dalam (conveyor)
	mesin = twoD.machine_inside(Vector2(x, y), size)
	put_pixel_all(mesin, Color("#ffffff"))
	
	# Menggambar baut conveyor
	conveyor_bolt = twoD.bolt(Vector2(x, y), size)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.translate2(0, 307)
	conveyor_bolt = trans.transformPoints2(conveyor_bolt.size(), conveyor_bolt)
	put_pixel_all(conveyor_bolt, Color("#b3ffe4"))

# METHOD UNTUK MENGGAMBAR OBJEK PAKET
func draw_packet(x, y, size, transform):
	# Deklarasi variabel
	var xp = x+transform
	var yp = y
	var midpoint = Vector2(xp, yp)
	var paket = PoolVector2Array()
	
	paket = twoD.package(midpoint, size)
	# Kondisi ketika paket akan di-scaling
	if go_scale == 1:
		trans.matrix3x3SetIdentity(trans.theMatrix)
		trans.scale2(scale_packet, scale_packet, Vector2(xp, 550))
		paket = trans.transformPoints2(paket.size(), paket)
	put_pixel_all(paket, Color("#ffcc00"))
	
# METHOD UNTUK EMNGGAMBAR OBJEK MOBIL EKSPEDISI
func draw_carr(x, y, size, transform, transform2):
	# Deklarasi variabel
	var p = 200
	var l = 150
	var midpoint = Vector2(x+transform, y)
	var res = PoolVector2Array()
	var car = PoolVector2Array()
	var tier1 = PoolVector2Array()
	var tier2 = PoolVector2Array()
	var s = 100
	
	# Konidisi untuk menentukan mulainya translasi mobil
	if go_scale == 0:
		midpoint = Vector2(x, y)
	else:
		midpoint = Vector2(x+transform, y)
	
	# Memanggil method untuk menggambar mobil
	car = twoD.car(midpoint)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(size, size, Vector2(midpoint.x,midpoint.y))
	car = trans.transformPoints2(car.size(), car)
	res.append_array(car)
	
	# Memanggil method untuk menggambar ban mobil depan
	tier1 = twoD.tier(midpoint)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(size, size, Vector2(midpoint.x,midpoint.y))
	trans.rotate2(transform2,Vector2(midpoint.x+(p*1.4),midpoint.y+(l*2.85)))
	tier1 = trans.transformPoints2(tier1.size(), tier1)
	res.append_array(tier1)
	
	# Memanggil method untuk menggambar ban mobil belakang
	tier2 = twoD.tier(midpoint)
	trans.matrix3x3SetIdentity(trans.theMatrix)
	trans.scale2(size, size, Vector2(midpoint.x,midpoint.y))
	trans.translate2(-(s/5)*8,0)
	trans.rotate2(tier_rotate,Vector2(midpoint.x+(p*1.4)-(s/5)*8,midpoint.y+(l*2.85)))
	tier2 = trans.transformPoints2(tier2.size(), tier2)
	res.append_array(tier2)
	
	return res
	
	
################# PLOTTING PIXEL UNTUK MENGGAMBAR OBJEK #################

func put_pixel(x, y, color=Color("007fff")):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
		PoolColorArray([color]),
		PoolVector2Array())

func put_pixel_all(dot: PoolVector2Array, color):
	for i in dot.size():
		put_pixel(dot[i].x, dot[i].y, color)
