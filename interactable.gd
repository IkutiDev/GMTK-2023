extends Node2D
class_name Interactable

@export var timeline : DialogicTimeline
@export var visual : Sprite2D
@export var outline_thickness : float = 1.7
@export var is_trash_can : bool

var is_in_focus
var is_player_interacting : bool

func run_timeline() -> void:
	if timeline == null:
		return
	Dialogic.start_timeline(timeline)
	Dialogic.timeline_ended.connect(clear_timeline)
	
func clear_object():
	queue_free()

func clear_timeline() -> void:
	if timeline == null:
		return
	Dialogic.clear(Dialogic.ClearFlags.KeepVariables)
	Dialogic.timeline_ended.disconnect(clear_timeline)
	
	if Dialogic.VAR.FinishedExamAll == 1:
		return
	if Dialogic.VAR.BlackboardAct == 0:
		return
	if Dialogic.VAR.CompAct == 0:
		return
	if Dialogic.VAR.DoorAct == 0:
		return
	if Dialogic.VAR.NoticeAct == 0:
		return
	if Dialogic.VAR.TrashAct == 0:
		return
	if Dialogic.VAR.CuteGirlAct == 0:
		return
	
	Dialogic.VAR.FinishedExamAll = 1
	TimelineController.controller.play_exam_timeline()
	
func _input(event):
	if Game.is_passed_exam_steps == false:
		return
	
	if is_player_interacting == false:
		return
		
	if Input.is_action_just_pressed("pick_up"):
		Dialogic.VAR.IsPickupAction = 1
		run_timeline()
		
func player_interacting(inter : bool):
	is_player_interacting = inter


func on_player_enter():
	enable_outline(true)
	is_in_focus = true


func on_player_exit():
	enable_outline(false)
	is_in_focus = false
	
func enable_outline(enable : bool) -> void:
	if not can_enable_outline():
		return
	
	if visual != null:
		visual.material.set_shader_parameter("line_thickness", outline_thickness if enable else 0)

func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	if timeline == null:
		return false
		
	return true
