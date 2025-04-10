extends CharacterBody2D

@export var hp = 3
@export var speed = 75
@onready var nav: NavigationAgent2D = $NavigationAgent2D
@export_enum("touch", "throw1","throw3") var state = "touch"
@export var time = 1.0
@export var obj_dmg = 1.0
var x = 0
var max_x = 20
var player :Node2D
var dir = Vector2()
var ipos = Vector2()
var knock_back = false

func _ready() -> void:
	randomize()
	ipos = global_position
	max_x = randi_range(10,20)
	$Timer2.wait_time = time

func _physics_process(delta: float) -> void:
	$Area2D.global_position = ipos
	if knock_back:
		move_and_slide()
		return
	if player:
		dir = to_local(nav.get_next_path_position()).normalized()
		if "throw" in state:
			if global_position.distance_to(player.global_position) < 90:
				if global_position.distance_to(player.global_position) < 40 && global_position.distance_to(player.global_position) > 20:
					dir = Vector2()
				if $Timer2.is_stopped():
					$Timer2.start()
			elif global_position.distance_to(player.global_position) < 20:
				dir = -to_local(nav.get_next_path_position()).normalized()
				$Timer2.stop()
			else:
				$Timer2.stop()
		if global_position.y >player.global_position.y:
			dir.y = -1
			dir = dir.normalized()
	else:
		$Timer2.stop()
		if ipos.distance_to(global_position) > 200:
			dir = global_position.direction_to(ipos)/1.2
	velocity = lerp(velocity,dir * speed,7.5*delta)
	if hp <= 0:
		queue_free()
	$Sprite2D.scale.x = sign(player.global_position.x - global_position.x) if player else sign(dir.x if dir.x else $Sprite2D.scale.x)
	move_and_slide()

func _on_timer_timeout() -> void:
	if player:
		nav.target_position = player.global_position
	else:
		x += 1
		if x == max_x:
			randomize()
			dir = (Vector2(randf_range(-1,1),randf_range(-1,1)).normalized())/randf_range(1,3)
			max_x = randi_range(10,20)
			x = 0

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = null

func _on_hit_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.damage(1)
		body.knockback(sign(body.global_position.x-global_position.x))
		Global.camera.shake(1,0.2)

func throw():
	var obj = preload("res://Characters/Enemys/Enemy 2/throwobj.tscn").instantiate()
	randomize()
	obj.velocity = Vector2((player.global_position.x-global_position.x)*randf_range(2,4),-10*randf_range(5,15))
	obj.damage = obj_dmg
	obj.state = 1
	if state == "throw3":
		obj.arr = [-1,0,1]
	obj.global_position=global_position
	obj.shooter=self
	get_parent().add_child(obj)

func _on_timer_2_timeout() -> void:
	throw()

func damage(value):
	hp -= value
	$Sprite2D.modulate = "ff0000"
	await get_tree().create_timer(0.1).timeout
	$Sprite2D.modulate = "ffffff"

func knockback(direction,amount=1):
	randomize()
	knock_back = true
	velocity = Vector2(direction,-1).normalized()*randf_range(100,200)*amount
	await get_tree().create_timer(0.3).timeout
	knock_back = false
