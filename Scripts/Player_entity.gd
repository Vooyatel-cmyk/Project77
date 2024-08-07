extends "res://Scripts/Entity.gd"

const SWORD = preload("res://Prefabs/sword_attack.tscn")

var movment = ["left", "right", "up", "down"]

func _ready():
	movementSpeed = Global.PlayerSpeed
	runSpeed = 400
	$AnimationPlayer.play("RESET")
	
func _move(_dt = null):
	#Функция передвижения
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * movementSpeed
	velocity = velocity.normalized() * movementSpeed
	look_at(get_global_mouse_position())

func _sprint():
	#Функция бега
	if Input.is_action_pressed("sprint") && Global.PlayerStamina > 0 && (Input.is_action_pressed("left") || Input.is_action_pressed("right") || Input.is_action_pressed("up") || Input.is_action_pressed("down")):
		if $StaminaTimer.time_left == 0:
			Global.PlayerStamina -= 1
			$StaminaTimer.start()
		movementSpeed = runSpeed
	else:
		movementSpeed = Global.PlayerSpeed
		if Global.PlayerStamina < 50 && $StaminaRegenerationTimer.time_left == 0:
			Global.PlayerStamina += 1
			$StaminaRegenerationTimer.start()

func _takeDamage(_damage = 1, _hp = 100):
	#Функция получения урона
	if $InvincibleTimer.time_left == 0 && Damage_Area != null && !Damage_Area.is_in_group("player"):
		$AnimationPlayer.play("damage")
		_hp -= _damage
		$InvincibleTimer.start()
		return _hp
	else:
		return _hp
		
func _death(_hp = 100):
	
	if _hp != null: #Функция смерти
		
		if _hp <= 0 && !invincible:
			get_tree().change_scene_to_file("res://main.tscn")

func _control(_dt):
	#Главная функция что бы не засорять _physics_process()
	_death(Global.PlayerHP)
	_sprint()
	_move(_dt)
	Global.PlayerHP = _takeDamage(10, Global.PlayerHP)
	_attack()
	Global._EXIT_GAME()

func _attack(_dt = null):
	if Input.is_action_just_pressed("attack"):
		var sword = SWORD.instantiate()
		sword.position = $attack_pos.global_position
		#sword.position = velocity
		get_parent().add_child(sword)

func _physics_process(delta):
	_control(delta)
	move_and_slide()

func _on_hit_box_area_entered(area):
	Damage_Area = area



	
