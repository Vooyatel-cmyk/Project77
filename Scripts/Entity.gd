extends CharacterBody2D

#Переменные
@export var movementSpeed = 150
@export var runSpeed = 300
@export var invincible = false
var invincibleTimer
var animator

var Damage_Area = null
#Функции

func _death(_hp = 100):
	
	if _hp != null: #Функция смерти
		
		if _hp <= 0 && !invincible:
			Global.score += 1
			queue_free()

func _move(_dt = null):
	pass
	
func _attack(_dt):
	pass
	
func _sprint():
	pass

func _on_hit_box_area_entered(area):
	
	if area.is_in_group("weapons") && area.is_in_group("player"):
		
		Damage_Area = area

func _on_hit_box_area_exited(area):
	
	if area == Damage_Area:
		
		Damage_Area = null
