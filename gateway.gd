extends Interactable

const PLAYER_GROUP_NAME = "Player"

@export var exit_point : Node2D

func run_timeline() -> void:
	
	if timeline == null:
		teleport_player()
		return
	super()
	
	
	
func teleport_player() -> void:
	for n in get_tree().get_nodes_in_group(PLAYER_GROUP_NAME):
		(n as Node2D).global_position = exit_point.global_position
		
func can_enable_outline() -> bool:
	if visual == null:
		return false
	if visual.material == null:
		return false
	
	return true
