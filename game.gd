extends Node2D
class_name Game

@export var options : CanvasLayer
@export var player_controller : PlayerController

var showing_options : bool

static var is_passed_exam_steps : bool

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
		options.show_menu(self)
		showing_options = true
		player_controller.set_in_menu(true)
	else:
		if options.try_hide():
			showing_options = false
			player_controller.set_in_menu(false)
		
func receive_close_options():
	showing_options = false

func recieve_event_signal(argument:String) -> void:
	print("[Dialogic] Encountered a signal event: ", argument)
	
func recieve_text_signal(argument:String) -> void:
	print("[Dialogic] Encountered a signal in text: ", argument)


func _on_button_pressed() -> void:
	GameManager.WinGame()


func _on_button_2_pressed() -> void:
	GameManager.LoseGame()
	
static func PlayStealth():
	Game.is_passed_exam_steps = true
	AudioController.controller.play_stealth()
	
func play_normal_music() -> void:
	AudioController.controller.play_normal_music()
