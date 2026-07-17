extends Area2D

@export var speed = 400 #export mak
var screen_size 
signal hit
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size #gets the screensize
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO #sets velocity to zero default
	if Input.is_action_pressed("move_right"): # if is action pressed is true it moves
		velocity.x += 1
		$CollisionShapeUp.disabled = false
		$CollisionShapeWalk.disabled = true
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$CollisionShapeUp.disabled = false
		$CollisionShapeWalk.disabled = true
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$CollisionShapeUp.disabled = true
		$CollisionShapeWalk.disabled = false
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$CollisionShapeUp.disabled = true
		$CollisionShapeWalk.disabled = false
	if velocity.length() > 0: #plays the animation if it is moving
		velocity = velocity.normalized() * speed #normalized slows it down
		$AnimatedSprite2D.play() # $ is short for getnode() it basically gets the animation and plays
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta # adds movement times frame length
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x > 0 #its a standin for ture/false velocity.x<0 true so flip true
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	
	


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShapeWalk.disabled = true
	$CollisionShapeUp.disabled = true
	
func start(pos):
	position = pos
	show()
	$CollisionShapeWalk.disabled = false
	$CollisionShapeUp.disabled = false


func show_game_over() -> void:
	pass # Replace with function body.
