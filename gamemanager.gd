extends Node

@export var main_menu : PackedScene
@export var win_screen : PackedScene
@export var lose_screen : PackedScene

var lose_screen_instance
var win_scren_instance

func WinGame() -> void:
	get_tree().paused = true
	win_scren_instance = win_screen.instantiate()
	
	get_tree().root.add_child(win_scren_instance)

func LoseGame() -> void:
	get_tree().paused = true
		
	lose_screen_instance = lose_screen.instantiate()
	
	get_tree().root.add_child(lose_screen_instance)

func return_to_main_menu() -> void:
	if Dialogic.current_timeline != null:
		return
	Dialogic.VAR.clear_game_state(Dialogic.ClearFlags.FullClear)
	get_tree().paused = false
	if lose_screen_instance != null:
		lose_screen_instance.queue_free()
	if win_scren_instance != null:
		win_scren_instance.queue_free()
	get_tree().change_scene_to_packed(main_menu)
