extends Node2D


func _ready() -> void:
	$backMusic.play()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		$enterPressed.play()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().change_scene("res://src/Levels/TestLevel.tscn")
		queue_free()
