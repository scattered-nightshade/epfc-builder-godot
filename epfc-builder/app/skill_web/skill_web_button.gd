@tool class_name SkillWebButton extends TextureButton

const SIZE_MINOR: float = 50.0
const SIZE_MAJOR: float = 75.0
const SIZE_CORE: float = 100.0

@export var skill_node: SkillNodeResource

var similar_highlight: bool = false:
	set(value):
		if similar_highlight == value:
			return
		similar_highlight = value
		apply_textures()

func setup(_skill_node: SkillNodeResource) -> void:
	skill_node = _skill_node
	name = "%d %s" % [skill_node.id, skill_node.get_display_name()]
	
	var _size: float
	if skill_node.core:
		_size = SIZE_CORE
	elif skill_node.skill != null && skill_node.skill.major_skill:
		_size = SIZE_MAJOR
	else:
		_size = SIZE_MINOR
	
	custom_minimum_size = Vector2(_size, _size)
	size = custom_minimum_size
	position = skill_node.position - (size / 2)
	
	tooltip_text = "%s\n%s" % [skill_node.get_display_name(), skill_node.get_description()]
	apply_textures()
	
	

func get_centre() -> Vector2:
	return position + size / 2

func apply_textures() -> void:
	if skill_node == null:
		print("bleh")
		return
	
	if skill_node.skill == null:
		print(skill_node.id)
		return
	
	var skill: SkillResource = skill_node.skill
	
	if similar_highlight && skill.similar_icon != null:
		texture_normal = skill.similar_icon
		texture_pressed = skill.similar_icon
	else:
		texture_normal = skill.unselected_icon
		texture_pressed = skill.selected_icon
	
