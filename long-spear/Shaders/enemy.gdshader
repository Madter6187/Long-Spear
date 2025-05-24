shader_type canvas_item;

uniform vec4 hit_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform bool hit_on = false;

void fragment() {
	vec4 sprite_color = texture(TEXTURE, UV);
	vec3 final_rgb = hit_on ? hit_color.rgb : sprite_color.rgb;
	COLOR = vec4(final_rgb, sprite_color.a);

}