extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("CutScene")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_escape_the_story_btn_pressed():
	get_tree().change_scene_to_file("res://Global/main_menu.tscn")


func _on_animation_player_animation_finished(anim_name):
	
	get_tree().change_scene_to_file("res://Global/main_menu.tscn")
	pass # Replace with function body.
