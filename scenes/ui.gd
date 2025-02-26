extends CanvasLayer

@onready var score_label : Label = $VBoxContainer/ScoreLabel  
@onready var return_button: Button = $GameOverPanel/VBoxPanel/ReturnButton
@onready var game_over_panel : Panel = $GameOverPanel
@onready var score_display: Label = $GameOverPanel/VBoxPanel/ScoreDisplay
@onready var time_display: Label = $GameOverPanel/VBoxPanel/TimeDisplay

func update_score_label(score):
	if score_label:  
		score_label.text = "Score: " + str(score)  
	else:
		printerr("ERROR: Cannot update ScoreLabel because it is null.")
	
func _ready() -> void:
	game_over_panel.visible = false
	return_button.pressed.connect(on_return_button_pressed)

func _on_spawner_score_changed(score):
	update_score_label(score) 

func on_return_button_pressed():
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn") 
	
func show_game_over(score: int, time_str: String):
	score_display.text = "Score: " + str(score)
	time_display.text = "Time: " + time_str

	game_over_panel.visible = true 
	return_button.grab_focus()
