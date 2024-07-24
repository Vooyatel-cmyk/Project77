extends Node

#Для хранения глобальных переменных и функций

const PlayerSpeed = 200

var PlayerStamina = 50

var PlayerHP = 100

var PlayerResistPhys = 10
var PlayerResistMagic = 50

func _EXIT_GAME():
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
