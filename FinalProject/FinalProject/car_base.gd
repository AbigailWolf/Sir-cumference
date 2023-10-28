extends CharacterBody3D

var gravity = -20.0
var wheel_base = 0.6  # distance between front/rear axles
var steering_limit = 10.0  # front wheel max turning angle (deg)
var engine_power = 6.0
var braking = -9.0
var friction = -2.0
var drag = -2.0
var max_speed_reverse = 3.0
# Car state properties
var acceleration = Vector3.ZERO  # current acceleration
var collision = Vector3.ZERO  # current velocity
var steer_angle = 0.0  # current wheel angle

func _physics_process(delta):
	if is_on_floor():
		get_input()

		apply_friction(delta)
		calculate_steering(delta)
	acceleration.y = gravity
	collision += acceleration * delta
# Use move_and_collide to move and obtain collision information
var motion = collision  # Store the current collision/movement vector

func apply_friction(delta):
	if collision.length() < 0.2 and acceleration.length() == 0:
		collision.x = 0
		collision.z = 0
	var friction_force = collision * friction * delta
	var drag_force = collision * collision.length() * drag * delta
	acceleration += drag_force + friction_force

func calculate_steering(delta):
	var rear_wheel = transform.origin + transform.basis.z * wheel_base / 2.0
	var front_wheel = transform.origin - transform.basis.z * wheel_base / 2.0
	rear_wheel += collision * delta
	front_wheel += collision.rotated(transform.basis.y, steer_angle) * delta
	var new_heading = rear_wheel.direction_to(front_wheel)

	var d = new_heading.dot(collision.normalized())
	if d > 0:
		collision = new_heading * collision.length()
	if d < 0:
		collision = -new_heading * min(velocity.length(), max_speed_reverse)
	look_at(transform.origin + new_heading, transform.basis.y)

func get_input():
	# Detect up/down/left/right keystate and only move when pressed.
	collision = Vector2()
	if Input.is_action_pressed('ui_right'):
		collision.x += 1
	if Input.is_action_pressed('ui_left'):
		collision.x -= 1
	if Input.is_action_pressed('ui_down'):
		collision.y += 1
	if Input.is_action_pressed('ui_up'):
		collision.y -= 1
	
