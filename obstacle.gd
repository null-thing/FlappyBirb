extends Area2D
var spawn_location
var obstacle_type
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_body_entered(body):
	body.velocity.x = 0
	body.get_node("CollisionShape2D").set_deferred("disabled", true)
	body.hit_func()
	if obstacle_type == 9 :
		body.end_func()

func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()

