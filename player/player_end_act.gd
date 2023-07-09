class_name PlayerEnd
extends Node2D

@export var walk_cycle_time := 1.0
@export_category("References")
@export var path_follow : PathFollow2D
@export var player : PlayerController
@export var sprites_to_show : Array[Sprite2D]
@export var end_act_one : bool

var previous_parent

static var move : bool
var specific_move : bool

func start_moving():
	move = true
	specific_move = true
	previous_parent = player.get_parent()
	player.get_parent().remove_child(player)
	player.position = Vector2(0, 0)
	path_follow.add_child(player)

func _physics_process(delta: float) -> void:
	if move == false or specific_move == false:
		return
	
	path_follow.progress_ratio += (1/walk_cycle_time) * delta
	
	if path_follow.progress_ratio >= 1:
		player.restore_player_control()
		var gp = player.global_position
		path_follow.remove_child(player)
		if previous_parent != null:
			previous_parent.add_child(player)
		player.global_position = gp
		move = false
		specific_move = false
		
		if end_act_one:
			TimelineController.controller.play_win_act_one_timeline()
		
			for sprite in sprites_to_show:
				sprite.show()


