extends Node2D

export (NodePath) var _pause_menu
onready var _pause = get_node(_pause_menu)



func _on_Quit_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://HUD/Level Menu.tscn")


func _on_Mute_pressed():
	var master_sound = AudioServer.get_bus_index("Master")
	AudioServer.set_bus_mute(master_sound,
							not AudioServer.is_bus_mute(master_sound))


func _on_Resume_pressed():
	_pause.hide()
	get_tree().paused = false


func _on_PauseButton_pressed():
	get_tree().paused = true
	_pause.popup()
