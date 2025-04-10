extends Control





func _on_settings_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Global/main_menu.tscn")

# رقم 29: تشتغل أول ما يضغط على الزر
func _on_jengo_pressed() -> void:
	
	$JENGO/AudioStreamPlayer.play()
	
	$AnimationPlayer.play("JENGO")
	
