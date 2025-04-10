extends State

class_name Enemy_1_Flow

@export var animator: AnimatedSprite2D

@export_category("Flow Variables")
@export var flow_speed: float = 35

@onready var Enemy_1: enemy_1 = $"../.."

var player: CharacterBody2D = null

func Enter() -> void:
	start_flow()

func Exit() -> void:
	# Optional cleanup if necessary
	pass

func Update(_delta: float) -> void:
	if player:
		# Calculate direction to player
		var direction: Vector2 = (player.global_position - Enemy_1.global_position).normalized()
		apply_flow_movement(direction.x)
		flip_animation_based_on_direction(direction.x)

func start_flow() -> void:
	play_flow_animation()

func play_flow_animation() -> void:
	animator.play("Flow")

func apply_flow_movement(direction: float) -> void:
	Enemy_1.velocity.x = flow_speed * direction

# Flip the sprite based on the movement direction
func flip_animation_based_on_direction(direction: float) -> void:
	if direction < 0:
		# Flip the sprite horizontally when moving left
		animator.flip_h = true
	else:
		# Ensure sprite is not flipped when moving right
		animator.flip_h = false

func _on_flow_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_flow_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null
		emit_signal("state_transition", self, "Idle")

func _on_attake_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		emit_signal("state_transition", self, "Attack")
