extends Node2D
class_name TimelineController

static var controller : TimelineController

@export var initial_timeline : DialogicTimeline
@export var finished_exam_timeline : DialogicTimeline
@export var win_act_one : DialogicTimeline
@export var normal_music : AudioStreamPlayer
@export var intro_music : AudioStreamPlayer

func _ready():
	TimelineController.controller = self
	play_init_timeline()

func play_init_timeline():
	Dialogic.start_timeline(initial_timeline)
	Dialogic.timeline_ended.connect(clear_timeline)
	
func play_exam_timeline():
	Dialogic.start_timeline(finished_exam_timeline)
	Dialogic.timeline_ended.connect(clear_timeline)
	
func play_win_act_one_timeline():
	Dialogic.start_timeline(win_act_one)
	Dialogic.timeline_ended.connect(clear_timeline)

func clear_timeline() -> void:
	Dialogic.clear(Dialogic.ClearFlags.KeepVariables)
	Dialogic.timeline_ended.disconnect(clear_timeline)
	
func play_normal_music() -> void:
	normal_music.play()
	
func play_intro_music() -> void:
	intro_music.play()
	
func stop_intro_music() -> void:
	intro_music.stop()
