extends Button



func _on_TutorialButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Tutorial/How To Menu.tscn")
