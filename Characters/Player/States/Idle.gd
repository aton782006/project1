extends State

class_name Idle

@export var animator : AnimatedSprite2D
@onready var player_animation_player: AnimationPlayer = $"../../Player_animation_player"

#inporting player main node 
@onready var player: Player = $"../.."


func Enter():
	idle_controller()

	
func Exit():
	pass
	
func Update(_delta:float):
	#change state from idle to walking or runing 
	if Input.get_axis("Player_Left" , "Player_Right"):
		#chek if player is pressing sprint 
		if Input.is_action_just_pressed("Player_Sprint"):
			#trasnstion to run
			state_transition.emit(self , "Run")
		else : 
			#transition to Walk
			state_transition.emit(self , "Walk")
	
	if Input.is_action_just_pressed("Player_Jump"):
		state_transition.emit(self , "Jump")
		
	#chnage to attake state
	if Input.is_action_just_pressed("Player_sword_attake"):
		state_transition.emit(self , "Attake")

func idle_controller():
	#to fix some gilitsh i make i dle whit velocit x =0
	player.velocity.x = 0
	#play animation
	animator.play("Idle")
	player_animation_player.play("Idle")
