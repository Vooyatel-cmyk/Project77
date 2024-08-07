extends "res://Scripts/Entity.gd"

var ZombieHP
var state = IDLE
var Player: CharacterBody2D
var alive = true

enum{
	HUNT,
	IDLE
}

func _ready():
	
	invincibleTimer = $InvincibleTimer
	ZombieHP = 30
	movementSpeed = 50
	runSpeed = 150
	animator = $ZombieSprite/AnimationPlayer
	animator.play("RESET")

func _takeDamage(_damage = 1, _hp = 100):
	
	var dm_area = Damage_Area
	
	if invincibleTimer.time_left == 0 && dm_area != null && !dm_area.is_in_group("oneshot"):

		_hp -= _damage
		animator.play("damage")
		invincibleTimer.start()
		return _hp

	elif dm_area != null && dm_area.is_in_group("oneshot"):
		
		_hp = 0
		return _hp

	else:
		
		return _hp

func _move(_dt = null, ms = 100, rs = 200):

	if state == IDLE && $Timer.time_left == 0:
		
		velocity = transform.x * ms
		$Timer.start()

	elif state == HUNT:
		
		$Timer.stop()
		var t = (Player.global_position - self.global_position).normalized()
		velocity = t * rs
		look_at(Player.global_position)

func _death(_hp = 100):
		if _hp <= 0 && !invincible && _hp != null:
			alive = false
			animator.play("death")
			Global.score += 1

func _logic():
	if alive == true:
		
		ZombieHP = _takeDamage(10, ZombieHP)
		_move(null, movementSpeed, runSpeed)
		
	_death(ZombieHP)

func _physics_process(_delta):
	
	_logic()
	move_and_slide()



#сигналы
func _on_detect_zone_body_entered(body):

	if body.is_in_group("Players"):
		
		Player = body
		state = HUNT

func _on_detect_zone_body_exited(body):
	
	if body == Player:
		
		Player = null
		state = IDLE

func _on_hit_box_area_entered(area):
	
	if area.is_in_group("weapons") && area.is_in_group("player"):
		
		Damage_Area = area


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
