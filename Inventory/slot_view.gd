extends Control
class_name SlotView

@export var item_data : ItemData
@export var texture : TextureRect


func _on_drop_button_pressed() -> void:
	Events.drop_item.emit(item_data)
	queue_free()
	
func clear_object():
	queue_free()
