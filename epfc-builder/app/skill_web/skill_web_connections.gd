class_name SkillWebConnections extends Control

@onready var skill_web: SkillWeb = $".."

@export var line_color_locked: Color = Color("c0c0c0")
@export var line_color_unlocked: Color = Color("ffffff")
@export var line_width: float = 6.0

func _draw() -> void:
	for id in skill_web.buttons:
		var butt: SkillWebButton = skill_web.buttons.get(id)
		for conn_butt_id in butt.skill_node.connections:
			var connection_butt: SkillWebButton = skill_web.buttons.get(conn_butt_id)
			
			if connection_butt == null:
				continue
			
			# This here prevents redraws
			if conn_butt_id < id && id in connection_butt.skill_node.connections:
				continue
			
			var butt_centre: Vector2 = butt.get_centre() - position
			var connection_butt_centre: Vector2 = connection_butt.get_centre() - position
			var both_active: bool = butt.button_pressed && connection_butt.button_pressed
			
			var line_color: Color
			if both_active:
				line_color = line_color_unlocked
			else:
				line_color = line_color_locked
			
			draw_line(butt_centre, connection_butt_centre, line_color, line_width, true)
