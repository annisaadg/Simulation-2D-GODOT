extends Node2D

var button_sound = load("res://Assets/Sound/btn_sound.wav")
func play_button_sound():
	$button.stream = button_sound
	$button.play()
