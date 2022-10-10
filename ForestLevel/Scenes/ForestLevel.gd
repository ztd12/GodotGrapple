extends Node2D


func _on_PauseButton_pressed():
	get_tree().paused = true
	$Pause_Menu.show()


func _on_Quit_pressed():
	get_tree().change_scene("res://HUD/Level Menu.tscn")

func _on_Resume_pressed():
	$Pause_Menu.hide()
	get_tree().paused = false


func _on_Restart_pressed():
	get_tree().change_scene("res://ForestLevel/Scenes/ForestLevel.tscn")
