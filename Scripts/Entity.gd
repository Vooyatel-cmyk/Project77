extends CharacterBody2D

#Переменные

var hp = 100
var movementSpeed = 150
var runSpeed = 300
var Damage_Area = null
const INVINCIBLE = false

#Функции

func _death():
	#Функция смерти
	if hp <= 0 && !INVINCIBLE:
		queue_free()

func _takeDamage(damage = 1):
	if $InvincibleTimer.time_left == 0 && Damage_Area != null:
		hp -= damage
		$AnimationPlayer.play("take_damage")
		$InvincibleTimer.start()

func _move():
	pass
	
func _attack():
	pass
	
func _sprint():
	pass

func _on_hit_box_area_entered(area):
	if area.is_in_group("weapons"):
		Damage_Area = area
func _on_hit_box_area_exited(area):
	if area == Damage_Area:
		Damage_Area = null
