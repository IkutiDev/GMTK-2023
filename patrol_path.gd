extends Path2D


@export var walk_cycle_time := 1.0
@export var wait_time := 0.0
@export_category("References")
@export var animated_sprite : AnimatedSprite2D
@export var path_follow : PathFollow2D

var reverse : bool
var waiting : bool
var waiting_counter : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	
	if waiting:
		waiting_counter -= delta
		if waiting_counter > 0:
			return
		else:
			waiting = false
			reverse = not reverse
			animated_sprite.flip_h = not reverse
	
	if reverse:
		path_follow.progress_ratio -= (1/walk_cycle_time) * delta
		animated_sprite.play("walk_back")
		if path_follow.progress_ratio <= 0:
			waiting_counter = wait_time
			waiting = true
			animated_sprite.play("idle_back")
	else:
		path_follow.progress_ratio += (1/walk_cycle_time) * delta
		animated_sprite.play("walk_front")
		if path_follow.progress_ratio >= 1:
			waiting_counter = wait_time
			waiting = true
			animated_sprite.play("idle_front")





func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		GameManager.LoseGame()
