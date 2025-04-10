extends CharacterBody2D
class_name Player

var ihaveCutScene: bool = false

@onready var finite_state_machine: FiniteStateMachine = $FiniteStateMachine
@onready var health_manager: HealthManager = %HealthManager
@onready var player_animated_sprite: AnimatedSprite2D = $Player_animation

var gravity = 10
var paused = false
var coyote = false
var jump_amount: int = 0
var dir: int = 1
var stop_pls = 0

@onready var audio_stream_player_2d: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"
@onready var bat: CharacterBody2D = $"../Enemys/Bat"
@export var PausePnael: Panel
@export var GamePanel: Panel

func _ready() -> void:
	Global.coin = Global.last_score

func _physics_process(_delta: float) -> void:
	if Global.coin == 50 and not Global.got_it:
		Global.got_it = true
		$"UI/Control/You Have Fares Papers".show()
		await get_tree().create_timer(3).timeout
		$"UI/Control/You Have Fares Papers".hide()

	if Input.is_action_just_pressed("Esc"):
		PauseMenu()

	if is_on_floor():
		if jump_amount < 1:
			jump_amount = 2

	var direction: int = int(Input.get_axis("Player_Left", "Player_Right"))
	sprite_flip(direction)

	if not is_on_floor():
		velocity.y += gravity
		if Input.is_action_pressed("Player_Jump") and jump_amount > 0:
			$AudioStreamPlayer2D.play()
			jump_amount -= 1
			$Timer2.start()
		if coyote:
			coyote = false
			$Timer.start()
	else:
		coyote = true
		if not $Timer2.is_stopped():
			$FiniteStateMachine.current_state.state_transition.emit($FiniteStateMachine.current_state, "Jump")
			$AudioStreamPlayer2D.play()
	if velocity.y < 0:
		$Timer.stop()
		$Timer2.stop()
		coyote = false

	update_hp_bar()
	move_and_slide()

func sprite_flip(direction):
	if direction == 1:
		player_animated_sprite.flip_h = false
		dir = 1
	elif direction == -1:
		dir = -1
		player_animated_sprite.flip_h = true

func update_hp_bar():
	$UI/Control/GameUi/Health_Bar.value = health_manager.health


func knockback(dir, amount = 1):
	$FiniteStateMachine/KnockBack.dir = dir
	$FiniteStateMachine/KnockBack.amount = amount
	$FiniteStateMachine.current_state.state_transition.emit($FiniteStateMachine.current_state, "KnockBack")

func _on_back_button_pressed():
	PausePnael.visible = false

func _on_play_again_button_pressed():
	Engine.time_scale = 1
	PausePnael.visible = false
	get_tree().reload_current_scene()

func _on_end_level_button_pressed():
	Engine.time_scale = 1
	PausePnael.visible = false
	get_tree().change_scene_to_file("res://Scenes/Levels/Global/main_menu.tscn")

func PauseMenu():
	if paused:
		PausePnael.visible = false
		Engine.time_scale = 1
	else:
		PausePnael.visible = true
		Engine.time_scale = 0
	paused = !paused


func damage(amount: int) -> void:
	health_manager.health -= amount  
	$Player_animation.modulate = Color(1, 0, 0)  
	await get_tree().create_timer(0.1).timeout
	$Player_animation.modulate = Color(1, 1, 1)  
	update_hp_bar() 
	if health_manager.health <= 0:
		_on_health_manager_died() 
func _on_player_area_area_entered(area):
	if area.is_in_group("ResetartLevel"):
		bat.process_mode =  Node.PROCESS_MODE_DISABLED  
		$"../AnimationPlayer".play("BackFade")
		$"../AudioStreamPlayer2D".play()
		await get_tree().create_timer(8.0).timeout
		get_tree().reload_current_scene()
# Player Death
func _on_health_manager_died() -> void:
	bat.process_mode =  Node.PROCESS_MODE_DISABLED  
	$"../AnimationPlayer".play("BackFade")
	$"../AudioStreamPlayer2D2".play()
	await get_tree().create_timer(18.0).timeout
	get_tree().reload_current_scene()
# Damage feeback
func _on_health_manager_took_damage(_amount: int) -> void:
	$Player_animation.modulate = Color(1, 0, 0)
	await get_tree().create_timer(0.1).timeout
	$Player_animation.modulate = Color(1, 1, 1)
