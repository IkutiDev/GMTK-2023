extends HSlider

@export var bus_name: String
@export var initial_value : float

var bus_index: int

# Called when the node enters the scene tree for the first time.
func _ready():
	bus_index = AudioServer.get_bus_index(bus_name)
	
	if(initial_value != 0):
		AudioServer.set_bus_volume_db(bus_index, linear_to_db(initial_value))
	
	value_changed.connect(_on_value_changed)
	
	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
