extends Node2D

@export var final_battle_timeline : DialogicTimeline
@export var inventory : Control
@export var tips : Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is PlayerController:
		(body as PlayerController).velocity = Vector2.ZERO
		(body as PlayerController).is_auto_controlled = true
		(body as PlayerController).walk_sound.queue_free()
		inventory.hide()
		tips.hide()
		Dialogic.start_timeline(final_battle_timeline)
