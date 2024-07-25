extends "res://Scripts/Entity.gd"

var state = IDLE
var Player: CharacterBody2D
enum{
	HUNT,
	IDLE
}

func _ready():
	movementSpeed = 50
	runSpeed = 150

func _move(dt = null):
	if state == IDLE && $Timer.time_left == 0:
		velocity = transform.x * movementSpeed
		$Timer.start()
	elif state == HUNT:
		$Timer.stop()
		var t = (Player.global_position - self.global_position).normalized()
		velocity = t * runSpeed
		look_at(Player.global_position)

func _logic():
	print(hp)
	_takeDamage(10)
	_move()
	_death(hp)

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
