extends GridContainer

@onready var health = preload("res://Global/TheDevil_HealthBottel/health_bottel.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var helth = health.instantiate()
	add_child(helth)
	pass
