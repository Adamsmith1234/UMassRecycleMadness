extends CanvasLayer

var pickedTexture = load("res://assets/item_slot_default_background copy.png")
var nonPickedTexture = load("res://assets/item_slot_empty_background copy.png")

func _ready() -> void:
		get_node("Label/1Box").set_texture(pickedTexture)
		get_node("Label/2Box").set_texture(nonPickedTexture)
		get_node("Label/3Box").set_texture(nonPickedTexture)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("library"):
		get_node("Label/1Box").set_texture(pickedTexture)
		print("apples")
		get_node("Label/2Box").set_texture(nonPickedTexture)
		get_node("Label/3Box").set_texture(nonPickedTexture)
	if Input.is_action_just_pressed("frank"):
		get_node("Label/2Box").set_texture(pickedTexture)
		print("apples")
		get_node("Label/1Box").set_texture(nonPickedTexture)
		get_node("Label/3Box").set_texture(nonPickedTexture)
	if Input.is_action_just_pressed("statue"):
		get_node("Label/3Box").set_texture(pickedTexture)
		print("apples")
		get_node("Label/2Box").set_texture(nonPickedTexture)
		get_node("Label/1Box").set_texture(nonPickedTexture)
	get_node("Node2D/ProgressBar").value = Global.distance
