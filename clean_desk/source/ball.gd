extends Area2D

signal green_powerup_taken


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "_on_timer_timeout")
	self.connect("body_entered", self, "_on_body_entered", [timer])
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("debug"):
		anim_player.play("fly_away")



func _on_body_entered(body, timer):
	anim_player.play("fly_away")
	timer.start()


func _on_timer_timeout():
	anim_player.play("float_hover")
