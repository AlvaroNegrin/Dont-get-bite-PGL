extends Weapon
class_name SingleShot
 
func shoot(source, target, scene_tree):
	print("Nombre del objetivo ", target)
	if target == null:
		return
 
	var projectile = projectile_node.instantiate()
 
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.direction = (target.position - source.position).normalized()
 
	scene_tree.current_scene.add_child(projectile)
 
func activate(source, target, scene_tree):
	print("hola")
	shoot(source, target, scene_tree)
