extends Control

func _on_start_btn_pressed():
	get_tree().change_scene("res://Scenes/Start.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Start.tscn") != OK:
		print("Scene Tidak Ada")

func _on_about_btn_pressed():
	get_tree().change_scene("res://Scenes/About.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/About.tscn") != OK:
		print("Scene Tidak Ada")

func _on_exit_btn_pressed():
	Music.play_button_sound()
	get_tree().quit()

func _on_guide_btn_pressed():
	get_tree().change_scene("res://Scenes/Guide.tscn")
	Music.play_button_sound()
	if get_tree().change_scene("res://Scenes/Guide.tscn") != OK:
		print("Scene Tidak Ada")
