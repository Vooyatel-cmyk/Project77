extends Area2D

func _ready():
	if Global.sv:
		$Sword_Animation.play("attack")
	else:
		$Sword_Animation.play("attack2")

func _physics_process(delta):
	position += transform.x * 10 * delta

func _on_sword_animation_animation_finished(anim_name):
	if anim_name == "attack":
		Global.sv = false
		queue_free()
	else:
		Global.sv = true
		queue_free()
