extends Camera3D

const CAMERA_IS_DEBUG : bool = true

@onready var rotation_root : NodeMD = $"../../Root"
@onready var position_root : NodeMD = $"../../Root/Root"
@onready var light_root : NodeMD = $"../../LightRoot"

var look_angle : Vector2

func _input(event : InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			var mot : Vector2 = (event as InputEventMouseMotion).relative
			look_angle += Vector2(mot.y / 360, mot.x / 360)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_offload_position()
	look_angle = Vector2(0, 0)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _offload_position() -> void:
	position_root.position -= get_parent_node_3d().position
	get_parent_node_3d().position -= get_parent_node_3d().position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_focus"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var i : Vector3 = basis * Vector3(Input.get_axis("ls_lt", "ls_rt"), 0, Input.get_axis("ls_fw", "ls_bw"))
	if CAMERA_IS_DEBUG:
		position_root.global_position -= i * delta * 10
		_offload_position()
	rotation_root.m_rot.y = -look_angle.y
	light_root.m_rot.y = look_angle.y
	look_angle.x = clampf(look_angle.x, deg_to_rad(-85), deg_to_rad(85))
	rotation.x = -look_angle.x
	rotation_root._update_basis()
