extends Control



func _on_Timer_timeout():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://HUD/Level Menu.tscn")
	GlobalAudioScene.get_node("AudioStreamPlayer2D").stop()
