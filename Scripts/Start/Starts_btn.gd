extends Button

func _on_Back_btn_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
		print("Scene Tidak Ada")


func _on_Custom2D_btn_pressed():
	get_tree().change_scene("res://Scenes/Custom2D.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Custom2D.tscn") != OK:
		print("Scene Tidak Ada")


func _on_Animation_btn_pressed():
	get_tree().change_scene("res://Scenes/Animation.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Animation.tscn") != OK:
		print("Scene Tidak Ada")
