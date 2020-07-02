extends Actor

func _unhandled_input(event): #Function that will take unhandled input
	if event.is_action_pressed('RightClick'):
		moving = true
		destination = get_global_mouse_position()
