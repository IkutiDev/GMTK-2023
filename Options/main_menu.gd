extends CanvasLayer

var is_showing : bool
	
func show_menu():
	if is_showing:
		return
	
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
	print ("Test 2")
	hide()


func _on_quit_button_pressed():
	get_tree().quit()
