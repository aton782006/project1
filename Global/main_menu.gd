extends Control

@export var Anim : AnimationPlayer
@export var BlackScreen : Panel
@export var BlackScreenTexts : Panel
# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	if Global.FistJoinToGame:
		BlackScreenTexts.visible = true
		BlackScreen.visible = true
		Anim.play("FirstJoinGame")
		await get_tree().create_timer(3.6)
		Global.FistJoinToGame = false
		
	else:
		BlackScreen.visible = true
		Anim.play("FadeOut")
		await get_tree().create_timer(1)
		BlackScreen.visible = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_play_button_pressed():
	Anim.play("FadeIn")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://Levels/Level_1.tscn")
	pass 

func _on_animation_player_animation_finished(anim_name):
	BlackScreenTexts.visible = false
	BlackScreen.visible = true
	pass 



func _on_settings_button_2_pressed() -> void:
	Anim.play("FadeIn")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://akramos.tscn")
	


func _on_settings_button_pressed() -> void:
	Transition.change_scene_with_transition("res://UI/Settings/settings.tscn")
	await get_tree().create_timer(1).timeout
	get_tree().change_scene_to_file("res://UI/Settings/settings.tscn")
