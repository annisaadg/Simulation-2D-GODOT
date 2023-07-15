extends Node2D

####################### DEKLARASI VARIABEL GLOBAL #######################

# Import script
var Primitif = primitif.new()
var Trans = transformasi.new()
var Dasar = dasar.new()
var Mat = matrix.new()

export var margin_left = 50
export var margin_top  = 50

var size = 1
var screen_width = OS.window_size.x 
var screen_height = OS.window_size.y


############## OBJEK YANG PERTAMA DITAMPILKAN PADA SCENE ##############

func _ready():
	var KL_Baju = $"/root/Custom2D/KaryaLayer/Baju"
	KL_Baju.visible = true


############# MEMANGGIL FUNGSI UTK MEMBUAT BENTUK DASAR 2D #############

# MEMBUAT 7 ILUSTRASI BAJU SEBELUM DILAKUKAN PROSES PACKING
func draw_baju():
	## Deklarasi dan inisialisasi midpoint
	var xp = (screen_width/2)-margin_left-40
	var yp = (screen_height/2)-margin_top-50
	var midpoint = Vector2(xp, yp)
	
	## Deklarasi tiap objek baju
	var baju1 = PoolVector2Array()
	var baju2 = PoolVector2Array()
	var baju3 = PoolVector2Array()
	var baju4 = PoolVector2Array()
	var baju5 = PoolVector2Array()
	var baju6 = PoolVector2Array()
	var baju7 = PoolVector2Array()
	
	## Inisialisasi tiap objek baju
	
	# BAJU 1
	baju1 = Dasar.baju(midpoint, size)	
	
	# BAJU 2 DI KUADRAN 2 (ROTASI & TRANSLASI DARI BAJU 1)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.rotate2(15,Vector2(xp,yp))
	Trans.translate2(-150,-150)
	baju2 = Trans.transformPoints2(baju1.size(),baju1)	
	
	# BAJU 3 DI KUADRAN 3 (TRANSLASI DARI BAJU 2)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.translate2(0,250)
	baju3 = Trans.transformPoints2(baju2.size(),baju2)
	
	# BAJU 4 DI KUADRAN 4 (ROTASI & TRANSLASI DARI BAJU 1)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.rotate2(-15,Vector2(xp,yp))
	Trans.translate2(150,150)
	baju4 = Trans.transformPoints2(baju1.size(),baju1)
	
	# BAJU 5 DI KUADRAN 1 (TRANSLASI DARI BAJU 4)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.translate2(0,-250)
	baju5 = Trans.transformPoints2(baju4.size(),baju4)
	
	# BAJU 6 (SCALLING DAN TRANSLASI DARI BAJU 1)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.scale2(0.5, 0.5, Vector2(xp,yp))
	Trans.translate2(-150,40)
	baju6 = Trans.transformPoints2(baju1.size(),baju1)
	
	# BAJU 7
	# SCALLING DAN TRANSLASI DARI BAJU 1
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.scale2(0.5, 0.5, Vector2(xp,yp))
	Trans.translate2(230,40)
	baju7 = Trans.transformPoints2(baju1.size(),baju1)
	
	## OUTPUT KE LAYAR
	put_pixel_all(baju1,Color("#ed0707"))
	put_pixel_all(baju2,Color("#03fcd3"))
	put_pixel_all(baju3,Color("#03f4fc"))
	put_pixel_all(baju4,Color("#fc03db"))
	put_pixel_all(baju5,Color("#8003fc"))
	put_pixel_all(Primitif.line_style(baju6, 1, 2),Color("#ff7878"))
	put_pixel_all(Primitif.line_style(baju7, 3, 2),Color("#f04848"))

