extends Control



func _on_Timer_timeout():
# warning-ignore:return_value_discarded
	GlobalAudioScene.get_node("AudioStreamPlayer2D").play()
	get_tree().change_scene("res://HUD/Level Menu.tscn")

