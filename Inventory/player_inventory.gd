extends Control
class_name PlayerInventory

const PLAYER_GROUP_NAME = "Player"

@export var items_container : Node2D
@export var inventory_view : InventoryView
@export var player_controller : PlayerController

@export var letter : ItemData

func _ready() -> void:
	Events.picked_up_item.connect(add_item_to_invetory)
	

func add_item_to_invetory(item_data : ItemData) -> void:
	Dialogic.VAR.set_variable(item_data.dialogic_variable_name, 1)
	inventory_view.spawn_item_icon(item_data)

func drop_item_from_invetory(item_data : ItemData) -> void:
	var item = load(item_data.item_pickable_packed_scene_path)
	var item_instance = item.instantiate() as Node2D
	items_container.add_child(item_instance)
	item_instance.global_position = (get_tree().get_nodes_in_group(PLAYER_GROUP_NAME)[0] as Node2D).global_position
	Dialogic.VAR.set_variable(item_data.dialogic_variable_name, 0)

func _input(event):
	if Input.is_action_just_pressed("put_down_item"):
		
		var slot : SlotView = null
		
		if not player_controller.current_interactable is ItemContainer:
			return

		for s in inventory_view.get_items():
			if (player_controller.current_interactable as ItemContainer).item_to_store == s.item_data:
				slot = s
				break

		if slot == null:
			return
		
		if Dialogic.VAR.TrashAct == 1:
			Dialogic.VAR.IsTrashPutAction = 1
			player_controller.current_interactable.run_timeline()
			slot.item_data.pickup_item.queue_free()
			slot.clear_object()
			return
			
		Events.drop_item.emit(slot.item_data)
		slot.item_data.pickup_item.drop_item()
		slot.clear_object()


func drop_letter() -> void:
	var slot : SlotView = null
	
	for s in inventory_view.get_items():
		if letter == s.item_data:
			slot = s
			break
	if slot == null:
		return
	slot.clear_object()
