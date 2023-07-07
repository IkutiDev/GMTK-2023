class_name Interactable
extends Sprite2D

@export var timeline : DialogicTimeline

func run_timeline() -> void:
	print(timeline)
	Dialogic.start_timeline(timeline)
	Dialogic.timeline_ended.connect(clear_timeline)

func clear_timeline() -> void:
	Dialogic.clear()
	Dialogic.timeline_ended.disconnect(clear_timeline)
