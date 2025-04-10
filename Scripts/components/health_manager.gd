# Script made by: 38rooob = عقرووب
extends Node
## a class that tracks health and manages it. so we don't need to make health logic for every single
## entity
class_name HealthManager

## the max health, not the current health
@export var max_health: int

## the current health.
var health: int:
	set(value):
		health = clampi(value, 0, max_health)
		
## emitted when the manager takes damage. connect to your script of the
## character for example, and add the logic you want.
signal took_damage(amount: int)
## emitted when healing
signal healed(amount: int)
## emitted when the health reaches zero
signal died

func _ready() -> void:
	health = max_health

## reduce the amount of health with given amount.
func take_damage(amount: int) -> void:
	health -= amount
	took_damage.emit(amount)
	# emitted inside this function instead of the health setter to prevent emitting it multiple times
	# in some cases
	if health == 0: died.emit()
## increase the amount of health with given amount.
func heal(amount: int) -> void:
	health += amount
	healed.emit()
## instantly kills the health.
func kill() -> void:
	health = 0
	died.emit()
## returns true if the health is bigger than 0
func is_dead() -> bool:
	return health > 0
