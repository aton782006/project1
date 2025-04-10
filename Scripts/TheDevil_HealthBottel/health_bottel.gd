extends Panel

# script enhanced by 38roob : عقرووب

## the health manager of the player.
@onready var player_health_manager: HealthManager = Global.get_player_health_manager()


func _process(delta: float) -> void:
	$Label.text = str(Global.get_player_health_manager().health)
	if player_health_manager.health == 1:
		$TextureButton.disabled = false
	elif player_health_manager.health <= 0:
		$TextureButton.disabled = true

 


func _on_texture_button_pressed() -> void:
	
	if player_health_manager.health != 10:
		player_health_manager.health -= 1
		player_health_manager.max_health += 1
	pass
