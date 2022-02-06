extends Label


# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false



func _on_Pennant_pickedUp() -> void:
	queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	visible = true
