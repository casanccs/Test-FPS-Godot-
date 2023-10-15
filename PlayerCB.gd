extends CharacterBody3D

@export var SPEED = 5

@onready var camera = $"Camera3D"
@onready var bullet = get_parent().get_node("Bullet")

var tilt = 0 # radians, from -pi/2 to pi/2


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _input(event):
	if event is InputEventMouseMotion:
		rotate(Vector3.UP, -event.relative.x*0.003)
		if -PI*180 < (tilt - event.relative.y) and (tilt - event.relative.y) < PI*180:
			camera.rotate_object_local(Vector3.RIGHT, -event.relative.y*0.003)
			tilt -= event.relative.y
	if event is InputEventMouseButton:
		if event.pressed:
			var bulletclone = bullet.duplicate()
			bulletclone.position = camera.global_position
			bulletclone.transform.basis = camera.global_transform.basis
			get_parent().add_child(bulletclone)
	
func _physics_process(delta):
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward") # This is a normalized Vector2D!
	var direction = (transform.basis * Vector3(input_dir.x, 0 , input_dir.y)).normalized()
	velocity.x = direction.x * SPEED
	velocity.z = direction.z * SPEED
	
	if not is_on_floor():
		velocity.y -= 10 * delta
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = 8
	move_and_slide()
