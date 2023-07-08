extends Interactable
class_name PickupItem

@export var item_data : ItemData
@export var pickup_item_at_timeline_end : bool

var is_player_interacting : bool

func _ready() -> void:
	visual.texture = item_data.texture

func run_timeline() -> void:
	
	if timeline == null:
		return
	super()
	
func clear_timeline() -> void:
	super()
	
func player_interacting(inter : bool):
	is_player_interacting = inter
		
func _input(event):
	if is_player_interacting == false:
		return
	if Input.is_action_just_pressed("pick_up"):
		Events.picked_up_item.emit(item_data)
		queue_free()
	
	
func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	
	return true
