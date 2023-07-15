extends Button

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Menu.tscn") != OK:
		print("Scene Tidak Ada")
