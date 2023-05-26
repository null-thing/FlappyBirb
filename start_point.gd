extends Marker2D


# Called when the node enters the scene tree for the first time.
func _ready():
	position = Vector2(get_viewport_rect().size.x*0.3, get_viewport_rect().size.y*0.5)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
