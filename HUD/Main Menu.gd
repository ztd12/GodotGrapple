extends CanvasLayer

signal start_game

func show_message(text):
	$Message.text = text
	$Message.show()


func show_game_over():
	show_message("Game Over")
	
	$Message.text = "Grapple!"
	$Message.show()
	
	$StartButton.show()
	

func _on_StartButton_pressed():
	get_tree().change_scene("res://HUD/Level Menu.tscn")




func _on_HowToButton_pressed():
	get_tree().change_scene("res://HUD/How To Menu.tscn")
