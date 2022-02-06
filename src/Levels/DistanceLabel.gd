extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta: float) -> void:
	set_text("Distance: " + str((Global.distance - 62.3)/100) + "out of 100")
