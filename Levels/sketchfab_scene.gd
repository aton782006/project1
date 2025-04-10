extends CharacterBody3D

@onready var nav: NavigationAgent3D = $NavigationAgent3D
var speed = 2
var gravity = 10 
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		velocity.y -= 2
	var next_location = nav.get_next_path_position()
	var crunnt_position = global_transform.origin
	var new_velocity = (next_location - crunnt_position).normalized() * speed
	
	velocity = velocity.move_toward(new_velocity,0.25)
	move_and_slide()
	
func target_position(target):
	nav.target_position = target


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name == 'player':
		Transition.reload_current_scene()
	pass # Replace with function body.


func _on_area_3d1_body_entered(body: Node3D) -> void:
	if body.name == 'enemy':
		Transition.change_scene_with_transition("res://Levels/level_4.tscn")
	pass # Replace with function body.
