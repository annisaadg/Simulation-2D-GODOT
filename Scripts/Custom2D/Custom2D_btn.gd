extends Button

onready var KL_Baju = $"/root/Custom2D/KaryaLayer/Baju"

onready var KL_Mesin = $"/root/Custom2D/KaryaLayer/Mesin"

onready var KL_Paket = $"/root/Custom2D/KaryaLayer/Paket"

onready var KL_MobilPaket = $"/root/Custom2D/KaryaLayer/MobilPaket"

func _on_Back_btn_pressed():
	get_tree().change_scene("res://Scenes/Start.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Start.tscn") != OK:
		print("Scene Tidak Ada")


func _on_Next_btn_pressed():
	Music.play_button_sound()
	if(KL_Baju.visible == true):
		KL_Baju.visible = !KL_Baju.visible
		KL_Mesin.visible = !KL_Mesin.visible
	elif(KL_Mesin.visible == true):
		KL_Mesin.visible = !KL_Mesin.visible
		KL_Paket.visible = !KL_Paket.visible
	elif(KL_Paket.visible == true):
		KL_Paket.visible = !KL_Paket.visible
		KL_MobilPaket.visible = !KL_MobilPaket.visible
	elif(KL_MobilPaket.visible == true):
		KL_MobilPaket.visible = !KL_MobilPaket.visible
		KL_Baju.visible = !KL_Baju.visible


func _on_Prev_btn_pressed():
	Music.play_button_sound()
	if(KL_Baju.visible == true):
		KL_Baju.visible = !KL_Baju.visible
		KL_MobilPaket.visible = !KL_MobilPaket.visible
	elif(KL_MobilPaket.visible == true):
		KL_MobilPaket.visible = !KL_MobilPaket.visible
		KL_Paket.visible = !KL_Paket.visible
	elif(KL_Paket.visible == true):
		KL_Paket.visible = !KL_Paket.visible
		KL_Mesin.visible = !KL_Mesin.visible
	elif(KL_Mesin.visible == true):
		KL_Mesin.visible = !KL_Mesin.visible
		KL_Baju.visible = !KL_Baju.visible
