extends HBoxContainer

var buttons = preload("res://Button/Backpack_button.tscn")

func _on_Punch_Button_pressed():
	GlobalVar.Punch_and_Place = true
	$Punch_Button.text = "Punch"

func _ready():
	await get_tree().create_timer(0.12).timeout
	#Remove()
	for i in GlobalVar.Block_json["Block"] :#GlobalVar.Block_list.size():
		var button_instance = buttons.instantiate()
		remove_child(get_node("ScrollContainer/HBoxContainer/" + i + "_Block"))
		if GlobalVar.Block_json["Block"][i]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + i + "_Block"):
			button_instance.name = i + "_Block"
			button_instance.name_item = i
			button_instance.type = 2
			button_instance.Node_Type = "Block"
			$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
		else :
			pass
			#print("Tidak ada")
	for i in GlobalVar.Block_json["Seed"] :
		var button_instance = buttons.instantiate()
		for a in GlobalVar.Block_json["Seed"][i] :
			remove_child(get_node("ScrollContainer/HBoxContainer/" + a + "_Seed"))
			if GlobalVar.Block_json["Seed"][i][a]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + a + "_Seed"):
				button_instance.name = a + "_Seed"
				button_instance.Seed_name_type = i
				button_instance.name_item = a
				button_instance.type = 1
				button_instance.Node_Type = "Seed"
				$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
			else :
				pass
	
	for i in GlobalVar.Block_json["Wallpaper"] :
		var button_instance = buttons.instantiate()
		remove_child(get_node("ScrollContainer/HBoxContainer/" + i + "_Wallpaper"))
		if GlobalVar.Block_json["Wallpaper"][i]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + i + "_Wallpaper"):
			button_instance.name = i + "_Wallpaper"
			button_instance.name_item = i
			button_instance.type = 3
			button_instance.Node_Type = "Wallpaper"
			$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
		else :
			pass

func Add():
	await get_tree().create_timer(0.12).timeout
	#Remove()
	for i in GlobalVar.Bp_Block :#GlobalVar.Block_list.size():
		var button_instance = buttons.instantiate()
		if GlobalVar.Block_json["Block"][i]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + i + "_Block"):
			button_instance.name = i + "_Block"
			button_instance.name_item = i
			button_instance.type = 2
			button_instance.Node_Type = "Block"
			if get_node("ScrollContainer/HBoxContainer/" + i + "_Block") :
				Remove(i + "_Block")
			$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
			GlobalVar.Bp_Block.erase(i)
		else :
			pass
			#print("Tidak ada")
	for i in GlobalVar.Bp_Seed :
		var Name_seed : String = str(i)
		var button_instance = buttons.instantiate()
		if Name_seed.ends_with("_Wallpaper") and GlobalVar.Block_json["Seed"][Name_seed.erase(Name_seed.length()-10,10)][i]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + i + "_Seed"):
			button_instance.name = i + "_Seed"
			button_instance.name_item = i
			button_instance.Seed_name_type = Name_seed.erase(Name_seed.length()-10,10)
			button_instance.type = 1
			button_instance.Node_Type = "Seed"
			if get_node("ScrollContainer/HBoxContainer/" + i + "_Seed") :
				Remove(i + "_Seed")
			$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
			GlobalVar.Bp_Seed.erase(i)
		elif Name_seed.ends_with("_Block") and GlobalVar.Block_json["Seed"][Name_seed.erase(Name_seed.length()-6,6)][i]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + i + "_Seed"):
			button_instance.name = i + "_Seed"
			button_instance.name_item = i
			button_instance.Seed_name_type = Name_seed.erase(Name_seed.length()-6,6)
			button_instance.type = 1
			button_instance.Node_Type = "Seed"
			if get_node("ScrollContainer/HBoxContainer/" + i + "_Seed") :
				Remove(i + "_Seed")
			$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
			GlobalVar.Bp_Seed.erase(i)
		
	for i in GlobalVar.Bp_Wallpaper :
		var button_instance = buttons.instantiate()
		if GlobalVar.Block_json["Wallpaper"][i]["value"] > 0 and $ScrollContainer/HBoxContainer.get_child_count() <= GlobalVar.BP_Max and !get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + i + "_Wallpaper"):
			button_instance.name = i + "_Wallpaper"
			button_instance.name_item = i
			button_instance.type = 3
			button_instance.Node_Type = "Wallpaper"
			if get_node("ScrollContainer/HBoxContainer/" + i + "_Wallpaper") :
				Remove(i + "_Wallpaper")
			$ScrollContainer/HBoxContainer.call_deferred("add_child",button_instance)
			GlobalVar.Bp_Wallpaper.erase(i)
		#var button_instance = buttons.instance()
		#button_instance.name_item = str(i)
		#$ScrollContainer/GridContainer.add_child(button_instance)

func Remove(Name): #Backpack Removed
	var Get_Node = get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer/ScrollContainer/HBoxContainer/" + Name)
	for i in $ScrollContainer/HBoxContainer.get_children() :
		if i.name.begins_with("@"):
			$ScrollContainer/HBoxContainer.remove_child(i)
		if Get_Node :
			$ScrollContainer/HBoxContainer.remove_child(Get_Node)
		
	#for i in $ScrollContainer/HBoxContainer.get_children():
		#$ScrollContainer/HBoxContainer.remove_child(i)
		#GlobalVar.BP = 0

func _on_Drop_Button_pressed():
	if GlobalVar.item_select != "":
		if GlobalVar.Item_select_Type == "Seed" :
			Remove(GlobalVar.item_select + "_Seed")
		elif GlobalVar.Item_select_Type == "Block":
			Remove(GlobalVar.item_select + "_Block")
		elif GlobalVar.Item_select_Type == "Wallpaper" :
			Remove(GlobalVar.item_select + "_Wallpaper")
		get_tree().get_root().get_node("Game/Player").drop_item()
		Add()

func _on_Info_Button_pressed():
	pass # Replace with function body.
