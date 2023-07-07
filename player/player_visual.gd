extends AnimatedSprite2D

@export var player_controller : PlayerController

var is_front := true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not player_controller.velocity.x == 0:
		if player_controller.velocity.x > 0:
			flip_h = true
		else:
			flip_h = false
	if not player_controller.velocity.y == 0:
		if player_controller.velocity.y > 0:
			is_front = true
		else:
			is_front = false
			
	if player_controller.velocity == Vector2.ZERO:
		play_animation("idle")
	else:
		play_animation("walk")

func play_animation(animation_name : String) -> void:
	var direction_name = "front" if is_front else "back"
	play(animation_name + "_" + direction_name)
