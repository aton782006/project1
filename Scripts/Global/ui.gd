extends CanvasLayer


var health = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#view health:
	$Control/GameUi/Health_Bar.value = lerpf($Control/GameUi/Health_Bar.value,health,10*delta)
	pass
