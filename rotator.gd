extends NodeMD

@export var c : Vector3

var time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	time = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	time += delta
	m_rot.x = sin(time) * c.x
	m_rot.y = sin(time) * c.y
	m_rot.z = sin(time) * c.z
	_update_basis()
