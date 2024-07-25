extends CharacterBody2D

var Damage_Area = null
var PLayerSPEED = Global.PlayerSpeed

func _move(_dt):
	#Функция передвижения
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * PLayerSPEED
	velocity = velocity.normalized() * PLayerSPEED
	
	look_at(get_global_mouse_position())
	
func _sprint():
	#Функция бега
	if Input.is_action_pressed("sprint") && Global.PlayerStamina > 0:
		if $StaminaTimer.time_left == 0:
			Global.PlayerStamina -= 1
			$StaminaTimer.start()
		PLayerSPEED = 400
	else:
		PLayerSPEED = Global.PlayerSpeed
		if Global.PlayerStamina < 50 && $StaminaRegenerationTimer.time_left == 0:
			Global.PlayerStamina += 1
			$StaminaRegenerationTimer.start()

func _takedamage():
	#Функция получения урона
	if $InvincibleTimer.time_left == 0 && Damage_Area != null:
		Global.PlayerHP -= 10
		$AnimationPlayer.play("damage")
		$InvincibleTimer.start()

func _death():
	#Смерть
	if Global.PlayerHP <= 0:
		queue_free()

func _control(_dt):
	#Главная функция что бы не засорять _physics_process()
	_death()
	_sprint()
	_move(_dt)
	_takedamage()
	Global._EXIT_GAME()

func _physics_process(_delta) -> void:
	_control(_delta)
	move_and_slide()

#Сигналы Area2D
func _on_hitbox_area_entered(area):
	Damage_Area = area
func _on_hitbox_area_exited(area):
	if area == Damage_Area:
		Damage_Area = null
