extends Node2D


func _on_PauseButton_pressed():
	get_tree().paused = true
	$Pause_Popup.show()


func _on_Quit_pressed():
	get_tree().change_scene("res://HUD/Level Menu.tscn")

func _on_Resume_pressed():
	$Pause_Popup.hide()
	get_tree().paused = false
