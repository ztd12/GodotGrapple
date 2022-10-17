extends RayCast2D


func _ready():
	pass

func _physics_process(delta):
	detect_player_position2()

func detect_player_position2():
	if self.is_colliding():
		if self.get_collider().name == "Player":
			if self.get_collider().dead == true:
				owner.player_behind = false
				return
			else:
				owner.player_behind = true
				owner.player_position = self.get_collider().get_global_position()
				owner.distance_to_player = owner.global_position.distance_to(owner.player_position)
		else:
			owner.player_behind = false
			owner.player_position = Vector2.ZERO
			owner.distance_to_player = 9999
			

