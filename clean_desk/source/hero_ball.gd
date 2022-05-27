extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var _velocity = Vector2.ZERO
export var speed = Vector2(100.0, 80.0)
export var boost_speed = Vector2(1500.0, 800.0)
export var power_up = "none"
export var power_bol = false
export var flag_power_bol = false
onready var timer = get_node("Timer")



# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")


func _physics_process(delta):
	if Input.is_action_pressed("super"):
		power_bol = true
		flag_power_bol = true
		timer.start()
	if power_bol:
		power_function()
	else:
		var direction: = get_direction()
		_velocity = calculate_move_velocity(_velocity, direction, speed)
		_velocity.normalized()
		_velocity = move_and_slide(_velocity)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)

func power_function():
	power_bol = true
	if power_up == "green":
		power_function_green()

func power_function_green():
	if flag_power_bol:
		var direction: = get_direction()
		_velocity = calculate_move_velocity(_velocity, direction, speed * 8)
		_velocity.normalized()
		_velocity = move_and_slide(_velocity)
		print_debug("first time throug power function green")
		flag_power_bol = false
	else:
		_velocity = move_and_slide(_velocity)


func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2
) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y = speed.y * direction.y
	return out
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Timer_timeout():
	power_bol = false
#green powerup connection
func _on_ball_body_entered(body):
	power_up = "green"
	print_debug("green set")
