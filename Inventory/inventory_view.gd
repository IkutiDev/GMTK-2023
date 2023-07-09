extends PanelContainer
class_name InventoryView

@export var grid : GridContainer
@export var slot : PackedScene


func spawn_item_icon(item_data : ItemData) -> void:
	var slot_instance = slot.instantiate()
	
	grid.add_child(slot_instance)
	
	(slot_instance as SlotView).texture.set_texture(item_data.texture)
	(slot_instance as SlotView).item_data = item_data


func get_items() -> Array[SlotView]:
	var slots : Array[SlotView]
	for child in grid.get_children():
		if child is SlotView:
			slots.append(child)
	
	return slots
