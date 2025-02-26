extends Node2D
@onready var music_player = $AudioStreamPlayer2D

@onready var spawner = $Spawner
@onready var ui = $UI
@onready var player = $Player
@onready var time = $Time

var total_time = 0

func _ready() -> void:
	#$DeathTimer.timeout.connect(_on_death_timer_timeout)
	player.player_died.connect(on_player_died)

	time.start()
	music_player.play()


func _process(delta: float) -> void:
	total_time += delta

func time_format(time):
	return str(int(time)) + "s"

func on_player_died():
	time.stop()
	player.z_index = 1
	ui.show_game_over(spawner.score, time_format(total_time))
	#$DeathTimer.start()

func _on_death_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
