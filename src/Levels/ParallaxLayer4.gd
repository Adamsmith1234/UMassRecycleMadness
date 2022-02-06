extends ParallaxLayer

export (float) var MTN_SPEED = -10

func _process(delta: float) -> void:
	self.motion_offset.x += MTN_SPEED * delta
