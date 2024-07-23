extends CanvasLayer

func _displaydata():
	#Выводит инфу в худ
	$MarginContainer/HP.text ="HP: " + str(Global.PlayerHP)

func _process(_delta):
	_displaydata()
