shader_type canvas_item;

uniform vec4 base_gray : source_color = vec4(0.01, 0.01, 0.01, 1.0); // darkest gray
uniform float pulse_speed : hint_range(0.1, 10) = 4;          // how fast it pulses
uniform float threshold : hint_range(0.0, 1.0) = 0.1;            // white pixel cutoff

void fragment() {
    vec4 tex = texture(TEXTURE, UV);    // original PNG
    float brightness = tex.r;            // assumes grayscale PNG

    // Calculate pulsing factor (0 -> 1)
    float pulse = (sin(TIME * pulse_speed) + 1.0) / 2.0;

    // Mix between black and base_gray based on pulse
    vec3 gray = mix(vec3(0.0), base_gray.rgb, pulse);

    // Keep white parts white, pulse the black parts
    if (brightness > threshold) {
        COLOR = vec4(1.0, 1.0, 1.0, tex.a);  // eyes stay white
    } else {
        COLOR = vec4(gray, tex.a);
    }
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
