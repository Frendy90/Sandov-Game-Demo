extends Area2D

var Node_Type : String = "Seed"
@export var Type_seed : String
@export var count = 1
@export var seed_name : String
@export var type : int
var p

func _ready():
	if count < 1 :
		queue_free()
	$Anim.play("First")
	#$Label.text = str(seed_name)
	if Type_seed == "Gems" :
		if count >= 1 and count < 5:
			$Sprite2D.texture = load("res://Assets/Item/Gems_1.png")
		elif count >= 5 and count < 10 :
			$Sprite2D.texture = load("res://Assets/Item/Gems_2.png")
		elif count >= 10 and count < 20 :
			$Sprite2D.texture = load("res://Assets/Item/Gems_3.png")
		
	#seed_name.erase(seed_name.length(),10)
	#print(seed_name)

func _on_Seed_body_entered(body : Node2D):
	if body.has_method("get_item"):
		body.get_item()
		#print(GlobalVar.backpack)
			#GlobalVar.backpack[{seed_name : {"value" : 1,"type" : type}}
		if body :
			GlobalVar.Gems += count
			queue_free()

func Update():
	if Type_seed == "Block_Seed" :
		GlobalVar.Bp_Seed.append(seed_name + "_Block")
		get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(seed_name + "_Block" + "_Seed")
	elif Type_seed == "Wallpaper_Seed" :
		GlobalVar.Bp_Seed.append(seed_name + "_Wallpaper")
		get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(seed_name + "_Wallpaper" + "_Seed")
		#get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + str(seed_name + "_Seed"))._ready()
	elif Type_seed == "Block" :
		GlobalVar.Bp_Block.append(seed_name)
		get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(seed_name + "_Block")
	elif Type_seed == "Wallpaper" :
		GlobalVar.Bp_Wallpaper.append(seed_name) 
		get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(seed_name + "_Wallpaper")
		#get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + str(seed_name + "_Block"))._ready()
	else :
		pass
		
	get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Add()
	queue_free()
