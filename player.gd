extends CharacterBody2D

var SPEED = 100.0
const JUMP_VELOCITY = -400.0 *1.5
const GLIDE_VELOCITY = 100.0
const VELOCITY_INC = 1.01
var rotate_zeroupper = 0
var input_enabled = 0
var stop = 0
signal hit
signal end

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")*1.5

func start(pos):
	position = pos
	show()
	velocity.x = SPEED
	velocity.y = 0
	rotation = 0
	$CollisionShape2D.disabled = false
	
func _ready():
	hide()

func _physics_process(delta):
	if stop :
			velocity = Vector2(0,0)
			rotation = 0
			return	
	if !input_enabled:
		velocity.y += gravity * delta
		rotate(delta+ abs(0.02*rotation))
		if rotation>=1.5 :
			rotation = 1.5
		elif rotation<=-1.5 :
			rotation = -1.5
		move_and_slide()
		if position.y > get_viewport_rect().size.y+25:
			stop = 1
		return
	# Add the gravity.
	rotate_zeroupper = 0
	velocity.y += gravity * delta
	# Flap
	if Input.is_action_pressed("flap"):
		$AnimatedSprite2D.play("flap")
		if Input.is_action_just_pressed("flap"):
			velocity.x+=20
			velocity.y = JUMP_VELOCITY
			if rotation>0:
				rotate_zeroupper = rotation
			rotate(-45 * delta -  rotate_zeroupper )
	elif Input.is_action_pressed("glide"):
		velocity.x-=delta*100
		$AnimatedSprite2D.play("player_glide")
		if velocity.x < SPEED:
			velocity.x = SPEED
	else:
		$AnimatedSprite2D.play("player")
		
	rotate(delta+ abs(0.02*rotation))
	if rotation>=1.5 :
		rotation = 1.5
	elif rotation<=-1.5 :
		rotation = -1.5
		
	if Input.is_action_pressed("glide"):
		if rotation>=0.4:
			rotation = 0.4
		velocity.y = GLIDE_VELOCITY
	
	#velocity.x = direction * SPEED
	if velocity.x < 0:
		velocity.x = 0
	hit_the_floor()
	move_and_slide()
	

func hit_the_floor():
	if position.y > get_viewport_rect().size.y+25:
		hit.emit()

func hit_func():
	hit.emit()
	
func end_func():
	end.emit()
