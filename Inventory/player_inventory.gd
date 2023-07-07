extends Node
class_name PlayerInventory

static var in_hand : ItemData
static var texture_changed : bool

@export var inventory_view : InventoryView

static func set_in_hand(item_data : ItemData) -> void:
	in_hand = item_data
	texture_changed = true
	print("setting sprite")
	
func _process(time : float) -> void:
	if not PlayerInventory.texture_changed:
		return
	inventory_view.slot.texture.set_texture(PlayerInventory.in_hand.texture)
	PlayerInventory.texture_changed = false
	print("Sprite Set")
