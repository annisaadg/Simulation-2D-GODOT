extends Button

func _on_Back_btn_pressed():
	get_tree().change_scene("res://Scenes/Start.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Start.tscn") != OK:
		print("Scene Tidak Ada")
