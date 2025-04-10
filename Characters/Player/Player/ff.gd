extends Control

func _physics_process(delta: float) -> void:
	if Global.phone_control == false: 
		hide()
	elif Global.phone_control == true:
		show()
