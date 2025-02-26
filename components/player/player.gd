extends CharacterBody2D

@onready var animated_sprite : AnimatedSprite2D = $AnimatedPlayerSprite2D

signal player_died

var ANIMATION_STATES = {
	"IDLE": "idle",
	"MOVE": "move",
	"FIRE": "fire",
	"DEATH": "die"
}

var current_animation = ANIMATION_STATES.IDLE

const speed : float = 150
var health : float = 100:
	set(value):
		health = value
		%Health.value = value
		if (health <= 0):
			die();

var nearest_enemy : CharacterBody2D
var nearest_enemy_distance : float = INF
var is_dead : bool = false;

func _ready() -> void:
	animated_sprite.play(current_animation)

func _physics_process(delta: float) -> void:
	if (is_dead):
		return
	
	if is_instance_valid(nearest_enemy):
		nearest_enemy_distance = nearest_enemy.separation
		print(nearest_enemy.name)
	else:
		nearest_enemy_distance = INF
	
	velocity = Input.get_vector("left", "right", "up", "down") * speed
	move_and_collide(velocity * delta)
	
	if velocity.length() > 0.0:
		current_animation = ANIMATION_STATES.MOVE
		animated_sprite.play(ANIMATION_STATES.MOVE)
	else:
		current_animation = ANIMATION_STATES.IDLE
		animated_sprite.play(ANIMATION_STATES.IDLE)
	
	if velocity.x > 0: 
		animated_sprite.flip_h = false 

	elif velocity.x < 0:
		animated_sprite.flip_h = true

func take_damage(amount):
	if (amount <= 0 or is_dead):
		return;
		
	health -= amount
	print(amount)

func die():
	is_dead = true;
	animated_sprite.play(ANIMATION_STATES.DEATH)
	set_physics_process(false);
	emit_signal("player_died")
	queue_free()

func _on_self_damage_body_entered(body: Node2D) -> void:
	take_damage(body.damage)

func _on_timer_timeout() -> void:
	%Collision.set_deferred("disabled", true)
	%Collision.set_deferred("disabled", false)
