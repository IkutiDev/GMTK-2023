extends Node

@export var game_scene : PackedScene

func _on_start_game_button_button_down():
	get_tree().change_scene_to_packed(game_scene)
