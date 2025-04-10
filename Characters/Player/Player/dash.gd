extends Node2D

@onready var cpu_particles_2d = $CPUParticles2D
@onready var player = $".."
var force_dash = 600
var dir
var is_dashing = false

func _Dash():
	dir = player.dir
	player.velocity.x += force_dash * dir
	is_dashing = true
	cpu_particles_2d.emitting = true
	await get_tree().create_timer(0.09).timeout
	player.velocity.x = 0
	await get_tree().create_timer(1.7).timeout
	is_dashing = false
	pass

func _input(event):
	if Input.is_action_just_pressed("dash") and not is_dashing:
		_Dash()
		
	pass
