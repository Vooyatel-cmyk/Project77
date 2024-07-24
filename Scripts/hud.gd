extends CanvasLayer

func _displaydata():
	#Выводит инфу в худ
	$MarginContainer/HP.text ="HP: " + str(Global.PlayerHP)

func _process(_delta):
	_displaydata()


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
