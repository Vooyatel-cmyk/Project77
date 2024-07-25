extends "res://Scripts/Entity.gd"

func _ready():
	movementSpeed = Global.PlayerSpeed
	runSpeed = 400
	
func _move(_dt = null):
	#Функция передвижения
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * movementSpeed
	velocity = velocity.normalized() * movementSpeed
	look_at(get_global_mouse_position())

func _sprint():
	#Функция бега
	if Input.is_action_pressed("sprint") && Global.PlayerStamina > 0:
		if $StaminaTimer.time_left == 0:
			Global.PlayerStamina -= 1
			$StaminaTimer.start()
		movementSpeed = runSpeed
	else:
		movementSpeed = Global.PlayerSpeed
		if Global.PlayerStamina < 50 && $StaminaRegenerationTimer.time_left == 0:
			Global.PlayerStamina += 1
			$StaminaRegenerationTimer.start()

func _takeDamage(damage = 1):
	#Функция получения урона
	if $InvincibleTimer.time_left == 0 && Damage_Area != null:
		Global.PlayerHP -= damage
		$AnimationPlayer.play("take_damage")
		$InvincibleTimer.start()

func _control(_dt):
	#Главная функция что бы не засорять _physics_process()
	_death(Global.PlayerHP)
	_sprint()
	_move(_dt)
	_takeDamage(10)
	Global._EXIT_GAME()

func _physics_process(delta):
	_control(delta)
	move_and_slide()

func _on_hit_box_area_entered(area):
	Damage_Area = area
