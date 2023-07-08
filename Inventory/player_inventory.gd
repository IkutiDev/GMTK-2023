extends Control
class_name PlayerInventory

const PLAYER_GROUP_NAME = "Player"

@export var items_container : Node2D
@export var inventory_view : InventoryView


func _ready() -> void:
	Events.picked_up_item.connect(add_item_to_invetory)
	Events.drop_item.connect(drop_item_from_invetory)

func add_item_to_invetory(item_data : ItemData) -> void:
	Dialogic.VAR.set_variable(item_data.dialogic_variable_name, 1)
	inventory_view.spawn_item_icon(item_data)

func drop_item_from_invetory(item_data : ItemData) -> void:
	var item = load(item_data.item_pickable_packed_scene_path)
	var item_instance = item.instantiate() as Node2D
	items_container.add_child(item_instance)
	item_instance.global_position = (get_tree().get_nodes_in_group(PLAYER_GROUP_NAME)[0] as Node2D).global_position
	Dialogic.VAR.set_variable(item_data.dialogic_variable_name, 0)
