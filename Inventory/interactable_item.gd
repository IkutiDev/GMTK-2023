extends Interactable
class_name ItemInteractable

@export var item_data : ItemData

func _ready() -> void:
	visual.set_texture(item_data.texture)
