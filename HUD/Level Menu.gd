extends Control


func _on_Level_1_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://ForestLevel/Scenes/ForestLevel.tscn")


func _on_Level_2_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://mountainLevel/mountainScrolling.tscn")


func _on_Back_to_Home_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://HUD/Main Menu.tscn")


func _on_Level_3_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://SpaceLevel/SpaceLevel.tscn")
