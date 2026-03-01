extends ColorRect

func _ready():
	# Make sure it draws behind everything
	z_index = -100

func _process(_delta: float) -> void:
	var cam = get_viewport().get_camera_2d()
	if cam:
		var vp_size = get_viewport_rect().size
		# Center the rect on the camera each frame
		global_position = cam.global_position - vp_size / 2.0
		size = vp_size
