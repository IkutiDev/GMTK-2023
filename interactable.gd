extends Control
class_name Interactable

@export var timeline : DialogicTimeline
@export var shader_material : Sprite2D
@export var outline_thickness : float

var shader_param
var has_shader : bool

func _ready():
	if shader_material == null:
		has_shader = false
		return
	
	has_shader = true
	shader_param = shader_material.material.get_shader_parameter("line_thickness")

func run_timeline() -> void:
	Dialogic.start_timeline(timeline)
	Dialogic.timeline_ended.connect(clear_timeline)

func clear_timeline() -> void:
	Dialogic.clear()
	Dialogic.timeline_ended.disconnect(clear_timeline)


func on_player_enter():
	if has_shader == false:
		return
	
	shader_material.material.set_shader_parameter("line_thickness", outline_thickness)


func on_player_exit():
	if has_shader == false:
		return
	
	shader_material.material.set_shader_parameter("line_thickness", 0)
	
