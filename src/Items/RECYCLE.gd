extends Label


func _ready() -> void:
	visible = false



func _on_Pennant_pickedUp() -> void:
	queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	visible = true
