extends CharacterBody2D

func _move():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Global.PlayerSpeed
	velocity = velocity.normalized() * Global.PlayerSpeed
	look_at(get_global_mouse_position())
	
func _sprint():
	if Input.is_action_pressed("sprint"):
		Global.PlayerSpeed = 600
	else:
		Global.PlayerSpeed = 300

func _control():
	_sprint()
	_move()

func _physics_process(_delta) -> void:
	_control()
	move_and_slide()
