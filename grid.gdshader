shader_type spatial;

uniform vec4 col_a : source_color;
uniform vec4 col_b : source_color;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (int(floor(UV.x * 200.0) + floor(UV.y * 200.0)) % 2 == 0) {
		ALBEDO = col_a.rgb;
	} else {
		ALBEDO = col_b.rgb;
	}
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
