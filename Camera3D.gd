extends Camera3D


# Called when the node enters the scene tree for the first time.
func _ready():
	var crosshair = $"Crosshair"
	crosshair.position.x = get_viewport().size.x / 2
	crosshair.position.y = get_viewport().size.y / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
