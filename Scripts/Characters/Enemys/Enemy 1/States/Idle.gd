extends State

class_name Enemy_1_Idle

@export var animator: AnimatedSprite2D

var player: CharacterBody2D = null

func Enter() -> void:
	idle_logic()

func Update(_delta: float) -> void:
	if player:
		emit_signal("state_transition", self, "Flow")

func idle_logic() -> void:
	$"../..".velocity.x = 0
	idle_animation()

func idle_animation() -> void:
	animator.play("Idle")

func _on_flow_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_flow_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
