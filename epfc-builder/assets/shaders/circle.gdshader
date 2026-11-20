shader_type canvas_item;

uniform float radius : hint_range(0.0, 0.5) = 0.5;
uniform float softness : hint_range(0.0, 0.05) = 0.01;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	float d = distance(UV, vec2(0.5));
	
	col.a *= 1.0 - smoothstep(radius - softness, radius, d);
	COLOR = col;
}