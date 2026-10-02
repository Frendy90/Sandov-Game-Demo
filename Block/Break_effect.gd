extends AnimatedSprite2D

func _ready():
	play("default")
	await get_tree().create_timer(0.35).timeout
	queue_free()
