extends CanvasLayer

@onready var HP = $MarginContainer/HP

func _ready():
	pass
	
func _displaydata():
	HP.text ="HP: " + str(Global.PlayerHP)

func _process(_delta):
	_displaydata()
