extends Node2D

@export var anim : AnimationPlayer
@export var BlackScreen : Panel
# Called when the node enters the scene tree for the first time.
func _ready():
	BlackScreen.visible = true
	anim.play("Fade")
	await get_tree().create_timer(1.3).timeout
	BlackScreen.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