# MEMBUAT ILUSTRASI MESIN PACKAGING
func draw_machines():
	## Deklarasi dan inisialisasi midpoint
	var xp = (screen_width/2)-margin_left-300
	var yp = (screen_height/2)-margin_top-200
	var midpoint = Vector2(xp, yp)
	
	## Deklarasi tiap objek pembentuk mesin
	var machine_skin = PoolVector2Array()
	var machine_inside = PoolVector2Array()
	var conveyor_bolt2 = PoolVector2Array()
	
	## Inisialisasi tiap objek baju
	### Mesin Luar
	machine_skin = Dasar.machine(midpoint,size)
	### Mesin Dalam
	machine_inside = Dasar.machine_inside(midpoint,size)
	### Baut Conveyor
	conveyor_bolt2 = Dasar.bolt(midpoint,size)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.translate2(0,-100)
	conveyor_bolt2 = Trans.transformPoints2(conveyor_bolt2.size(),conveyor_bolt2)
	
	## OUTPUT KE LAYAR
	put_pixel_all(machine_skin,Color("#00bbff"))
	put_pixel_all(machine_inside,Color("#ffffff"))
	put_pixel_all(conveyor_bolt2,Color("#b3ffe4"))
	
# MEMBUAT ILUSTRASI PAKET BERISI BAJU PADA MESIN PACKAGING
func draw_packet():
	## Deklarasi dan inisialisasi midpoint dan variabel lainnya
	var xp = (screen_width/2)-margin_left-300
	var yp = (screen_height/2)-margin_top-200
	var midpoint = Vector2(xp, yp)
	var p1 = 200*size
	var s = p1/2
	var counter = 0
	var translate = s*2
	
	## Deklarasi objek paket
	var package = PoolVector2Array()
	var package2 = PoolVector2Array()
	
	## Inisialisasi dan output ke layar objek paket
	### Paket utama
	package = Dasar.package(midpoint,size)
	put_pixel_all(package,Color("#ffcc00"))
	### 2 Paket lain (Digambar dengan translasi)
	while counter < 2:
		Trans.matrix3x3SetIdentity(Trans.theMatrix)
		Trans.translate2(translate,0)
		package2 = Trans.transformPoints2(package.size(),package)
		put_pixel_all(package2,Color("#ffcc00"))
		translate += s*2
		counter += 1
	### Menggambar mesin packaging dengan memanggil fungsi 
	draw_machines()

# MEMBUAT ILUSTRASI MOBIL EKSPEDISI
func draw_car():
	## Deklarasi dan inisialisasi midpoint dan size
	size = 2
	var xp = (screen_width/2)-margin_left-300
	var yp = (screen_height/2)-margin_top-200
	var midpoint = Vector2(xp, yp)
	
	## Deklarasi objek mobil ekspedisi
	var truck = PoolVector2Array()	
	
	## Inisialisasi objek mobil ekspedisi
	truck = Dasar.expedition_car(midpoint,size)
	Trans.matrix3x3SetIdentity(Trans.theMatrix)
	Trans.translate2(-50,-400)
	truck = Trans.transformPoints2(truck.size(),truck)
	
	## Output ke layar
	put_pixel_all(truck,Color("#00ffaa"))

func put_pixel(x, y, color=Color("007fff")):
	draw_primitive(PoolVector2Array([Vector2(x, y)]),
		PoolColorArray([color]),
		PoolVector2Array())

func put_pixel_all(dot: PoolVector2Array, color):
	for i in dot.size():
		put_pixel(dot[i].x, dot[i].y, color)

func draw_kartesian():
	var color = ("#ffffff")
	var res = PoolVector2Array()
	
	#Sumbu X
	var xa = margin_left                       
	var ya = margin_top      
	var xb = screen_width - xa        
	var yb = screen_height / 2                       
	res.append_array(Primitif.lineDDA(xa,yb,xb,yb))
	
	#Sumbu Y  
	xa = margin_left                        
	ya = margin_top
	xb = screen_width / 2                        
	yb = screen_height - margin_top         
	res.append_array(Primitif.lineDDA(xb,ya,xb,yb))
	put_pixel_all(res,color)
