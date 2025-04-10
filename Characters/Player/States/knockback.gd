extends State

class_name KnockBack

@onready var player: Player = $"../.."
var dir = -1
var amount = 1

func Enter():
	randomize()
	player.velocity = Vector2(dir,-1).normalized()*randf_range(100,200)*amount
	await get_tree().create_timer(0.3).timeout
	state_transition.emit(self , "Idle")

func Exit():
	pass

func Update(_delta:float):
	pass
