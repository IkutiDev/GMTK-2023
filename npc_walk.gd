extends Node

@export var path_follow : PathFollow2D

var move = false

func start_walking() -> void:
	move = true


func _physics_process(delta: float) -> void:
	if not move:
		return
	
	path_follow.progress_ratio += 0.5 * delta

	if path_follow.progress_ratio >= 1:
		move = false
