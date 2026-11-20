class_name SkillPointsContainer extends PanelContainer

@onready var skill_points_label: Label = %SkillPointsLabel
@onready var skill_points_slider: HSlider = %SkillPointsSlider

func _ready() -> void:
	skill_points_slider.value_changed.connect(set_level)
	Build.changed.connect(refresh)
	
	refresh()

func set_level(valuef: float) -> void:
	var value: int = roundi(valuef)
	
	Build.set_level(value)

func refresh() -> void:
	skill_points_label.text = "Skill Points: %d/%d" % [Build.get_skill_points_allocated(), Build.get_level()]
