extends CharacterBody2D

#Переменные

@export var movementSpeed = 150
@export var runSpeed = 300
var Damage_Area = null
@export var INVINCIBLE = false

#Функции

func _death(_hp = 100):
	#Функция смерти
	if _hp != null:
		if _hp <= 0 && !INVINCIBLE:
			queue_free()

func _move(_dt = null):
	pass
	
func _attack(_dt):
	pass
	
func _sprint():
	pass

func _on_hit_box_area_entered(area):
	if area.is_in_group("weapons"):
		Damage_Area = area
func _on_hit_box_area_exited(area):
	if area == Damage_Area:
		Damage_Area = null
