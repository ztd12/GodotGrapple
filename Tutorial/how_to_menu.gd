extends Control



func _on_homeButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://HUD/Main Menu.tscn")


func _on_nextButton_pressed():
	get_tree().change_scene("res://Tutorial/tutorial1.tscn")
