extends Control

var Value

func _process(delta):
	$VBoxContainer/Label.text = "Block in world : "+ str(get_tree().get_root().get_node("Game/Tile").get_child_count()) + "\nFloating Item : " + str(get_tree().get_root().get_node("Game/Item").get_child_count()) + "\nPlayer Position : " + str(get_tree().get_root().get_node("Game/Player").global_position) + "\nFPS : " + str(Engine.get_frames_per_second())
	get_tree().get_root().get_node("Game/Player/Camera2D").zoom = Vector2($VBoxContainer/SpinBox.value,$VBoxContainer/SpinBox.value)
	
func _on_SpinBox_drag_started():
	Value = $VBoxContainer/SpinBox.value


func _on_Test_button_pressed():
	for i in get_tree().get_root().get_node("Game/Tile").get_children():
		if i.name_block != "Bedrock" :
			get_tree().get_root().get_node("Game/Tile/" + str(i)).queue_free()


func _on_test_button_2_pressed() -> void:
	get_tree().get_root().get_node("Game").player_pos_world = get_tree().get_root().get_node("Game/Player").global_position

func _on_test_button_3_pressed() -> void:
	get_tree().get_root().get_node("Game").SV()
