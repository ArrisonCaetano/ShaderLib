shader_type spatial;

uniform float speed : hint_range(0, 10) = 1;
uniform float amplitude : hint_range(0, 100) = 1;
uniform float period : hint_range(0, 100) = 1;

void vertex() {
	VERTEX.x += amplitude * sin(speed * TIME + VERTEX.y * period);
}