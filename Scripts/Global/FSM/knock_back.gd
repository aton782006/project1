extends State

class_name enemy1_knockback

@onready var Enemy_1: enemy_1 = $"../.."

var dir = -1
var amount = 1

func Enter():
	randomize()
	Enemy_1.velocity = Vector2(dir,-1).normalized()*randf_range(100,200)*amount
	await get_tree().create_timer(0.3).timeout
	state_transition.emit(self , "Idle")

func Exit():
	pass

func Update(_delta:float):
	pass
