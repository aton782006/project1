# script made from 38rooob : عقرووب
extends Area2D
## am area where of the player reach, he will win the level and go the next one.
class_name LevelEnd


func _ready() -> void:
	body_entered.connect(_on_body_entered)

## when the player enters thi area. it will take him to the next level with transiiton.
func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# transiiton with animation to the next level.
		Transition.change_scene_with_transition("res://Levels/level.tscn")
		Global.current_level += 1
		Global.last_score = Global.coin
