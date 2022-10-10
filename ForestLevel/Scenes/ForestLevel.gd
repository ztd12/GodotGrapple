extends Node2D

export (NodePath) var _pause_menu
onready var _pause = get_node(_pause_menu)

func _on_PauseButton_pressed():
	get_tree().paused = true
	_pause.popup()


func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HUD/Level Menu.tscn")

func _on_Resume_pressed():
	_pause.hide()
	get_tree().paused = false
	
