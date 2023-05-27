extends Timer

var player
var player_speed
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_speed = player.velocity.x
	time = 2 - 0.002 * (player_speed - 100)
	if time < 0.7:
		time = 0.7
	wait_time = time
