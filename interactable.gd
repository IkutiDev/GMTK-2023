extends Control
class_name Interactable

@export var timeline : DialogicTimeline
@export var item_data : ItemData
@export var item_texture : TextureRect

func _ready():
	item_texture.set_texture(item_data.texture)

func run_timeline() -> void:
	print(timeline)
	Dialogic.start_timeline(timeline)
	Dialogic.timeline_ended.connect(clear_timeline)

func clear_timeline() -> void:
	Dialogic.clear()
	Dialogic.timeline_ended.disconnect(clear_timeline)
