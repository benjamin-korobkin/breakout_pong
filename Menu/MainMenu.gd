extends Control


func _ready() -> void:
	$VBoxContainer2/VBoxContainer/MarginContainer/StartButton.grab_focus()


func _on_StartButton_pressed() -> void:
	get_tree().change_scene("res://Level/Level_1.tscn")

func _on_CreditsButton_pressed() -> void:
	var credits = load("res://Menu/CreditsMenu.tscn").instance()
	get_tree().current_scene.add_child(credits)

func _on_QuitButton_pressed() -> void:
	get_tree().quit()
