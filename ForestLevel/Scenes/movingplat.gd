extends KinematicBody2D



onready var tween = $Tween 

func _ready():
	tween.interpolate_property(self, "position",
			Vector2(0, 0), Vector2(-10000, 0), 100,
			Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
