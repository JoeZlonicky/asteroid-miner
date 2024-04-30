shader_type canvas_item;

uniform vec4 bg_color: source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 star_color : source_color = vec4(1.0);

uniform float star_size: hint_range(1.0, 10.0) = 1.0;
uniform float star_density: hint_range(0.0, 1.0) = 0.5;
uniform float star_twinkle_speed: hint_range(0.0, 10.0) = 5.0;

uniform vec2 camera_offset;

// https://godotshaders.com/snippet/random-value/
float random_value(vec2 v) {
    return fract(sin(dot(v, vec2(12.9898,78.233))) * 43758.5453123);
}

void fragment() {
	vec2 pos = floor((FRAGCOORD.xy + camera_offset) / star_size);
	float chance = 1.0 - pow(star_density, 2.0) * 0.05;
	if (random_value(pos) > chance) {
		// Need a different random value so it isn't just the values > chance
		float r = random_value(pos + 1.0);
		
		float opacity = 0.5 + sin(TIME * r * star_twinkle_speed) * 0.5;
		COLOR = mix(bg_color, star_color, opacity * star_color.a);
	} else {
		COLOR = bg_color;
	}
}