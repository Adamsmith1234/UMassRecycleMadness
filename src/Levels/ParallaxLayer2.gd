extends ParallaxLayer


export (float) var BUILDING_SPEED = -45

func _process(delta: float) -> void:
	self.motion_offset.x += BUILDING_SPEED * delta
