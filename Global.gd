extends Node


var max_lives = 3
var lives = max_lives
var hud 

var speed = -1

# add global audio
#var HomeAudio = load("res://HUD/audio/home_audio.wav")
#var playAudio = AudioStreamPlayer2D.new()

#func _process(delta: float) -> void:
	#playAudio.stream = HomeAudio
	#playAudio.volume_db = 10
	#playAudio.play()
	
	
func lose_life():
	lives -= 1
	
	hud.load_hearts()
	
	if lives <= 0:
		#hud.load_hearts() # why does the extra heart appear?
		yield(get_tree().create_timer(.7), "timeout") #to let the death animation play and death music/sound
	
