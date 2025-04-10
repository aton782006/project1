extends State
class_name Jump

@export var animator : AnimatedSprite2D
@onready var player: Player = $"../.."
@onready var player_animation_player: AnimationPlayer = $"../../Player_animation_player"


#creating jumps varibles

@export var jump_velocity : int  = 250


func Enter():
	Jump_State()
	
func Exit():
	pass
	
func Update(_delta:float):
	var direction : int = int(Input.get_axis("Player_Left" , "Player_Right"))

	#reset to idle state 
	if player.velocity.y == 0 and not direction:
		state_transition.emit(self , "Idle")
	#change state from idle to walking or runing 
	if direction:
		#chek if player is pressing sprint 
		if Input.is_action_just_pressed("Player_Sprint"):
			#trasnstion to run
			state_transition.emit(self , "Run")
		else : 
			#transition to Walk
			state_transition.emit(self , "Walk")
	#chnage to attake state
	if Input.is_action_just_pressed("Player_sword_attake"):
		state_transition.emit(self , "Attake")

func Jump_State():
	if player.is_on_floor():
		jump_animation_controller()
	if player.is_on_floor() or !$"../../Timer".is_stopped():
		applay_jump_velocity()

func jump_animation_controller():
	animator.play("Jump")
	player_animation_player.play("Jump")


func applay_jump_velocity():
	player.velocity.y = -jump_velocity
	$"../../Timer".stop()
	$"../../Timer2".stop()
	$"../../CPUParticles2D".emitting = true
