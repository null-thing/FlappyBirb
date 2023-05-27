extends ParallaxBackground
var bg_sprite
var sun_timer
var col
var is_dawn = 0
var is_night = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	bg_sprite = get_node("39")
	sun_timer = get_node("../sun_timer")
	sun_timer.start()
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	col = bg_sprite.get_modulate()
	print(col)
	"if is_dawn:
		background_gradation(is_night, 0, 0)"
	
func background_gradation(is_night, col, delta):
	if is_night:
		if Color(col)==Color(0.8, 0.7, 0.7, 1):
			bg_sprite.set_modulate(Color(col).blend(Color(1,1,1,1)))
		else :
			bg_sprite.set_modulate(Color(col).blend(Color(0.8314,0.7333,0.7569,0.001)))
		
	else: 
		bg_sprite.set_modulate(col.blend(Color(0,0,0,0.001)))
	
	
	if Color(col) == Color(1,1,1,1):
		is_dawn = 0
		
func _on_sun_timer_timeout():
	sun_timer.stop()
	is_dawn = 1
	if is_night:
		is_night = 0
	else:
		is_night = 1
