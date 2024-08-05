extends "res://Scripts/Entity.gd"

var ZombieHP
var state = IDLE
var Player: CharacterBody2D
enum{
	HUNT,
	IDLE
}

func _ready():
	ZombieHP = 30
	movementSpeed = 50
	runSpeed = 150
	$AnimationPlayer.play("RESET")

func _takeDamage(_damage = 1, _hp = 100):
	if $InvincibleTimer.time_left == 0 && Damage_Area != null && !Damage_Area.is_in_group("oneshot"):
		$AnimationPlayer.play("damage")
		_hp -= _damage
		$InvincibleTimer.start()
		return _hp
	elif Damage_Area != null && Damage_Area.is_in_group("oneshot"):
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

func _logic():
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
