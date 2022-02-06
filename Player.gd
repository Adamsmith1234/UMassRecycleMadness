extends KinematicBody2D

onready var t = get_node("Timer")

const UP_DIRECTION := Vector2.UP
#velocity that goes upward when clicking jump key
export (int) var jump_velocity = -1700

#gravity on player at all times.. base gravity
export (int) var fall_gravity = 50

#??
var fall_velocity = 600

#variable determining whether player is falling
var falling = false

export (int) var speed = 600


#Defome this OUTSIDE of process function otherwise it resets every frame
var velocity = Vector2.ZERO

var attacking = false
var flipped = false

#func _ready() -> void:
	#get_node("sword").visible = false
func _process(delta: float) -> void:
	Global.distance = get_position()[0]
func get_input():
	velocity.x = 0
	if Input.is_action_pressed("right"):
		velocity.x += 1
		if falling == true and $AnimationPlayer.get_current_animation() != "jump":
			$AnimationPlayer.play("jump_default")
		elif falling == false and $AnimationPlayer.get_current_animation() != "jump":
			$AnimationPlayer.play("run")
		if flipped == true:
			scale.x= -1
			flipped = false
	elif Input.is_action_pressed("left"):
		velocity.x -= 1
		if falling == true and $AnimationPlayer.get_current_animation() != "jump":
			$AnimationPlayer.play("jump_default")
		elif falling == false and $AnimationPlayer.get_current_animation() != "jump":
			$AnimationPlayer.play("run")
		if flipped == false:
			scale.x=-1
			flipped = true
	#elif Input.is_action_just_pressed("attack"):
		#attacking = true
	#elif attacking==true:
		#if get_node("sword").visible == true:
			#$AnimationPlayer.play("slice_right")
			#velocity.x = 0
		#elif get_node("stick").visible == true:
			#$AnimationPlayer.play("stick_slice")
			#velocity.x = 0
	else:
		if falling == true and $AnimationPlayer.get_current_animation() != "jump":
			$AnimationPlayer.play("jump_default")
		elif falling == false and $AnimationPlayer.get_current_animation() != "jump":
			$AnimationPlayer.play("default")
	velocity.x = velocity.x * speed

func jump():
	$AnimationPlayer.play("jump")
	$jumpSound.play()
	velocity.y += jump_velocity
	falling = true

func _physics_process(delta):
	get_input()
	velocity.y += fall_gravity
	if is_on_floor():
		falling = false
		if Input.is_action_just_pressed("jump"):
			jump()
	if falling:
		fall_velocity += fall_gravity
	velocity = move_and_slide(velocity, UP_DIRECTION)
