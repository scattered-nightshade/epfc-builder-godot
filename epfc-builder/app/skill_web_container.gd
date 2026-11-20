class_name SkillWebContainer extends Control

var dragging: bool = false

@onready var skill_web: SkillWeb = %SkillWeb

# Middle mouse because if it was on LMB then it would shift around whenever you clicked on a skill
# Not RMB either since the planning features will be based on that

func _gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			dragging = event.pressed
			
		elif event.pressed and event.button_index in [MOUSE_BUTTON_WHEEL_UP, MOUSE_BUTTON_WHEEL_DOWN]:
			var factor: float
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				factor = 1.1
			elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				factor = 0.9
			
			var new_scale: float = clampf(skill_web.scale.x * factor, 0.25, 3.0)
			
			var local: Vector2 = (event.position - skill_web.position) / skill_web.scale.x
			
			skill_web.scale = Vector2.ONE * new_scale
			skill_web.position = event.position - local * new_scale
			
	elif event is InputEventMouseMotion and dragging:
		skill_web.position += event.relative
