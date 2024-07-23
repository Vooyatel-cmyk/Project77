extends CharacterBody2D

var Damage_Area = null

func _move():
	#Функция передвижения
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * Global.PlayerSpeed
	velocity = velocity.normalized() * Global.PlayerSpeed
	look_at(get_global_mouse_position())
	
func _sprint():
	#Функция бега
	if Input.is_action_pressed("sprint"):
		Global.PlayerSpeed = 600
	else:
		Global.PlayerSpeed = 300

func _takedamage():
	#Функция получения урона
	if $inv.time_left == 0 && Damage_Area != null:
		Global.PlayerHP -= 10
		$inv.start()
		if Global.PlayerHP <= 0:
			get_tree().reload_current_scene()
			Global.PlayerHP = 100

func _control():
	#Главная функция что бы не засорять _physics_process()
	_sprint()
	_move()
	_takedamage()



func _physics_process(_delta) -> void:
	_control()
	move_and_slide()

#Сигналы Area2D
func _on_hitbox_area_entered(area):
	Damage_Area = area
func _on_hitbox_area_exited(area):
	if area == Damage_Area:
		Damage_Area = null
