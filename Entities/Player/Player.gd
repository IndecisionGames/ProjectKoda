extends KinematicBody2D

var max_speed = 300 # Max speed of player
var speed = 0 # Current speed of player
var acceleration = 600 # Acceleration at which speed approaches max_speed
var move_direction = 0 # Movement direction as input for player
var moving = false # Boolean that will activate movement for player and reset speed to 0 if stood still
var destination = Vector2() # Location where mouse clicked
var movement = Vector2() # The movement to push to the engine

func _unhandled_input(event): #Function that will take unhandled input
	if event.is_action_pressed('RightClick'):
		moving = true
		destination = get_global_mouse_position()

func _process(_delta):
	# Temporarily commented out unril animated assets are created
	# animationLoop()
	pass

func _physics_process(delta):
	movementLoop(delta)

func movementLoop(delta):
	if not moving:
		speed = 0
	else:
		speed += acceleration * delta
		if speed > max_speed:
			speed = max_speed
			
	var new_move_direction = rad2deg(destination.angle_to_point(position))
	var direction_diff = abs(abs(new_move_direction) - abs(move_direction))
	if direction_diff >= 30:
		speed /= 2
	elif direction_diff >= 110:
		speed = 0
	move_direction = new_move_direction
	movement = position.direction_to(destination) * speed
	if position.distance_to(destination) > 5:
		movement = move_and_slide(movement)
	else:
		moving = false

func animationLoop():
	var anim_direction = "S"
	var anim_mode = "Idle"
	var animation
	
	if move_direction<= 15 and move_direction >= -15:
		anim_direction = "E"
	elif move_direction <= 60 and move_direction >= 15:
		anim_direction = "SE"
	elif move_direction <= 120 and move_direction >= 60:
		anim_direction = "S"
	elif move_direction <= 165 and move_direction >= 120:
		anim_direction = "SW"
	elif move_direction >= -60 and move_direction <= -15:
		anim_direction = "NE"
	elif move_direction >= -120 and move_direction <= -60:
		anim_direction = "N"
	elif move_direction >= -165 and move_direction <= -120:
		anim_direction = "NW"
	elif move_direction <= -165 and move_direction >= 165:
		anim_direction = "W"
				
	if moving == true:
		anim_mode = "Walk"
	elif moving == false:
		anim_mode = "Idle"
	animation = anim_mode + "_" + anim_direction
	get_node("AnimationPlayer").play(animation)
