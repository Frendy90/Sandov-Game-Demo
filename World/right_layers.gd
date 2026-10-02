extends Control

func _process(delta: float) -> void:
	$VBoxContainer/HBoxContainer/Label.text = str(GlobalVar.Gems)
