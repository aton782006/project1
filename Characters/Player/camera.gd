# Script enhanced by: 38roob = عقرووب
extends Camera2D
class_name PlayerCamera
var shake_strength = 0
@export var shake_timer: Timer

func _ready() -> void:
	Global.camera = self

func _process(_delta: float) -> void:
	if shake_timer.is_stopped():return
	offset = Vector2(randf_range(-5,5),randf_range(-5,5))*shake_strength

## apply shake with given strength and given time.
func shake(strength: float, time: float):
	shake_strength = strength
	shake_timer.wait_time = time
	shake_timer.start()

func _on_timer_timeout() -> void:
	offset = Vector2.ZERO
