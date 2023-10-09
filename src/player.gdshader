shader_type canvas_item;

uniform vec4 origin:source_color = vec4(1.000000, 0.000000, 1.000000, 1.000000);
uniform vec4 new:source_color;

void fragment() {
    vec4 current_pixel = texture(TEXTURE, UV);

    if (current_pixel == origin)
        COLOR = new;
    else
        COLOR = current_pixel;
}