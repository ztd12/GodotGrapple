extends CanvasLayer



func show_message(text):
	$Message.text = text
	$Message.show()
	
	
func show_game_over():
	show_message("Game Over")
	
	$Message.text = "Grapple!"
	$Message.show()
	
	$StartButton.show()
	
	
func _on_StartButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://HUD/Level Menu.tscn")
	
	
	
func _on_HowToButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://HUD/How To Menu.tscn")
