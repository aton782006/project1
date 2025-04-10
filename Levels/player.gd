extends CharacterBody3D

class_name PlayerController

## حساسية الماوس
@export var mouse_sensitivity: float = 0.5
## سرعة الحركة
@export var move_speed: float = 5.0
## قوة القفز
@export var jump_velocity: float = 4.5
## قوة الجاذبية
@export var gravity: float = 9.8
## زوايا الحدود للكاميرا (بالدرجات)
@export var camera_clamp_angles: Vector2 = Vector2(-70, 70)

@onready var camera: Camera3D = $Camera3D

var _velocity: Vector3 = Vector3.ZERO
var _can_move: bool = true

func _ready() -> void:
	# إخفاء وتثبيت مؤشر الماوس
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	# التحقق من وجود الكاميرا
	assert(camera != null, "Camera3D node not found!")

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		# تدوير الجسم حول المحور Y (يمين/يسار)
		rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		
		# تدوير الكاميرا حول المحور X (أعلى/أسفل)
		camera.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
		camera.rotation.x = clamp(
			camera.rotation.x, 
			deg_to_rad(camera_clamp_angles.x), 
			deg_to_rad(camera_clamp_angles.y)
		)
	
	# الخروج من وضع التقاط الماوس
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	# العودة إلى وضع التقاط الماوس
	if event.is_action_pressed("left_click") and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	if not _can_move:
		return
	
	# تطبيق الجاذبية
	if not is_on_floor():
		_velocity.y -= gravity * delta
	else:
		_velocity.y = 0.0

	# معالجة القفز
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		_velocity.y = jump_velocity

	# معالجة الحركة
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		_velocity.x = direction.x * move_speed
		_velocity.z = direction.z * move_speed
	else:
		_velocity.x = move_toward(_velocity.x, 0, move_speed)
		_velocity.z = move_toward(_velocity.z, 0, move_speed)

	move_and_slide()

func attack() -> void:
	if $AnimationPlayer.has_animation("attack"):
		$AnimationPlayer.play("attack")
	elif $AnimationPlayer.has_animation("dam"):
		$AnimationPlayer.play("dam")

func set_movement_enabled(enabled: bool) -> void:
	_can_move = enabled
