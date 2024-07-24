extends CanvasLayer

func _ready():
	pass # Replace with function body.

func _on_play_pressed():
	visible = not visible
	$"../SelectLevel".visible = not $"../SelectLevel".visible

func _on_exit_pressed():
	get_tree().quit()
