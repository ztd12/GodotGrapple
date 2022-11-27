extends Sprite

const VELOCITY: float = -0.75
var g_texture_width: float = 0


func _ready():
	g_texture_width = texture.get_size().x * scale.x
	
	

func _process(_delta: float) -> void:
	position.x += VELOCITY
	_attempt_reposition()
	

func _attempt_reposition() -> void:
	if position.x < -g_texture_width:
		position.x += 6 * g_texture_width
