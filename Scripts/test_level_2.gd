extends Node2D

const ZOMBIE = preload("res://Prefabs/Zombie_entity.tscn")

func _ready():
	Global.score = 0
	Global.PlayerHP = 100
	Global.PlayerStamina = 50


func _process(_delta):
	pass
func _zombie_spawn():
		var zombie = ZOMBIE.instantiate()
		zombie.position = Vector2(-64 , randi_range(64, 1024))
		add_child(zombie)


func _on_spawn_timer_timeout():
	_zombie_spawn()


func _on_timer_timeout():
	Global.score += 1
