extends Node
class_name PlayerInventory

static var in_hand : ItemData
static var texture_changed : bool

@export var inventory_view : InventoryView
@export var empty_item : ItemData

static func set_in_hand(item_data : ItemData) -> void:
	in_hand = item_data
	texture_changed = true
	
static func has_item_in_hand()  -> bool:
	return in_hand != null
	
func _process(time : float) -> void:
	if not PlayerInventory.texture_changed:
		return
	
	if PlayerInventory.in_hand == null:
		inventory_view.slot.texture.set_texture(empty_item.texture)
	else:
		inventory_view.slot.texture.set_texture(PlayerInventory.in_hand.texture)
	PlayerInventory.texture_changed = false
