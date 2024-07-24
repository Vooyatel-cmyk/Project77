extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _on_play_pressed():
	visible = false
	$"../SelectLevel".visible = true

func _on_exit_pressed():
	get_tree().quit()
