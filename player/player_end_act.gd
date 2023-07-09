extends Node2D

@export var walk_cycle_time := 1.0
@export_category("References")
@export var path_follow : PathFollow2D
@export var player : PlayerController

var previous_parent

var move : bool

func start_moving():
	move = true
	previous_parent = player.get_parent()
	player.get_parent().remove_child(player)
	player.position = Vector2(0, 0)
	path_follow.add_child(player)

func _physics_process(delta: float) -> void:
	if move == false:
		return
	
	path_follow.progress_ratio += (1/walk_cycle_time) * delta
	
	if path_follow.progress_ratio >= 1:
		player.restore_player_control()
		var gp = player.global_position
		path_follow.remove_child(player)
		previous_parent.add_child(player)
		player.global_position = gp
		TimelineController.controller.play_win_act_one_timeline()
		move = false


