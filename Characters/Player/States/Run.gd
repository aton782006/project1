extends State
class_name Run

@export var animator : AnimatedSprite2D
@onready var player_animation_player: AnimationPlayer = $"../../Player_animation_player"

@export_category("Runing variables values")
@export var Run_Speed : float = 200
@export var Run_Acceleration : float = 4000
@export var Run_Deceleration : float = 4000
@onready var player: Player = $"../.."

func Enter():
	Run_state()
	
func Exit():
	pass
	
func Update(_delta:float):
	#creating dirction varible
	var direction : int = int(Input.get_axis("Player_Left" , "Player_Right"))
	#imprting Run function
	Run_movement(_delta, direction)
	if player.velocity.x == 0 :
		state_transition.emit(self , "Idle")
		$"../../AudioStreamPlayer2D2".stop()
	#change state from idle to Runing or runing 
	if Input.get_axis("Player_Left" , "Player_Right") and not Input.is_action_pressed("Player_Sprint") :
		state_transition.emit(self , "Walk")
		$"../../AudioStreamPlayer2D2".play()

	if Input.is_action_just_pressed("Player_Jump"):
		state_transition.emit(self , "Jump")
	#chnage to attake state
	if Input.is_action_just_pressed("Player_sword_attake"):
		state_transition.emit(self , "Attake")


func Run_state():
	Run_Animation_Controller()


func Run_Animation_Controller():
	animator.play("Run")
	player_animation_player.play("Run")



func Run_movement(_delta : float , direction : int):
	applay_Run_Acceleration(_delta, direction)
	applay_Run_Deceleration(_delta, direction)
	applay_Run_velocity(_delta, direction)

#creating a function keep Run velocity at the max speed 
func applay_Run_velocity(_delta : float , direction : int):
	#chek if the player can Run
	if direction and player.velocity.x >= Run_Speed:
		#applay Run speed to the player
		player.velocity.x = Run_Speed * direction

#creating a Run Acceleration funtion 
func applay_Run_Acceleration(_delta : float , direction : int ):
	#Chek if  you got the max speed 
	if direction and player.velocity.x < Run_Speed:
		#applay player Acceleration 
		player.velocity.x = move_toward(player.velocity.x , Run_Speed * direction, _delta * Run_Acceleration)

#creating a Run deceleration funtion 
func applay_Run_Deceleration(_delta : float , direction : int ):
	#chek if you need to enter to deceleration 
	if not direction:
		player.velocity.x = move_toward(player.velocity.x , 0 , _delta * Run_Deceleration)
