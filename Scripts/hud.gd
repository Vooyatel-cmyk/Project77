extends CanvasLayer

func _displaydata():
	#Выводит инфу в худ
	$MarginContainer/VBoxContainer/HP.text ="HP: " + str(Global.PlayerHP) + "  "
	$MarginContainer/VBoxContainer/Stamina.text ="ST: " + str(Global.PlayerStamina) + "  "
	$MarginContainer/CenterContainer/Label.text ="score: " + str(Global.score)

func _process(_delta):
	_displaydata()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")


func _on_restart_pressed():
	get_tree().reload_current_scene()
	Global.PlayerHP = 100
	Global.PlayerStamina = 50
