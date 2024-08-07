extends Area2D

func _ready():
		$Sword_Animation.play("attack")

func _physics_process(delta):
	position += transform.x

func _on_sword_animation_animation_finished(_anim_name):
	queue_free()
