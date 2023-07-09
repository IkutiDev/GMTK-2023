extends Interactable
class_name PickupItem

@export var item_data : ItemData
@export var pickup_item_at_timeline_end : bool

func _ready() -> void:
	if visual != null:
		visual.texture = item_data.texture

func run_timeline() -> void:
	
	if timeline == null:
		return
	super()
	
func clear_timeline() -> void:
	super()
	if Dialogic.VAR.IsPickupAction == 1:
		Dialogic.VAR.IsPickupAction = 0
		queue_free()
		
func _input(event):
	if Game.is_passed_exam_steps == false:
		return
	
	if is_player_interacting == false:
		return
		
	if Input.is_action_just_pressed("pick_up"):
		Events.picked_up_item.emit(item_data)
		Dialogic.VAR.IsPickupAction = 1
		run_timeline()
	
	
func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	
	return true
