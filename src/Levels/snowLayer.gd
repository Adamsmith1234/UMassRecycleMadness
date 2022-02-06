extends ParallaxLayer


export (float) var SNOW_SPEED = 15

func _process(delta: float) -> void:
	self.motion_offset.y += SNOW_SPEED * delta
