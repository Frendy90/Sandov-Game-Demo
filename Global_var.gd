extends Node

var tile
var touch
var player
var player_pos_in_tile

var placement_body : bool = false
var Pos_of_placement_actived
var Punch_and_Place = true
var Damage = 1
var BP_Max = 30
var BP = 0
var name_wolrd : String
var Gems : int = 200


var testvar

var item_list = {
	"Blocks" : {
		"Dirt" : {
			"Id" : "4",
			"Breakhit" : 3,
			"Description" : "Fossil Kontol",
			"Information" : "Can't drop anything"
		}
	},
	"Seeds" : {
		"Dirt" : {
			"Id" : "4",
			"Breakhit" : 5,
			"Description" : "Just plant",
			"Information" : ""
		}
	},
	"Items" : {
		"Katana" : {
			"Id" : "0001",
			"Mod" : 0,
			"Effect" : 0,
			"Information" : "",
			"Description" : ""
		}
	}
}

var backpack = []

var Bp_Seed : Array
var Bp_Block : Array
var Bp_Wallpaper : Array

var item_select : String = ""
var type : int = 0
var Item_select_Type : String

var res = "res://"
var Doc = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS)
#var Doc_Dir = DirAccess.new()
var data = []

var Block_list = []

var Block_json = {}
var Canvas_pos

func test():
	pass

func _ready() -> void:
	var get_dir = DirAccess.open("res://")
	for i in get_dir.get_directories() :
		if not i.begins_with(".") :
			data.append(i)
	
	Json_files()
	Search_Block()
	Create_game_file()
	OS.request_permissions()
	
func Json_files():
	var file = FileAccess.open(str(res) + str(data[4]) + "/" + "Data_block.json",FileAccess.READ)
	var dt_json = file.get_as_text()
	var test_json_conv = JSON.new()
	test_json_conv.parse(dt_json)
	Block_json = test_json_conv.get_data()

func Search_Block():
	var get_dir = DirAccess.open("res://Assets/Block/")
	for i in get_dir.get_files() :
		if not i.begins_with(".") and i.ends_with(".png") :
			var names = i.erase(i.length()-4,10)#-10,10
			Block_list.append(names)

func Create_game_file():
	if DirAccess.dir_exists_absolute(Doc + "/" + "Eb World"):
		pass
	else :
		DirAccess.make_dir_recursive_absolute(Doc + "/" + "Eb World")

	
#func _ready():
	#var dir = DirAccess.new()
	#dir.open(res)
	#dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	#while true:
		#var dir_name = dir.get_next()
		#if dir_name == "":
			#Search_backpack()
			#break
		#elif not dir_name.begins_with(".") and dir.current_is_dir():
			#data.append(dir_name)
			#print(data)
	#dir.list_dir_end()
	#Json()
	#
	#Doc_Dir.open(Doc)
	#if Doc_Dir.file_exists("GtFile"):
		#pass
	#else :
		#Doc_Dir.make_dir_recursive("GtFile")
#
#func Search_backpack():
	#var dir = DirAccess.new()
	#dir.open(res + data[3] + "/" + "Block")
	#dir.list_dir_begin() # TODOConverter3To4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	#while true :
		#var item_name = dir.get_next()
		#if item_name == "" :
			#break
		#elif not item_name.begins_with(".") and item_name.ends_with(".png"):
			#item_name.erase(item_name.length()-4,10)#-10,10
			#Block_list.append(item_name)
			##print(Block_list)
	#dir.list_dir_end()
#
#func Json():
	#var file = File.new()
	#file.open(str(res) + str(data[3]) + "/" + "Data_block.json",File.READ)
	#var dt_json = file.get_as_text()
	#var test_json_conv = JSON.new()
	#test_json_conv.parse(dt_json)
	#Block_json = test_json_conv.get_data()
	#file.close()
	#
	##print(Block_json)
