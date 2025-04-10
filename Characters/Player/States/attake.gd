extends State
class_name Player_Attaking



@onready var sword: Area2D = $"../../sword"

#import
@onready var player: Player = $"../.."
@onready var player_animation_player: AnimationPlayer = $"../../Player_animation_player"
var enemy : CharacterBody2D

#values
var player_damage_value : int = 1


func Enter():
	attake()

#just for the sword_postion and enable or desable attake state 
func _physics_process(_delta: float) -> void:
	update_sword_retaion()

func attake():
	if Input.is_action_just_pressed("Player_sword_attake"):
		applay_attake_damage_to_enemy()
		animation()

func end_attake():
	state_transition.emit(self , "Idle")

func applay_attake_damage_to_enemy():
	if enemy:
		enemy.damage(player_damage_value)
		enemy.knockback(sign(enemy.global_position.x-player.global_position.x))

func animation():
	player_animation_player.play("SWORD ATTAKE")
	await player_animation_player.animation_finished
	end_attake()

func update_sword_retaion():
	sword.look_at(player.get_global_mouse_position())

#add enemy to the area
func _on_sword_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemys"):
		enemy = body

func _on_sword_body_exited(body: Node2D) -> void:
	if body.is_in_group("Enemys"):
		enemy = null
