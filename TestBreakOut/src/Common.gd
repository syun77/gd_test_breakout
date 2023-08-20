extends Node

const MAX_HP = 3

# スコア.
var score = 0
# ハイスコア.
var hi_score = 0
# HP.
var hp = MAX_HP

## 初期化.
func init() -> void:
	score = 0
	hp = MAX_HP

## スコアの加算.
func add_score(v:int) -> void:
	score += v
	if score > hi_score:
		hi_score = score

## HPを減らす.
func damage(v:int) -> void:
	hp -= v
	if hp < 0:
		hp = 0

## 死亡したかどうか.
func is_dead() -> bool:
	return hp <= 0
