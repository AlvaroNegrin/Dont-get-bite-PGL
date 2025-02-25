extends PanelContainer

@export var weapon : Weapon:
	set(value):
		weapon = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		
		
func _on_cooldown_timeout() -> void:
	print("La bala es: ", weapon)
	if weapon:
		$Cooldown.wait_time = weapon.cooldown
		print("timer weapon")
		weapon.activate(owner, owner.nearest_enemy, get_tree())
