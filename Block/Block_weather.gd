extends StaticBody2D

var Node_Type : String = "Block"
var seeds = preload("res://Seed/Seed.tscn")
var Gems = preload("res://Seed/Items.tscn")
var break_effect = preload("res://Block/Break_effect.tscn")
@onready var Background : Sprite2D = get_tree().get_root().get_node("Game/Background/Parallax2D/Bg")

@export var name_block : String
@export var Heath = 10
@export var Type_droped : Array = ["","Block","Block_Seed"]
@export var Actived : bool 
var h = 0 #Healt point
var Special #Can drop seed or not
var Rand = 4 #Gems and items system dropped


#func _process(delta):
#	var Pos = GlobalVar.tile.world_to_map(GlobalVar.touch)
#	var local_pos = GlobalVar.tile.map_to_world(Pos)
#	var world_pos = GlobalVar.tile.to_global(local_pos)
#	global_position = world_pos

func _ready():
	$Sprite2D.texture = load("res://Assets/Block/" + str(name_block) + "_Block.png")
	Heath = GlobalVar.Block_json["Block"][str(name_block)]["Breakhit"]
	Special = GlobalVar.Block_json["Block"][str(name_block)]["Seeddrop"]
	collision_layer = GlobalVar.Block_json["Block"][str(name_block)]["Layer_type"]
	h = Heath
	await get_tree().create_timer(0.2).timeout
	get_tree().get_root().get_node("Game/Placement_Area").count_place = 1


func _on_Area2D_input_event(viewport, event, shape_idx):
	randomize()
	var seed_instance = seeds.instantiate()
	var Gems_instance = Gems.instantiate()
	var break_instance = break_effect.instantiate()
	if event is InputEventScreenDrag or event is InputEventScreenTouch :
		if GlobalVar.Punch_and_Place:
			$Timer.start(1)
			$AnimatedSprite2D.show()
			Heath -= GlobalVar.Damage
			break_instance.position = position
			get_tree().get_root().call_deferred("add_child",break_instance)
			if !Actived :
				Background.texture = load(str(GlobalVar.Block_json["Block"][str(name_block)]["Etc"]["Background"]))
				await get_tree().create_timer(0.2).timeout
				Actived = true
			else :
				Background.texture = null
				await get_tree().create_timer(0.2).timeout
				Actived = !Actived
				

			if Heath == (h-1) :
				$AnimatedSprite2D.play("1")
			elif Heath == (h-3):
				$AnimatedSprite2D.play("2")
			elif Heath == (h - 5):
				$AnimatedSprite2D.play("3")
			elif Heath > (h - 8) :
				$AnimatedSprite2D.play("4")
			if Heath < 0 and Special:
				for i in Rand:
					if i >= 1 and i < 2 :
						seed_instance.Type_seed = Type_droped[randi() % Type_droped.size()]
						seed_instance.seed_name = name_block
						get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
						seed_instance.position = Vector2(randf_range(position.x-10,position.x +10),randf_range(position.y-10,position.y +10))
					else :
					#Gems Drop
						Gems_instance.set_script(load("res://Seed/Gems.gd"))
						Gems_instance.Type_seed = "Gems"
						Gems_instance.count = randi_range(0,GlobalVar.Block_json["Block"][str(name_block)]["Gemsdrop"])
						get_tree().get_root().get_node("Game/Item").call_deferred("add_child",Gems_instance)
						Gems_instance.position = Vector2(randf_range(position.x-10,position.x +10),randf_range(position.y-10,position.y +10))
					queue_free()
			elif Heath < 0 and !Special:
				seed_instance.Type_seed = "Block"
				seed_instance.seed_name = name_block
				get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
				seed_instance.position = Vector2(randf_range(position.x-10,position.x +10),randf_range(position.y-10,position.y +10))
				
				Background.texture = null
				queue_free()
		get_tree().get_root().get_node("Game/Player/Body/Arm").play("Break")
		await get_tree().create_timer(0.1).timeout
		get_tree().get_root().get_node("Game/Player/Body/Arm").stop()

func _on_timer_timeout() -> void:
	Heath = h
	$AnimatedSprite2D.hide()
	$AnimatedSprite2D.play("none")

func Block_ex():
	pass
