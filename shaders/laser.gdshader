/*

LineRendering solution

create a MeshInstance3D
set the mesh as a quad (default settings)
set texture (a vertical gradient with alpha looks best)

the quad is stretched into position based on the parameters and rotation, you can also set the default axis (default +y)

modified from:
https://godotshaders.com/shader/billboard-sprite3d-hitflash-godot-4-x/

*/

shader_type spatial;
render_mode unshaded; // optional

uniform sampler2D albedo: hint_default_white; // the laser texture, a vertical gradient is suggested

uniform float line_width = 1.0;
uniform float line_length = 1.0; // set this larger to stretch the line

uniform bool correct_uv = true; // correct the uv stretching

uniform vec2 uv_offset_animation = vec2(0, 1); // (optional) scroll the texture, it could look like a moving beam

uniform vec3 default_axis = vec3(0.0, 1.0, 0.0); // default axis the line follows before rotation (rotate the nodes transform)

uniform vec4 color: source_color = vec4(1.0); // modulate the color

uniform float brightness = 1.0; // make extra bright, good for lasers


void vertex() {
	VERTEX += vec3(0,0.5,0); // correction for quad to make it stretch correctly
	VERTEX.y *= line_length; // stretch the lines length
	VERTEX.x *= line_width; // thin or fat line
}

void fragment() {
	vec2 uv = UV;

    if (correct_uv){
        uv.y *= line_length;
    }

    uv += uv_offset_animation * TIME; // scrolls the texture

    vec4 _color = texture(albedo, uv);
    _color *= color;
    _color.r *= brightness;
    _color.g *= brightness;
    _color.b *= brightness;


    ALBEDO = vec3(_color.r, _color.g, _color.b);
    ALPHA = _color.a;
}