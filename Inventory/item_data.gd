extends Resource
class_name ItemData

@export var name: String = ""
@export var texture: Texture2D
@export var dialogic_variable_name : String = ""
@export var item_pickable_packed_scene_path : String = ""

var pickup_item : PickupItem
