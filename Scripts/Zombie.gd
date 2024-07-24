extends CharacterBody2D
var Player: CharacterBody2D
enum{
	IDLE,
	HUNT
}
var state = IDLE
const RunSpeed = 150
const IdleSpeed = 100


func _Zombie_AI(_dt):
	if state == IDLE && $Timer.time_left == 0:
		velocity = transform.x * IdleSpeed
		$Timer.start()
	elif state == HUNT:
		$Timer.stop()
		var t = (Player.global_position - self.global_position).normalized()
		velocity = t * RunSpeed
		look_at(Player.global_position)

func _physics_process(delta):
	_Zombie_AI(delta)
	move_and_slide()

func _on_detect_zone_body_entered(body):
	if body.is_in_group("Players"):
		Player = body
		state = HUNT


func _on_detect_zone_body_exited(body):
	if body == Player:
		Player = null
		state = IDLE
