extends CharacterBody2D

var Damage_Area = null

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

func _takedamage():
	if $inv.time_left == 0:
		if Damage_Area != null:
			Global.PlayerHP -= 10
			$inv.start()
			if Global.PlayerHP <= 0:
				get_tree().reload_current_scene()
				Global.PlayerHP = 100

func _control():
	_sprint()
	_move()
	

func _physics_process(_delta) -> void:
	_control()
	_takedamage()
	move_and_slide()


func _on_hitbox_area_entered(area):
	Damage_Area = area


func _on_hitbox_area_exited(area):
	if area == Damage_Area:
		Damage_Area = null
