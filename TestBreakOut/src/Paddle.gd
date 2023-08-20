extends CharacterBody2D
# ============================================================
# パドル.
# ============================================================
class_name Paddle

# ------------------------------------------------------------
# const.
# ------------------------------------------------------------
const SPEED = 300.0

func _physics_process(delta: float) -> void:
	# マウスのX座標に近づける.
	var mouse = get_global_mouse_position()
	var dx = mouse.x - position.x
	velocity.x = dx * 10
	
	move_and_collide(velocity * delta)
