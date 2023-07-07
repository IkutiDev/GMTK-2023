class_name PlayerController
extends CharacterBody2D


const SPEED = 300.0

var current_interactable : Interactable = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and current_interactable != null:
		print("interact")
		current_interactable.run_timeline()

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)

	move_and_slide()


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var interactable : Interactable = area.get_parent()
	
	current_interactable = interactable
	
	print(current_interactable)
	


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	current_interactable = null
