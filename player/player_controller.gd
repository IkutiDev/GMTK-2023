class_name PlayerController
extends CharacterBody2D

@export var walking_speed := 150.0
@export var walk_sound : WalkSounds

var current_interactable : Interactable = null
var current_item_interactable : ItemInteractable = null
var is_in_menu : bool

func _input(event: InputEvent) -> void:
	if Dialogic.current_timeline != null:
		return
	
	if is_in_menu:
		return
		
	var interact = false
	if Input.is_action_just_pressed("interact"):
		interact = true
		
	if current_interactable != null:
		if interact:
			current_interactable.run_timeline()
			return
		
	if interact and PlayerInventory.has_item_in_hand():
		PlayerInventory.set_in_hand(null)
		current_item_interactable.show()
		Dialogic.VAR.TargetOneGroup.HasTargetOneItem = 0
		
	elif interact and current_item_interactable != null:
		current_item_interactable.run_timeline()
		
		PlayerInventory.set_in_hand(current_item_interactable.item_data)
		Dialogic.VAR.TargetOneGroup.HasTargetOneItem = 1
		current_item_interactable.hide()

func _physics_process(delta: float) -> void:
	
	if Dialogic.current_timeline != null:
		return
	
	if is_in_menu:
		return

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction:
		velocity = direction * walking_speed
		walk_sound.play_walk(true)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, walking_speed)
		walk_sound.play_walk(false)
		
	if PlayerInventory.has_item_in_hand():
		current_item_interactable.set_position(position)

	move_and_slide()
	
func set_in_menu(in_menu: bool):
	is_in_menu = in_menu


func _on_area_2d_area_shape_entered(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var interactable : Interactable = area.get_parent() as Interactable
	interactable.on_player_enter()
	
	if interactable != null and current_interactable != null and interactable != current_interactable:
		current_interactable.enable_outline(false)
	
	if interactable is ItemInteractable:
		current_item_interactable = interactable
	else:
		current_interactable = interactable


func _on_area_2d_area_shape_exited(area_rid: RID, area: Area2D, area_shape_index: int, local_shape_index: int) -> void:
	var interactable : Interactable = area.get_parent()
	interactable.on_player_exit()
	
	if interactable is ItemInteractable:
		current_item_interactable = null
	else:
		current_interactable = null
		
	for close_area in $Area2D.get_overlapping_areas():
		if close_area.get_parent() as Interactable != null:
			_on_area_2d_area_shape_entered(RID(), close_area, 0, 0)
			return
