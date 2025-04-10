extends CharacterBody2D


@export var dir_left = true
@export var can_attack = true


@onready var marker_2d = $Marker2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

var speed = -30

var flay_away = false

func _ready() -> void:
	animation_player.play("flying")
	
	
	$AudioStreamPlayer2D.play(true) 
	
	
	if dir_left:
		speed = -30
		sprite_2d.flip_h = false
	
	else:
		speed = 30
		sprite_2d.flip_h = true
		pass
	
	
	pass

func _physics_process(delta):
	
	velocity.x = speed
	
	fly_away_system(delta)
	
	move_and_slide()
	pass

var bomb_path = preload("res://Characters/Bomb/Bomb Bat.tscn")

func _Attack():
		
	print("pomp")
	var bomb = bomb_path.instantiate()
	
	get_tree().current_scene.add_child(bomb)
	bomb.global_position = marker_2d.global_position
	
	pass


func _on_timer_timeout():
	#_Attack()
	pass # Replace with function body.

func fly_away_system(delta):
	if flay_away :
		global_position.y -= 20 * delta
	
	if global_position.y <-30:
		queue_free()
	pass

func _on_area_2d_body_entered(body):
	if body.name =="Player":
		if can_attack:
			await get_tree().create_timer(0.2).timeout
			_Attack()
			flay_away = true
	pass # Replace with function body.


func damage(value):
	queue_free()


func knockback(dir,amount=1):
	
	pass


func _on_protection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage(1)
		body.knockback(sign(body.global_position.x-global_position.x))
		Global.camera.shake(1,0.2)
	
	pass # Replace with function body.
