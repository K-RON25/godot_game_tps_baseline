class_name HUD
extends CanvasLayer

@onready var hp   : ProgressBar = %HealthPoints
@onready var ammo : Label = %Ammo
@onready var score: Label = %Score

# Colour styling for HP bar
var _bg_style  := StyleBoxFlat.new()
var _fill_style := StyleBoxFlat.new()

func _ready() -> void:
	# Nice rounded bar with a translucent background
	_bg_style.bg_color = Color(0, 0, 0, 0.35)
	_bg_style.set_corner_radius_all(6)
	_fill_style.set_corner_radius_all(6)
	# Attach styleboxes once
	hp.add_theme_stylebox_override("background", _bg_style)
	hp.add_theme_stylebox_override("fill", _fill_style)
	
func set_hp(v:int) -> void:
	v = clampi(v, 0, 100)
	hp.value = v
	
	# Smooth gradient: 0–25% red→orange, 25–100% orange→green
	var t := float(v) / 100.0
	var col := (
		Color(1, 0, 0).lerp(Color(1, 0.5, 0), t / 0.25)
		if t <= 0.25
		else Color(1, 0.5, 0).lerp(Color(0, 1, 0), (t - 0.25) / 0.75)
	)
	_fill_style.bg_color = col

func set_ammo(current:int, reserve:int) -> void:
	ammo.text = "Ammo: %d/%d" % [current, reserve]

func set_score(v:int) -> void:
	score.text = "Score: %d" % v
