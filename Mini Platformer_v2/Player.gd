extends KinematicBody2D

# Variables
const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 20
const MAX_SPEED = 320
const JUMP_HEIGHT = -550
var motion = Vector2()
var friction = false

func _physics_process(delta):
	motion.y += GRAVITY
	friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
		get_node("Player_sprite").flip_h = false	# get_node("Player_sprite")   and   $Player_sprite    work the same way until we have multiple sprites. then use get_node
		$Player_sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
		$Player_sprite.flip_h = true
		$Player_sprite.play("Run")
	else:
		$Player_sprite.play("Idle")
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.15)
	else:
		if motion.y < 0:
			$Player_sprite.play("Jump")
		else:
			$Player_sprite.play('Fall')
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.035)
	
	motion = move_and_slide(motion, UP)
	