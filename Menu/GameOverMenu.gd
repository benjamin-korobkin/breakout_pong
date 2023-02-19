extends Control


func _ready() -> void:
	pass


func _on_TryAgainButton_pressed() -> void:
	get_tree().change_scene("res://Level/Level.tscn")
