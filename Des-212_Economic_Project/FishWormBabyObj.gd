extends CharacterBody2D
signal Jump

const SPEED = 300.0
const JUMP_VELOCITY = -1900.0
var rotation_speed = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	connect("Jump", go)

func _physics_process(delta):
	# Add the gravity.
	if position.y < 1056:
		velocity.y += gravity * delta * 2
	
	if (position.y > 1200):
		velocity.y = 0
		position.y -= 100
	
	rotation_speed *= 0.93
	rotate(rotation_speed * delta)
	move_and_slide()

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_node("Sprite2D").get_rect().has_point(to_local(event.position)):
			get_node("WormExplosion").emitting = true
			print(get_node("WormExplosion").position)
			position.y += 10000

func go():
	print("Wtf")
	rotation_speed = 80
	velocity.y = JUMP_VELOCITY
	print(velocity.y)
