extends CharacterBody2D
# ======================================================
# ボール.
# ======================================================

# ------------------------------------------------------
# const.
# ------------------------------------------------------
## 最初の速度.
const INIT_SPEED = 100.0
## 加速値.
const SPEED_UP = 10.0
## 最高速度.
const MAX_SPEED = 1000.0

# ------------------------------------------------------
# onready.
# ------------------------------------------------------
@onready var _spr = $Sprite2D

# ------------------------------------------------------
# var.
# ------------------------------------------------------
## 移動速度.
var _velocity = Vector2()
## 速さ.
var _speed = INIT_SPEED
## 回転速度.
var _rot_speed = 0.0

# ------------------------------------------------------
# public functions.
# ------------------------------------------------------
## 速度を取得.
func get_speed() -> float:
	return _speed
	
## 更新.
func update(delta:float) -> void:
	_update(delta)

# ------------------------------------------------------
# private functions.
# ------------------------------------------------------
## 開始.
func _ready() -> void:
	# 45度回転させて開始.
	_velocity = Vector2.RIGHT.rotated(deg_to_rad(45))
	_velocity *= _speed

## 更新.
func _update(delta: float) -> void:
	# 回転.
	_spr.rotation += _rot_speed * delta
	_spr.rotation *= 0.995 # 減衰する.

	# 衝突処理.
	var col = move_and_collide(_velocity * delta)
	_collide(col)

## 衝突処理.
func _collide(col:KinematicCollision2D) -> void:
	if col == null:
		return # 衝突していない.
	
	# 衝突した.
	var body = col.get_collider()
	# 法線を取得する.
	var n = col.get_normal()
	# 回転.
	var delta_angle = n.angle_to(_velocity)
	_rot_speed += delta_angle * 3

	# 跳ね返り処理.
	_velocity = _velocity.bounce(n)
	
	# 加速する.
	_speed += SPEED_UP
	if _speed > MAX_SPEED:
		_speed = MAX_SPEED # 最高速度は超えない.
	_velocity = _velocity.normalized() * _speed
	
