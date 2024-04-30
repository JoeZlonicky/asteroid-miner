shader_type canvas_item;

uniform vec4 flash_color: source_color = vec4(1.f);
uniform float flash_strength: hint_range(0.0, 1.0) = 0.f;

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	if (c.a < 0.01) {
		COLOR = c;
	} else {
		COLOR = mix(c, flash_color, flash_strength);
	}

}