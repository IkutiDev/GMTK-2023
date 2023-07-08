extends Interactable

@export var item_data : ItemData
@export var pickup_item_at_timeline_end : bool

func _ready() -> void:
	visual.texture = item_data.texture

func run_timeline() -> void:
	
	if timeline == null:
		pickup_item()
		return
	super()
	
func clear_timeline() -> void:
	super()
	if pickup_item_at_timeline_end:
		pickup_item()
	
func pickup_item() -> void:
	Events.picked_up_item.emit(item_data)
	queue_free()
		
func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	
	return true
