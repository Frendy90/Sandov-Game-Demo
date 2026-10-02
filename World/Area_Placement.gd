extends ShapeCast2D

var Block = preload("res://Block/Block.tscn")
var Trees = preload("res://Block/Tree.tscn")
var area
var input

var touching = false

func _ready():
	set_process(false)

func _on_Area2D_input_event(viewport, event, shape_idx):
	#var block_instance = Block.instance()
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		Add_block()
			
func Add_block():
	input = true
	var block_instance = Block.instance()
	var tree_instance = Trees.instance()
	var Pos = GlobalVar.tile.local_to_map(global_position)
	var local_pos = GlobalVar.tile.map_to_local(Pos)
	var world_pos = GlobalVar.tile.to_global(local_pos)
	GlobalVar.Pos_of_placement_actived = world_pos
	if GlobalVar.type == 1 :
		tree_instance.seed_name = str(GlobalVar.item_select)
		tree_instance.position = world_pos
		get_tree().get_root().get_node("Game/Tile").add_child(tree_instance)
	elif GlobalVar.type == 2 :
		block_instance.position = world_pos
		block_instance.name_block = str(GlobalVar.item_select)
		get_tree().get_root().get_node("Game/Tile").add_child(block_instance)
	#yield(get_tree().create_timer(0.8),"timeout")
	input = false
	#elif event is InputEventScreenDrag :
		#var Pos = GlobalVar.tile.world_to_map(global_position)
		#var local_pos = GlobalVar.tile.map_to_world(Pos)
		#var world_pos = GlobalVar.tile.to_global(local_pos)
		#GlobalVar.Pos_of_placement_actived = world_pos

func _process(delta):
	#$Label.text = str(area)
	area = collision_result
	if area :
		#$CollisionShape2D.disabled = true
		$Area2D.hide()
		#GlobalVar.placement_body = true
		$Sprite2D.texture = load("res://Assets/Effect/Effect_placement_1.png")
	else : 
		$Area2D.show()
		#$CollisionShape2D.disabled = false
		#GlobalVar.placement_body = false
		$Sprite2D.texture = load("res://Assets/Effect/Effect_placement_2.png")
