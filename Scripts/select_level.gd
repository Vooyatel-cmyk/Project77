extends CanvasLayer




func _on_test_level_1_pressed():
	get_tree().change_scene_to_file("res://Prefabs/Levels/test_level_1.tscn")


func _on_test_level_2_pressed():
	pass # Replace with function body.


func _on_back_pressed():
	visible = false
	$"../MainMenu".visible = true
