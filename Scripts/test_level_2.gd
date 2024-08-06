extends Node2D

const ZOMBIE = preload("res://Prefabs/Zombie_entity.tscn")

func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass
func _zombie_spawn():
		var zombie = ZOMBIE.instantiate()
		zombie.position = Vector2(-64 , randi_range(64, 1024))
		add_child(zombie)


func _on_spawn_timer_timeout():
	_zombie_spawn()
