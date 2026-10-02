extends TextureButton

var World_name : String
var Scene = PackedScene.new()

func _ready() -> void:
	$Label.text = World_name

func _pressed() -> void:
	Scene = ResourceLoader.load(GlobalVar.Doc + "/" + "Eb World" + "/" + World_name + "/" + "World" + ".tscn")
	if Scene :
		get_tree().change_scene_to_packed(Scene)
	else :
		queue_free()
