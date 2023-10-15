extends CharacterBody3D


func _physics_process(delta):
	
	velocity = transform.basis * Vector3(0,0,-10)
	
	move_and_collide(self.velocity*delta)
