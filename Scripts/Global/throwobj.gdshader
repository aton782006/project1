shader_type canvas_item;

uniform float waveAmplitude: hint_range(-1.0, 1.0) = 0.25;
uniform float waveFrequency: hint_range(0.0, 100.0) = 10.0;
uniform bool verticalWave = true;
uniform float waveSpeed: hint_range(0.0, 100.0) = 1.0;
uniform float firstHalf: hint_range(0.0, 1.0) = 0.5;
uniform float secondHalf: hint_range(0.0, 1.0) = 0.5;

void fragment() {
	vec2 uv = UV;
	float waveUv = (verticalWave ? uv.x : uv.y);
	float againstWaveUv = (verticalWave ? uv.y: uv.x);
	float freezeFactor = 1.0;
	if (againstWaveUv < firstHalf || againstWaveUv > 1.0 - secondHalf) {
		float wave;
			wave = freezeFactor * sin(waveUv * waveFrequency + TIME * waveSpeed) * (waveAmplitude / 4.0);
		vec2 aspect = vec2(TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y, 1.0);
	    vec2 center = 0.5 * aspect;
		uv -= center;
		if (verticalWave) {
		    uv.y += wave;
			uv.y += uv.y * waveAmplitude;
		} else {
		    uv.x += wave;
			uv.x += uv.x * waveAmplitude;
		}
		uv += center;
		uv = clamp(uv, vec2(0.0), vec2(1.0));
		againstWaveUv = (verticalWave ? uv.y : uv.x);
		vec4 texColor = texture(TEXTURE, uv);
		if (againstWaveUv <= 0.0 || againstWaveUv >= 1.0) {
			COLOR.a = 0.0;
		} else {
			COLOR = texColor;
		}
	}
}