extends Node
class_name AudioController

@export var main_music : AudioStreamPlayer
@export var stealth_intro : AudioStreamPlayer
@export var stealth_loop : AudioStreamPlayer
@export var fade_time : float
@export var steal_intro_time : float

var fade_counter : float
var change_to_stealth : int

static var controller : AudioController

func _ready():
	AudioController.controller = self
	fade_counter = fade_time

func play_stealth():
	change_to_stealth = 1
	
func _physics_process(delta):
	if change_to_stealth == 3:
		if stealth_intro.playing:
			print("test")
			stealth_loop.play()
			change_to_stealth = 0
		return
	
	if change_to_stealth > 0:
		go_to_stealth(delta)
		return

func go_to_stealth(delta):
	fade_counter -= delta
	
	if change_to_stealth == 2:
		if fade_counter < 0:
			change_to_stealth += 1
		return
		
	
	if fade_counter < 0:
		change_to_stealth += 1
		fade_counter = steal_intro_time
		main_music.volume_db = linear_to_db(0)
		main_music.stop()
		stealth_intro.play(0)
	
	if change_to_stealth == 1:
		main_music.volume_db = linear_to_db(fade_counter)
		
	
	
