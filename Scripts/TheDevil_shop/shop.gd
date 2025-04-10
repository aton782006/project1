extends Control


var health_bottle_price: int = 10

@onready var price_label: Label = %PriceLabel

func _ready() -> void:
	# make the price label show the correct prie which is health_bottle_price
	price_label.text = "%s$" % health_bottle_price
func _on_texture_button_pressed() -> void:
	$Panel.visible = true
	pass # Replace with function body.


func _on_button_pressed() -> void:
	$Panel.visible = false
	pass # Replace with function body.


func _on_sell_pressed() -> void:
	if Global.score >= health_bottle_price:
		Global.get_player_health_manager().health += 1
		Global.score -= health_bottle_price
		
	elif Global.score <= 5:
		price_label.visible = false
		$Panel/Panel2/Label3.visible = true
		await get_tree().create_timer(4).timeout
		price_label.visible = true
		$Panel/Panel2/Label3.visible = false
	pass # Replace with function body.
