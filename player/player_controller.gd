class_name PlayerController
extends CharacterBody2D

const SPEED = 300.0

var current_interactable : Interactable = null
var pressed_action : bool

func _input(event: InputEvent) -> void:
	if !pressed_action and event.is_action_pressed("interact") and PlayerInventory.has_item_in_hand():
		print("drop item")
		PlayerInventory.set_in_hand(null)
		current_interactable.show()
		
	elif !pressed_action and event.is_action_pressed("interact") and current_interactable != null:
		print("pick up item")
		current_interactable.run_timeline()
		PlayerInventory.set_in_hand(current_interactable.item_data)
		current_interactable.hide()
		
	if event.is_action_pressed("interact"):
		pressed_action = true
	else:
		pressed_action = false
		
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()

func _physics_process(delta: float) -> void:

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, SPEED)
		
	if PlayerInventory.has_item_in_hand():
		current_interactable.set_position(position)

	move_and_slide()


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var interactable : Interactable = area.get_parent()
	
	current_interactable = interactable
	
	print(current_interactable)
	


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	current_interactable = null
