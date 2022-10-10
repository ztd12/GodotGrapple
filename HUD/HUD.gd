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
	

func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


