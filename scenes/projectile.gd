extends Area2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D


var direction : Vector2 = Vector2.RIGHT 
var speed : float = 200
var damage : float = 1

var current_animation = "shot"


func _ready() -> void:
	animated_sprite.play(current_animation)

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	rotation = direction.angle() 

func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		body.knockback = direction * 45

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
