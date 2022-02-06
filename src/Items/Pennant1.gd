extends Sprite

var pickable = false
signal pickedUp

func _ready() -> void:
	$AnimationPlayer.play("default")


func _process(delta: float) -> void:
	if pickable == true:
		if Input.is_action_just_pressed("enter"):
			emit_signal("pickedUp")
			Global.material += 1
			visible = false
			print(Global.material)
			$pickUpSound.play()
			yield(get_tree().create_timer(1), "timeout")
			queue_free()


func _on_Area2D_body_entered(body: Node) -> void:
	pickable = true
	print("ENTERED")


func _on_Area2D_body_exited(body: Node) -> void:
	pickable = false
