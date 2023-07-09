extends Interactable
class_name Doors

const PLAYER_GROUP_NAME = "Player"

@export var exit_point : Node2D
@export var exit_at_timeline_end : bool

@export var door_open : bool

func can_use_doors():
	door_open = true

func run_timeline() -> void:
	if door_open == false:
		super.run_timeline()
		return
		
	teleport_player()
	
func clear_timeline() -> void:
	super()
	if exit_at_timeline_end:
		teleport_player()
	
func teleport_player() -> void:
	for n in get_tree().get_nodes_in_group(PLAYER_GROUP_NAME):
		(n as Node2D).global_position = exit_point.global_position
		
func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	
	return true
