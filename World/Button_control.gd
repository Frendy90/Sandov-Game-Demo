extends Control

var Button_world = preload("res://Button/world_button.tscn")

var name_world
var Scene = PackedScene.new()
var Name : String

func _ready() -> void:
	Load_world()

func Load_world():
	for i in DirAccess.get_directories_at(GlobalVar.Doc + "/" + "Eb World"):
		var Button_world_instantie = Button_world.instantiate()
		Button_world_instantie.World_name = str(i)
		$GridContainer.add_child(Button_world_instantie)

func _on_Load_Button_pressed():
	Open_world()
	
func Open_world():
	if Name :
		Scene = ResourceLoader.load(GlobalVar.Doc + "/" + "Eb World" + "/" + Name + "/" + "World" + ".tscn")
		#for Block in data.Nodes :
			#var blokes = Block.instantiate()
			
		if Scene :
			get_tree().change_scene_to_packed(Scene)
		else :
			GlobalVar.name_wolrd = Name
			get_tree().change_scene_to_file("res://World/Game.tscn")
	else :
		pass

func _on_LineEdit_text_entered(new_text):
	if new_text :
		Name = str(new_text)
