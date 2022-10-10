extends Control


func _on_Level_1_pressed():
	get_tree().change_scene("res://ForestLevel/Scenes/ForestLevel.tscn")


func _on_Level_2_pressed():
	get_tree().change_scene("res://mountainLevel/mountainScrolling.tscn")


func _on_Back_to_Home_pressed():
	get_tree().change_scene("res://HUD/Main Menu.tscn")
