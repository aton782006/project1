extends Control

var s=false
var fullscreen = true
var sounds = true

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://akramos.tscn")
	

func _on_fullscreen_pressed() -> void:
	if not fullscreen:
		fullscreen = true
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		fullscreen = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_volume_pressed() -> void:
	if sounds:
		sounds = false
		AudioServer.set_bus_mute(0,true)
	else:
		sounds = true
		AudioServer.set_bus_mute(0,false)


func _on_check_box_pressed() -> void:
	if Global.phone_control == false: 
		Global.phone_control = true
	elif Global.phone_control == true: 
		Global.phone_control == false 
	pass # Replace with function body.
