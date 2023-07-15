extends CheckButton

onready var HL_Kartesian = $"/root/Custom2D/KaryaLayer/HelperLayer/HelperLayer2/Kartesian"

func _on_Kartesian_btn_pressed():
	HL_Kartesian.visible = !HL_Kartesian.visible
