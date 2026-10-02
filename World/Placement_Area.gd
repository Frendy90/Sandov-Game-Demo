extends ShapeCast2D

var Blocks = preload("res://Block/Block.tscn")
var Trees = preload("res://Block/Tree.tscn")
var Wallpapers = preload("res://Block/Wallpaper.tscn")
var input = false

@export var count_place : int = 1
var Body
var Body_Detec

func _physics_process(delta: float) -> void:
	Body = get_collider(0)
	if Body :
		$Sprite2D.play("Red")
	else :
		$Sprite2D.play("Green")
		
	if GlobalVar.Item_select_Type == "Wallpaper" :
		collision_mask = 7
		collide_with_areas = true
		collide_with_bodies = false
	elif GlobalVar.Item_select_Type == "Block":
		collision_mask = 3
		collide_with_areas = false
		collide_with_bodies = true
	else :
		collide_with_areas = false
		collide_with_bodies = true
		collision_mask = 3

#func _input(event: InputEvent) -> void:
	##if event is InputEventScreenTouch :
	##	if !GlobalVar.Punch_and_Place :
	##		var Pos = GlobalVar.tile.world_to_map(GlobalVar.Canvas_pos)
	##		var l_pos = GlobalVar.tile.map_to_world(Pos)
	##		var w_pos = GlobalVar.tile.to_global(l_pos)
	##		add = true
	##		Add(w_pos,event.pressed)
	#if !Body :
		#if event is InputEventScreenDrag or InputEventScreenTouch:
			#if !GlobalVar.Punch_and_Place and count_place > 0 :
				##var Pos = GlobalVar.tile.local_to_map(GlobalVar.Canvas_pos)
				##var l_pos = GlobalVar.tile.map_to_local(Pos)
				##var w_pos = GlobalVar.tile.to_global(l_pos)
				#count_place = 0
				#Add(global_position)

func Add(EventPos,):
	if GlobalVar.Item_select_Type == "Seed" :
		if GlobalVar.item_select.ends_with("_Block") and GlobalVar.Block_json["Seed"][str(GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6))][GlobalVar.item_select]["value"] >= 1:
			var tree_instance = Trees.instantiate()
			tree_instance.position = EventPos
			tree_instance.seed_name = str(GlobalVar.item_select)
			GlobalVar.Block_json["Seed"][str(GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6))][GlobalVar.item_select]["value"] -= 1
			get_tree().get_root().get_node("Game/Tile").call_deferred("add_child",tree_instance)
			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + str(GlobalVar.item_select + "_Seed"))._ready()
		elif GlobalVar.item_select.ends_with("_Wallpaper") and GlobalVar.Block_json["Seed"][str(GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10))][GlobalVar.item_select]["value"] >= 1:
			var tree_instance = Trees.instantiate()
			tree_instance.position = EventPos
			tree_instance.seed_name = str(GlobalVar.item_select)
			GlobalVar.Block_json["Seed"][str(GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10))][GlobalVar.item_select]["value"] -= 1
			get_tree().get_root().get_node("Game/Tile").call_deferred("add_child",tree_instance)
			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + str(GlobalVar.item_select + "_Seed"))._ready()
		else :
			GlobalVar.Punch_and_Place = true
			GlobalVar.item_select = ""
			await get_tree().create_timer(0.2).timeout
			count_place = 1
	elif GlobalVar.Item_select_Type == "Block" and GlobalVar.Block_json["Block"][str(GlobalVar.item_select)]["value"] >= 1:
		var block_instance = Blocks.instantiate()
		if GlobalVar.Block_json["Block"][str(GlobalVar.item_select)]["OwnedScript"] and GlobalVar.Block_json["Block"][str(GlobalVar.item_select)]["TypeBlock"] == "Create":
			block_instance.set_script(load("res://Block/Block_create.gd"))
		elif GlobalVar.Block_json["Block"][str(GlobalVar.item_select)]["OwnedScript"] and GlobalVar.Block_json["Block"][str(GlobalVar.item_select)]["TypeBlock"] == "Weather":
			block_instance.set_script(load("res://Block/Block_weather.gd"))
		block_instance.position = EventPos
		block_instance.name_block = str(GlobalVar.item_select)
		GlobalVar.Block_json["Block"][str(GlobalVar.item_select)]["value"] -= 1
		get_tree().get_root().get_node("Game/Tile").call_deferred("add_child",block_instance)
		get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + str(GlobalVar.item_select + "_Block"))._ready()
	elif GlobalVar.Item_select_Type == "Wallpaper" and GlobalVar.Block_json["Wallpaper"][str(GlobalVar.item_select)]["value"] >= 1:
		var block_instance = Wallpapers.instantiate()
		block_instance.position = EventPos
		block_instance.name_block = str(GlobalVar.item_select)
		GlobalVar.Block_json["Wallpaper"][str(GlobalVar.item_select)]["value"] -= 1
		get_tree().get_root().get_node("Game/Tile").call_deferred("add_child",block_instance)
		get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + str(GlobalVar.item_select + "_Wallpaper"))._ready()
	else :
		GlobalVar.Punch_and_Place = true
		GlobalVar.item_select = ""
		await get_tree().create_timer(0.2).timeout
		count_place = 1


func _on_touch_layer_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !Body :
		if event is InputEventScreenDrag or InputEventScreenTouch:
			if !GlobalVar.Punch_and_Place and count_place > 0 :
				#var Pos = GlobalVar.tile.local_to_map(GlobalVar.Canvas_pos)
				#var l_pos = GlobalVar.tile.map_to_local(Pos)
				#var w_pos = GlobalVar.tile.to_global(l_pos)
				count_place = 0
				Add(global_position)
