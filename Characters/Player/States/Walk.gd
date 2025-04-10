extends State
class_name Walk

@export var animator : AnimatedSprite2D
@onready var player_animation_player: AnimationPlayer = $"../../Player_animation_player"

#export main state varibles
@export_category("Walking variables values")
@export var Walk_Speed : float = 10000000
@export var Walk_Acceleration : float = 6000
@export var Walk_Deceleration : float = 6000
@onready var player: Player = $"../.."

func Enter():
	Walk_state()
	
func Exit():
	pass
	
func Update(_delta:float):
	#creat direction func
	var direction : int = int(Input.get_axis("Player_Left" , "Player_Right"))
	#imprting walk function
	walk_movement(_delta, direction)
	
	#------------                    change to states                    ------------
	#change to idle state
	if player.velocity.x == 0 :
		state_transition.emit(self , "Idle")
		$"../../AudioStreamPlayer2D2".stop()
	#change state from idle to walking or runing 
	if direction and  Input.is_action_pressed("Player_Sprint"):
		state_transition.emit(self , "Run")
		$"../../AudioStreamPlayer2D2".play()
	#change state to jumpoing state
	if Input.is_action_just_pressed("Player_Jump"):
		state_transition.emit(self , "Jump")
	#chnage to attake state
	if Input.is_action_just_pressed("Player_sword_attake"):
		state_transition.emit(self , "Attake")


func Walk_state():
	Walk_Animation_Controller()


func Walk_Animation_Controller():
	animator.play("Walk")
	player_animation_player.play("Walk")
	


func walk_movement(_delta : float , direction : int):
	applay_Walk_Acceleration(_delta, direction)
	applay_Walk_Deceleration(_delta, direction)
	applay_walk_velocity(_delta, direction)

#creating a function keep walk velocity at the max speed 
func applay_walk_velocity(_delta : float , direction : int):
	#chek if the player can walk
	if direction and player.velocity.x >= Walk_Speed:
		#applay walk speed to the player
		player.velocity.x = Walk_Speed * direction

#creating a Walk Acceleration funtion 
func applay_Walk_Acceleration(_delta : float , direction : int ):
	#Chek if  you got the max speed 
	if direction and player.velocity.x < Walk_Speed:
		#applay player Acceleration 
		player.velocity.x = move_toward(player.velocity.x , Walk_Speed * direction, _delta * Walk_Acceleration)

#creating a Walk deceleration funtion 
func applay_Walk_Deceleration(_delta : float , direction : int ):
	#chek if you need to enter to deceleration 
	if not direction:
		#applay decelertion to get 0 in speed 
		player.velocity.x = move_toward(player.velocity.x , 0 , _delta * Walk_Deceleration)
