extends CharacterBody2D

var Node_Type : String = "Player"
var Velocity = Vector2.ZERO
var speed = 100
var Jump_value = 0
var jump_height = 50
var gravity = 10

var seeds = preload("res://Seed/Seed.tscn")

func _ready():
	pass
	#$Name/Label.draw_multiline_colors([2],Color(1,7,8,1))

func _physics_process(delta):
	var Floor = $Name/Legs.get_overlapping_bodies()
	
	var Pos = GlobalVar.tile.local_to_map(position)
	var local_pos = GlobalVar.tile.map_to_local(Pos)
	var world_pos = GlobalVar.tile.to_global(local_pos)
	GlobalVar.player_pos_in_tile = Pos
	#$Node2D.global_position = world_pos
	
	if Input.is_action_pressed("Right"):
		Velocity.x = speed
		$Body.scale.x = 1
	elif Input.is_action_pressed("Left"):
		Velocity.x = -speed
		$Body.scale.x = -1
	else :
		Velocity.x = 0
	
	Velocity.y = 100
	if Velocity.y > 120 :
		Velocity.y = 0
	
	if is_on_floor() :
		Jump_value = 0

	if Input.is_action_pressed("Jump"):
		if Jump_value <= jump_height :
			Jump_value += 2
			Velocity.y -= 600

	set_velocity(Velocity)
	move_and_slide()
	GlobalVar.player = position# GlobalVar.tile.to_global(local_pos)
	
func get_item(): #ngambil item dropped
	pass

func Block_ex(): #Wallpaper deteksi
	pass

func Player():
	pass

func drop_item():
	var seed_instance = seeds.instantiate()
	if GlobalVar.item_select.ends_with("_Wallpaper") and GlobalVar.Item_select_Type == "Seed":
		if GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10)][GlobalVar.item_select]["value"] > 0 and GlobalVar.type == 1:
			seed_instance.type = 1
			seed_instance.Type_seed = "Wallpaper_Seed"
			seed_instance.seed_name = GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10)
			seed_instance.count = GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10)][GlobalVar.item_select]["value"]
			GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10)][GlobalVar.item_select]["value"] -= GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-10,10)][GlobalVar.item_select]["value"]
			seed_instance.position = $Body/Marker2D.global_position
			get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
	elif GlobalVar.item_select.ends_with("_Block") and GlobalVar.Item_select_Type == "Seed":
		if GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6)][GlobalVar.item_select]["value"] > 0 and GlobalVar.type == 1:
			seed_instance.type = 1
			seed_instance.Type_seed = "Block_Seed"
			seed_instance.seed_name = GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6)
			seed_instance.count = GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6)][GlobalVar.item_select]["value"]
			GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6)][GlobalVar.item_select]["value"] -= GlobalVar.Block_json["Seed"][GlobalVar.item_select.erase(GlobalVar.item_select.length()-6,6)][GlobalVar.item_select]["value"]
			seed_instance.position = $Body/Marker2D.global_position
			get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
	elif GlobalVar.Block_json["Block"][GlobalVar.item_select]["value"] > 0 and GlobalVar.Item_select_Type == "Block":
		seed_instance.type = 2
		seed_instance.Type_seed = "Block"
		seed_instance.seed_name = GlobalVar.item_select
		seed_instance.count = GlobalVar.Block_json["Block"][GlobalVar.item_select]["value"]
		GlobalVar.Block_json["Block"][GlobalVar.item_select]["value"] -= GlobalVar.Block_json["Block"][GlobalVar.item_select]["value"]
		seed_instance.position = $Body/Marker2D.global_position
		get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
	elif GlobalVar.Block_json["Wallpaper"][GlobalVar.item_select]["value"] > 0 and GlobalVar.Item_select_Type == "Wallpaper":
		seed_instance.type = 3
		seed_instance.Type_seed = "Wallpaper"
		seed_instance.seed_name = GlobalVar.item_select
		seed_instance.count = GlobalVar.Block_json["Wallpaper"][GlobalVar.item_select]["value"]
		GlobalVar.Block_json["Wallpaper"][GlobalVar.item_select]["value"] -= GlobalVar.Block_json["Wallpaper"][GlobalVar.item_select]["value"]
		seed_instance.position = $Body/Marker2D.global_position
		get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
