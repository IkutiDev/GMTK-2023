extends Interactable
class_name ItemInteractable

@export var item_data : ItemData
@export var item_texture : TextureRect

func _ready():
	item_texture.set_texture(item_data.texture)
