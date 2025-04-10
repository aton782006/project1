extends CanvasLayer

## the animation player used to make the fade in and out effect
@onready var anim_player = $%AnimationPlayer


## changes the current scene with a transition effect which is fading in and out.
func change_scene_with_transition(path: String):
	anim_player.play("in")
	await anim_player.animation_finished
	get_tree().change_scene_to_file(path)
	anim_player.play("out")

## realods the current scene with transition
func reload_current_scene() -> void:
	anim_player.play("in")
	await anim_player.animation_finished
	get_tree().reload_current_scene()
	anim_player.play("out")
