extends ShapeCast2D

var Block = preload("res://Block/Block.tscn")

func _ready():
	pass
	#$Timer.start(2)

func add():
	var block_instance = Block.instance()
	block_instance.position = global_position
	block_instance.name_block = "Dirt"
	get_parent().get_node("Tile").add_child(block_instance)
	position.x += 32
	$Timer.start(1.5)


func _on_Timer_timeout():
	add()
