extends State

@onready var Enemy_1: enemy_1 = $"../.."

@export var animator: AnimatedSprite2D 

func Enter():
	die()

func die():
	#stop the player if hes moving
	Enemy_1.velocity.x = 0
	#play animation
	animator.play("Death")
	#await sume time before free
	await animator.animation_finished
	#deleta the enemy
	Enemy_1.queue_free()
	
