extends Node

@export var Name : String
var gui = preload("res://World/Gui.tscn").instantiate()
var player = preload("res://World/Player.tscn").instantiate()
var block = preload("res://Block/Block.tscn")
var Wallpaper = preload("res://Block/Wallpaper.tscn")
@export var block_add = 100
@export var pos_Added = Vector2(-16,1904)
@export var pase_block_type = 0
@export var Caves_pos = 2880
@export var new_world = true
@export var player_pos_world = Vector2(0,1920)
var Pack = PackedScene.new()

func _ready():
	GlobalVar.tile = $TileMap
	await get_tree().create_timer(0.5).timeout
	if new_world :
		add()
		Name = GlobalVar.name_wolrd
		player_pos_world.x = (1 + randi() % 30) * 64
		Create_folder_data()
	else :
		var Block_data = ResourceLoader.load(GlobalVar.Doc + "/"  + "Eb World" + "/" + Name + "/" + "Block" + ".tres") as SceneData
		
		for i in Block_data.Nodes :
			var Blocks = i.instantiate()
			if Blocks.Node_Type == "Seed" :
				$Item.add_child(Blocks)
			else :
				$Tile.add_child(Blocks)

	await get_tree().create_timer(0.5).timeout
	player.position = player_pos_world
	add_child(player)
	add_child(gui)

func Create_folder_data():
	if DirAccess.dir_exists_absolute(GlobalVar.Doc + "/" + "Eb World" + "/" + Name):
		pass
	else :
		DirAccess.make_dir_recursive_absolute(GlobalVar.Doc + "/" + "Eb World" + "/" + Name)

func add():
	var tile = $TileMap.get_world_2d()
	print(tile)
	randomize()
	while block_add :
		var A = randi() % 10
		var blocks = block.instantiate()
		var Wallpapers = Wallpaper.instantiate()
		blocks.position = pos_Added
		Wallpapers.position = pos_Added
		#player_pos_world.x = randi() % 256
		if pos_Added.y == 1904 :
			blocks.name_block = "Grass_Dirt"
			Wallpapers.name_block = "Grass_Dirt"
		else :
			if pos_Added.y > 1904 and pos_Added.y <= Caves_pos:
				pase_block_type = A
				if pase_block_type == 4:
					blocks.name_block = "Rock"
				else :
					blocks.name_block = "Dirt"
			elif pos_Added.y > Caves_pos and pos_Added.y <= 3008:
				pase_block_type = A
				if pase_block_type == 2 :
					blocks.name_block = "Lava"
				elif pase_block_type == 4 :
					blocks.name_block = "Rock"
				else : 
					blocks.name_block = "Dirt"
			else :
				blocks.name_block = "Bedrock"
				Wallpapers.name_block = "Dirt"

		pos_Added.x += 32
		$Tile.add_child(Wallpapers)
		$Tile.add_child(blocks)
		block_add -= 1
		if block_add < 1 :
			pos_Added.x = -16
			pos_Added.y += 32
			block_add = 100

		if pos_Added.y >= 3296 :
			new_world = false
			break

#func _physics_process(delta: float) -> void:
	#var Players = get_tree().get_root().get_node("Game/Player")
	#if Players :
		#if $Placement_Area.global_position.length() >= Players.global_position.length() :
			#$Placement_Area.global_position.length() 
		#var l = $Player.global_position
		#print(l.length())
#func _input(event):
	#if event is InputEventScreenDrag and !GlobalVar.placement_body and !GlobalVar.Punch_and_Place:
		#var blocks = block.instance()
		#GlobalVar.touch = event.position
		#var Pos = GlobalVar.tile.world_to_map(event.global_position)
		#var local_pos = GlobalVar.tile.map_to_world(Pos)
		#var world_pos = GlobalVar.tile.to_global(local_pos)
		#blocks.name_block = str(GlobalVar.item_select)
		#blocks.global_position = GlobalVar.Pos_of_placement_actived
		#$Tile.add_child(blocks)

func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST :#or NOTIFICATION_WM_GO_BACK_REQUEST:
		remove_child(gui)
		remove_child(player)
		save(what)

func SV():
	remove_child(gui)
	remove_child(player)
	save(0)
	get_tree().change_scene_to_file("res://World/Menu.tscn")

func save(what):
	var data = SceneData.new()
	var Block = $Tile.get_children()
	var Floating = $Item.get_children()
	for Blocks in Block :
		var Block_scene = PackedScene.new()
		Block_scene.pack(Blocks)
		data.Nodes.append(Block_scene)
		
	for items in Floating :
		var items_scene = PackedScene.new()
		items_scene.pack(items)
		data.Nodes.append(items_scene)
	
	for a in self.get_children():
		a.set_owner(self)

	Pack.pack(self)
	ResourceSaver.save(Pack,GlobalVar.Doc + "/"  + "Eb World" + "/" + Name + "/" + "World" + ".tscn")
	ResourceSaver.save(data,GlobalVar.Doc + "/"  + "Eb World" + "/" + Name + "/" + "Block" + ".tres")
	
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_WM_GO_BACK_REQUEST:
		get_tree().quit()
	
func _input(event: InputEvent) -> void:
	if event is InputEventScreenDrag :
		GlobalVar.Canvas_pos = get_viewport().get_canvas_transform().affine_inverse() * event.position + Vector2(-5,-5)
		var Pos = GlobalVar.tile.local_to_map(GlobalVar.Canvas_pos)
		var l_pos = GlobalVar.tile.map_to_local(Pos)
		var w_pos = GlobalVar.tile.to_global(l_pos)
		$Placement_Area.position = l_pos

	#if get_node("Player") :
		#$Sprite2D.scale = (get_node("Player/Camera2D").zoom)/1.5
