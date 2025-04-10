extends CanvasLayer


func SHAN(target):
	$AnimationPlayer.play("shan")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play_backwards("shan")
func reload_current_scene() -> void:
	$AnimationPlayer.play("shan")
	await $AnimationPlayer.animation_finished
	get_tree().reload_current_scene()
	$AnimationPlayer.play_backwards("shan")
