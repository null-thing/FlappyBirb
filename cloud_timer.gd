extends Timer

var player
var player_speed
var time

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../player")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	player_speed = player.velocity.x
	if player_speed < 100 :
		time = 1
	else :
		time = 1 - 0.1 * (player_speed / 100)
	if time < 0.5:
		time = 0.5
	wait_time = randf_range(0.1, 5) * time
