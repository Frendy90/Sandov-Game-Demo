extends Area2D

var Node_Type : String = "Seed"
@export var Type_seed : String
@export var count = 1
@export var seed_name : String
@export var type : int
var p


#var seeds = preload("res://Seed/Seed.tscn")
func _ready():
	if count < 1 :
		queue_free()
	$Anim.play("First")
	#$Label.text = str(seed_name)
	if count > 1:
		$Label.text = str(int(count))
	#seed_name.erase(seed_name.length(),10)
	#print(seed_name)
	if Type_seed == "Block_Seed" or Type_seed == "Wallpaper_Seed":
		$Sprite2D.texture = load("res://Assets/Seed" + "/" + str(seed_name) + "_Block_Seed" + ".png")
		$Frame.texture = load("res://Assets/Effect/Seed_Frame.png")
	elif Type_seed == "Block" :
		$Sprite2D.scale = Vector2(0.5,0.5)
		$Sprite2D.texture = load("res://Assets/Block" + "/" + str(seed_name) + "_Block" + ".png")
		$Frame.texture = load("res://Assets/Effect/Block_Frame.png")
	elif Type_seed == "Wallpaper" :
		$Sprite2D.modulate = Color(0.45, 0.45, 0.45, 1.0)
		$Sprite2D.scale = Vector2(0.5,0.5)
		$Sprite2D.texture = load("res://Assets/Wallpaper" + "/" + str(seed_name) + "_Wallpaper" + ".png")
		$Frame.texture = load("res://Assets/Effect/Wallpaper_Frame.png")
	else :
		queue_free()

func _on_Seed_body_entered(body : Node2D):
	if body.has_method("get_item"):
		body.get_item()
		#print(GlobalVar.backpack)
			#GlobalVar.backpack[{seed_name : {"value" : 1,"type" : type}}
		if GlobalVar.Block_json["Block"][seed_name]["Seeddrop"]:
			if GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Block"]["value"] < 1 and Type_seed == "Block_Seed" and GlobalVar.Block_json["Block"][seed_name]["Seeddrop"]:
				if get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer").get_child_count() < GlobalVar.BP_Max :
					GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Block"]["value"] += count
					Update()
			elif GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Block"]["value"] > 0 and Type_seed == "Block_Seed" and GlobalVar.Block_json["Block"][seed_name]["Seeddrop"]:
				GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Block"]["value"] += count
				Update()
				#get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Update()
				queue_free()
		
		if GlobalVar.Block_json["Wallpaper"][seed_name]["Seeddrop"] :
			if GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Wallpaper"]["value"] < 1 and Type_seed == "Wallpaper_Seed" and GlobalVar.Block_json["Wallpaper"][seed_name]["Seeddrop"] :
				if get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer").get_child_count() < GlobalVar.BP_Max :
					GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Wallpaper"]["value"] += count
					Update()
			elif GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Wallpaper"]["value"] > 0 and Type_seed == "Wallpaper_Seed" and GlobalVar.Block_json["Wallpaper"][seed_name]["Seeddrop"]:
				GlobalVar.Block_json["Seed"][seed_name][seed_name + "_Wallpaper"]["value"] += count
				Update()
				#get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Update()
				queue_free()

		if GlobalVar.Block_json["Block"][seed_name]["value"] < 1 and Type_seed == "Block" :
			if get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer").get_child_count() < GlobalVar.BP_Max :
				GlobalVar.Block_json["Block"][seed_name]["value"] += count
				Update()
	#		if GlobalVar.Block_json["Seed"][seed_name]["value"] > 0 and type == 1:
	#			GlobalVar.Block_json["Seed"][seed_name]["value"] += count
	#			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Update()
	#			queue_free()
		elif GlobalVar.Block_json["Block"][seed_name]["value"] > 0 and Type_seed == "Block":
			GlobalVar.Block_json["Block"][seed_name]["value"] += count
			Update()
			#get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Update()
			queue_free()
		
		if GlobalVar.Block_json["Wallpaper"][seed_name]["value"] < 1 and Type_seed == "Wallpaper" :
			if get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer").get_child_count() < GlobalVar.BP_Max :
				GlobalVar.Block_json["Wallpaper"][seed_name]["value"] += count
				Update()
	#		if GlobalVar.Block_json["Seed"][seed_name]["value"] > 0 and type == 1:
	#			GlobalVar.Block_json["Seed"][seed_name]["value"] += count
	#			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Update()
	#			queue_free()
		elif GlobalVar.Block_json["Wallpaper"][seed_name]["value"] > 0 and Type_seed == "Wallpaper":
			GlobalVar.Block_json["Wallpaper"][seed_name]["value"] += count
			Update()
			#get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Update()
			queue_free()
		
		#GlobalVar.Block_json
			#GlobalVar.backpack.erase(dict[])
			#print(names)
		#GlobalVar.backpack.erase(seed_name)
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


#func _on_Seed_area_entered(area):
	#var seed_instance = seeds.instance()
#	if area.name == "Seed":
		#get_tree().get_root().get_node("Game/Item").add_child(seed_instance)
		#seed_instance.count += count
	# 	queue_free()
