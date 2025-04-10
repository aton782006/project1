extends Node2D
func _ready():
	$AnimationPlayer.play("cutscene1")

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _on_escape_the_story_btn_pressed():
	MIN.SHAN("res://Levels/level_4.tscn")#حط هنا المرحله الجايه


func _on_animation_player_animation_finished(anim_name):
	MIN.SHAN("res://Levels/level_4.tscn")#حط هنا المرحله الجايه
#31
