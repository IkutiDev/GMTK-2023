extends Node2D
class_name Game

@export var options : CanvasLayer

var showing_options : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Game started!")
	var dialog_scene_path: String = ProjectSettings.get_setting(
		'dialogic/layout/layout_scene',
		DialogicUtil.get_default_layout()
	)
	
	var scene: Node = load(dialog_scene_path).instantiate()
	DialogicUtil.apply_scene_export_overrides(scene, ProjectSettings.get_setting('dialogic/layout/export_overrides', {}))
	add_child(scene)
	if not scene is CanvasLayer:
		if scene is Control:
			scene.position = get_viewport_rect().size/2.0
		if scene is Node2D:
			scene.position = get_viewport_rect().size/2.0
			
	randomize()
	
	Dialogic.signal_event.connect(recieve_event_signal)
	Dialogic.text_signal.connect(recieve_text_signal)
	
func _input(event):
	if Input.is_action_just_pressed("ui_cancel") == false:
		return
	
	if showing_options == false:
		print ("Test 1")
		options.show_menu()
		showing_options = true
	else:
		if options.try_hide():
			showing_options = false
		

func recieve_event_signal(argument:String) -> void:
	print("[Dialogic] Encountered a signal event: ", argument)
	
func recieve_text_signal(argument:String) -> void:
	print("[Dialogic] Encountered a signal in text: ", argument)
