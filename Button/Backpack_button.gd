extends TextureButton

var Load : bool = false
var name_item : String
var Seed_name_type : String
var type
var image : Image
var Textures : ImageTexture
var s
var Node_Type : String


func _ready():
	if !Load :
		Load = true
		#GlobalVar.BP += 1
		tooltip_text = name_item

	if Node_Type == "Seed":
		$TextureRect.texture = load("res://Assets/Seed" + "/" + str(Seed_name_type) + "_Block_Seed.png")
		$Label.text = " " + str(GlobalVar.Block_json["Seed"][str(Seed_name_type)][str(name_item)]["value"])
		if GlobalVar.Block_json["Seed"][str(Seed_name_type)][str(name_item)]["value"] < 1 :
			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(name_item + "_Seed")
	elif Node_Type == "Block" :
		$TextureRect.texture = load("res://Assets/Block" + "/" + str(name_item) + "_Block.png")
		$Label.text = " " + str(GlobalVar.Block_json["Block"][str(name_item)]["value"])
		if GlobalVar.Block_json["Block"][str(name_item)]["value"] < 1 :
			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(name_item + "_Block")
	elif Node_Type == "Wallpaper":
		$TextureRect.texture = load("res://Assets/Wallpaper" + "/" + str(name_item) + "_Wallpaper.png")
		$TextureRect.modulate = Color(0.55, 0.55, 0.55, 1.0)
		$Label.text = " " + str(GlobalVar.Block_json["Wallpaper"][str(name_item)]["value"])
		if GlobalVar.Block_json["Wallpaper"][str(name_item)]["value"] < 1 :
			get_tree().get_root().get_node("Game/Gui/Control_game/HBoxContainer").Remove(name_item + "_Wallpaper")

func _pressed():
	GlobalVar.Punch_and_Place = false
	GlobalVar.item_select = name_item
	GlobalVar.type = type
	GlobalVar.Item_select_Type = Node_Type
