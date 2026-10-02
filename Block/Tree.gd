extends StaticBody2D

var Node_Type : String = "Tree"
var name_block : String = "Bedrock"
var Seeds = preload("res://Seed/Seed.tscn")
#var Block = preload("res://Block/Block.tscn")
var break_effect = preload("res://Block/Break_effect.tscn")

@export var new : bool = true
@export var seed_name : String
@export var Times : int = 10
@export var type : int
@export var Punch : bool = false
@export var text_show : bool = false
@export var health : int = 5
@export var Type_seed : String

func _ready():
	#await get_tree().create_timer(0.15).timeout
	#var body = $Legs.get_overlapping_bodies()
	if seed_name.ends_with("_Block") :
		health = GlobalVar.Block_json["Seed"][seed_name.erase(seed_name.length()-6,6)][seed_name]["Breakhit"]
		$Sprite2D.texture = load("res://Assets/Block/Tree_Block.png")
	elif seed_name.ends_with("_Wallpaper") :
		health = GlobalVar.Block_json["Seed"][seed_name.erase(seed_name.length()-10,10)][seed_name]["Breakhit"]
		$Sprite2D.texture = load("res://Assets/Block/Tree1_Block.png")
	$Label.hide()
	if new :
		if seed_name.ends_with("_Block") :
			Times = GlobalVar.Block_json["Seed"][seed_name.erase(seed_name.length()-6,6)][seed_name]["Time"]
		elif seed_name.ends_with("_Wallpaper") :
			Times = GlobalVar.Block_json["Seed"][seed_name.erase(seed_name.length()-10,10)][seed_name]["Time"]
			
	if Times > 0 :
		$Timer.start(1)
	else :
		finished()

	await get_tree().create_timer(0.2).timeout
	get_tree().get_root().get_node("Game/Placement_Area").count_place = 1
	#$Label.text = str(Times)
#func _process(delta: float) -> void:
	#var seed_instance = Seeds.instantiate()
	#var body = $Legs.get_overlapping_bodies()
	#if body :
		#pass
	#else :
		#seed_instance.count = 1
		#seed_instance.type = 1
		#seed_instance.position = global_position
		#seed_instance.seed_name = seed_name
		#get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
		#seed_instance.position = Vector2(randf_range(position.x-10,position.x +10),randf_range(position.y-10,position.y +10))
		#queue_free()

func finished():
	$Timer.stop()
	Punch = true
	if seed_name.ends_with("_Block") : 
		$Sprite2D/Sprite2D.texture = load("res://Assets/Block/" + seed_name.erase(seed_name.length()-6,6) + "_Block.png")
	elif seed_name.ends_with("_Wallpaper") :
		$Sprite2D/Sprite2D.texture = load("res://Assets/Wallpaper/" + seed_name.erase(seed_name.length()-10,10) + "_Wallpaper.png")
		
	$Label.text = str(seed_name) + "\nTree Already Harvest"

func Finish():
	var seed_instance = Seeds.instantiate()
	var break_instance = break_effect.instantiate()
	if Punch :
		if seed_name.ends_with("_Block") :
			seed_instance.Type_seed = "Block"
			seed_instance.position = global_position
			seed_instance.seed_name = seed_name.erase(seed_name.length()-6,6)
			seed_instance.count = 1 + randi() % 5 #Jumlah Nilai drop
			break_instance.position = global_position
			get_tree().get_root().call_deferred("add_child",break_instance)
			get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
			seed_instance.position = Vector2(randf_range(position.x-10,position.x +10),randf_range(position.y-10,position.y +10))
			queue_free()
		elif seed_name.ends_with("_Wallpaper") :
			seed_instance.Type_seed = "Wallpaper"
			seed_instance.position = global_position
			seed_instance.seed_name = seed_name.erase(seed_name.length()-10,10)
			seed_instance.count = 1 + randi() % 5 #Jumlah Nilai drop
			break_instance.position = global_position
			get_tree().get_root().call_deferred("add_child",break_instance)
			get_tree().get_root().get_node("Game/Item").call_deferred("add_child",seed_instance)
			seed_instance.position = Vector2(randf_range(position.x-10,position.x +10),randf_range(position.y-10,position.y +10))
			queue_free()
	else :
		break_instance.position = global_position
		get_tree().get_root().call_deferred("add_child",break_instance)


func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventScreenDrag or event is InputEventScreenTouch :
		Finish()

func _on_timer_timeout() -> void:
	Times -= 1
	
	
	if text_show :
		$Label.text = str(Times)

	if Times > 0 :
		$Timer.start(1)
	else :
		finished()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.has_method("get_item") :
		body.get_item()
		text_show = true
		$Label.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.has_method("get_item"):
		body.get_item()
		text_show = false
		$Label.hide()
