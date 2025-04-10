# script made from عقرووب
extends Area2D
## an area where if the player entered, it will reload the scene (with transition)
class_name RestartLevelArea



func _ready() -> void:
	# automatically connect the signal, because the user may forget to do that.
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		# the transition autoload is an auto load that handles scene transitioning with fade
		Transition.reload_current_scene()
