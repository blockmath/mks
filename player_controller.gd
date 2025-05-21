class_name PlayerController extends XROrigin3D

@onready var rotation_root : NodeMD = $"../RemoteRoot/Root"
@onready var position_root : NodeMD = $"../RemoteRoot/Root/Root"
@onready var light_root : NodeMD = $"../RemoteRoot/LightRoot"

@onready var cntl_left : XRController3D = $"LeftHandController"

@onready var camera_root : XROrigin3D = $"."
@onready var camera : XRCamera3D = $"XRCamera3D"

var look_angle : Vector3 # X is pitch, Y is yaw, Z is roll

var velocity : Vector3 = Vector3.ZERO

var MOVE_SPEED : float = 4.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_offload_position()
	look_angle = Vector3.ZERO
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_viewport().use_xr = true

func _offload_position() -> void:
	position_root.position -= get_parent_node_3d().position
	get_parent_node_3d().position -= get_parent_node_3d().position
	camera_root.global_position = Vector3.ZERO
	camera_root.global_basis = Basis.from_euler(Vector3(0, -PI/2, 0))

func _process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_focus"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("ui_esc"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float) -> void:
	var i_x : Vector3 = Basis.FLIP_X * basis * Vector3(cntl_left.get_vector2(&"primary").x, 0, 0)
	var i_y : Vector3 = Basis.FLIP_X * basis * Vector3(0, 0, cntl_left.get_vector2(&"primary").y)
	position_root.position -= (i_x * delta * MOVE_SPEED) * (rotation_root.basis).inverse()
	position_root.position -= (i_y * delta * MOVE_SPEED) * (Basis.FLIP_Y * rotation_root.basis).inverse()
	rotation_root.m_rot = Vector3(camera.rotation.z, camera.rotation.y, camera.rotation.x)
	light_root.m_rot = -rotation_root.m_rot * Basis.FLIP_Z
