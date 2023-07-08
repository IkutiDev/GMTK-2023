extends Node2D
class_name Interactable

@export var timeline : DialogicTimeline
@export var visual : Sprite2D
@export var outline_thickness : float

func run_timeline() -> void:
	if timeline == null:
		return
	Dialogic.start_timeline(timeline)
	Dialogic.timeline_ended.connect(clear_timeline)

func clear_timeline() -> void:
	if timeline == null:
		return
	Dialogic.clear()
	Dialogic.timeline_ended.disconnect(clear_timeline)


func on_player_enter():
	enable_outline(true)


func on_player_exit():
	enable_outline(false)
	
func enable_outline(enable : bool) -> void:
	if enable == false:
		print(name)
	
	if visual == null:
		return
	if visual.material == null:
		return
	if timeline == null:
		return
	visual.material.set_shader_parameter("line_thickness", outline_thickness if enable else 0)
