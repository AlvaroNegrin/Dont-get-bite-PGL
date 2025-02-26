extends Control

@onready var music_player = $AudioStreamPlayer2D


func _ready():
	menu()
	music_player.play()
	

func _on_mobs_pressed() -> void:
	mobs() 


func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/test_scene.tscn")


func menu():
	$Menu.show()
	$Mobs.hide()
	
func mobs():
	$Menu.hide()
	$Mobs.show()

func _on_back_pressed() -> void:
	menu()
