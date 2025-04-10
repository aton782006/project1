extends CharacterBody2D

var state = 0
var gravity = 600
var damage = 1.0
var dir = 1
var arr = []
var speed = 40
var shooter = null

func _physics_process(delta: float) -> void:
	velocity.y += gravity*delta
	if !state:velocity.x = dir * speed
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body == self || body==shooter:return
	if body.is_in_group("Player"):
		body.damage(damage)
		Global.camera.shake(1,0.1)
		body.knockback(sign(body.global_position.x-global_position.x),0.2)
	if body.is_in_group("Enemys"):
		body.damage(damage)
		body.knockback(sign(body.global_position.x-global_position.x),0.2)
	if state == 1:
		for x in arr:
			var obj = preload("res://Scenes/Characters/Enemys/Enemy 2/throwobj.tscn").instantiate()
			obj.velocity.y = -150
			obj.damage = damage
			obj.dir = x
			obj.global_position=global_position-Vector2(0,16)
			obj.shooter=shooter
			get_parent().call_deferred("add_child",obj)
	$Area2D/CollisionShape2D.set_deferred("disabled",true)
	$CPUParticles2D.emitting = true
	$MeshInstance2D.hide()
	velocity = Vector2()
	await $CPUParticles2D.finished
	queue_free()
