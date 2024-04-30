shader_type canvas_item;

uniform vec3 flash_color: source_color = vec3(1.f);
uniform float flash_strength: hint_range(0.0, 1.0) = 0.f;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec3 mixed = mix(color.rgb, flash_color, flash_strength);
	COLOR = vec4(mixed, color.a);
}