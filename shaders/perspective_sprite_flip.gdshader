shader_type spatial;
render_mode unshaded, cull_disabled, depth_draw_opaque, depth_prepass_alpha;

uniform bool y_billboard = false; // Enables Y-Billboarding when true
uniform sampler2D tex: source_color, filter_nearest_mipmap; // A copy of the texture for the Sprite3D or AnimatedSprite3D 

void vertex() {
	// You can comment out this function if you don't need billboarding
	if (y_billboard == true) {
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(vec4(normalize(cross(vec3(0.0, 1.0, 0.0), INV_VIEW_MATRIX[2].xyz)), 0.0), vec4(0.0, 1.0, 0.0, 0.0), vec4(normalize(cross(INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0), MODEL_MATRIX[3]);
	}
	else {
		MODELVIEW_MATRIX = VIEW_MATRIX * mat4(INV_VIEW_MATRIX[0], INV_VIEW_MATRIX[1], INV_VIEW_MATRIX[2], MODEL_MATRIX[3]);
	}
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

uniform bool flipped = false;

void fragment() {
	bool flp = flipped;
	vec3 right = (MODEL_MATRIX * vec4(1., 0., 0., 0.)).xyz;
	vec3 node_to_cam = normalize(CAMERA_POSITION_WORLD - NODE_POSITION_WORLD);
	float dot_prod = dot(right, node_to_cam);
	if (dot_prod > 0.0) {
		flp = false;
	} else {
		flp = true;
	}
	vec2 uv = UV;
	if (flp) {
		uv.x = 1.0 - uv.x;
	}
	vec4 col = texture(tex, uv);
	ALBEDO = vec3(col.r, col.g, col.b);
	ALPHA = col.a;
}