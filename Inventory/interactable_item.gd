extends Interactable
class_name ItemInteractable

@export var item_data : ItemData
@export var visual : Sprite2D

func _ready() -> void:
	visual.set_texture(item_data.texture)
