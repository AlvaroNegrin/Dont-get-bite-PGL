extends Node2D

@export var player : CharacterBody2D
@export var mob : PackedScene

signal score_changed(score) 

var distance : float = 400
var can_spawn : bool = true

@export var mob_types : Array[Mob]

var minute : int:
	set(value):
		minute = value
		%Minute.text = str(value)

var second : int:
	set(value):
		second = value
		if second >= 60:
			second -= 60
			minute += 1
		%Second.text = str(second).lpad(2, '0')

var score : int = 0 :
	set(value):
		score = value
		emit_signal("score_changed", score)  

func _physics_process(_delta: float) -> void:
	if get_tree().get_node_count_in_group("Mob") < 700:
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos : Vector2, elite : bool = false):
	if not can_spawn and not elite:
		return
	
	var mob_instance = mob.instantiate()
	
	mob_instance.type = mob_types[min(minute, mob_types.size() - 1)]
	mob_instance.position = pos
	if is_instance_valid(player):
		mob_instance.player_reference = player 
	mob_instance.elite = elite
	
	get_tree().current_scene.add_child(mob_instance)

func get_ramdon_position() -> Vector2:
	if is_instance_valid(player):
		return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	else:
		return Vector2(10000, 10000)

func amount(number : int = 1):
	for i in range(number):
		spawn(get_ramdon_position())


func _on_timer_timeout() -> void:
	second += 1
	amount(second % 5)

func _on_pattern_timeout() -> void:
	for i in range(38):
		spawn(get_ramdon_position())


func _on_elite_timeout() -> void:
	spawn(get_ramdon_position(), true)
