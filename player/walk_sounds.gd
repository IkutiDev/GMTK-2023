extends AudioStreamPlayer
class_name WalkSounds

@export var sound_list : Array[AudioStream]
@export var sound_must_finish := true
@export var repeat_time : float

var sound_timer : float
var sound_index := 0
var is_walking : bool

func _ready():
	randomize()
	sound_timer = 0

func play_walk(play : bool):
	is_walking = play

func _process(delta):
	if is_walking == false:
		sound_timer = 0
		return
	
	sound_timer -= delta
	
	if sound_timer <= 0:
		#pitch_scale = randf_range(min_pitch, max_pitch)
		# Randomly pick a sound that is not the one we just played.
		sound_index += floor(randf_range(0, sound_list.size() - 1))
		sound_index %= sound_list.size()
		stream = sound_list[sound_index]
		play()
		sound_timer = repeat_time
