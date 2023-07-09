extends CanvasLayer

var is_showing : bool
var game_scene
	
func show_menu(game : Game):
	if is_showing:
		return
	
	game_scene = game
	
	is_showing = true
	show()
	
func try_hide()-> bool :
	if is_showing == false:
		return false
	
	hide()
	is_showing = false
	return true

func _on_back_button_pressed():
	is_showing = false
	hide()
	game_scene.receive_close_options()


func _on_quit_button_pressed():
	GameManager.return_to_main_menu()
