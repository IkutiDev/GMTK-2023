extends Interactable
class_name PickupItem

const PLAYER_GROUP_NAME = "Player"

@export var item_data : ItemData
@export var pickup_item_at_timeline_end : bool
@export var collider1 : CollisionShape2D
@export var collider2 : CollisionPolygon2D

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
		item_data.pickup_item = self
		Events.picked_up_item.emit(item_data)
		Dialogic.VAR.IsPickupAction = 0
		if collider1 != null:
			collider1.disabled = true
		if collider2 != null:
			collider2.disabled = true
		hide()
		
func drop_item():
	global_position = (get_tree().get_nodes_in_group(PLAYER_GROUP_NAME)[0] as Node2D).global_position
	collider1.disabled = false
	collider2.disabled = false
	show()
		
func _input(event):
	if Game.is_passed_exam_steps == false:
		return
	
	if is_player_interacting == false:
		return
		
	if Input.is_action_just_pressed("pick_up"):
		Dialogic.VAR.IsPickupAction = 1
		run_timeline()
	
	
func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	
	return true
