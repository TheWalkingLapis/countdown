extends Node

# takes a global pos and returns the according pos within the screen dimensions
func modulo_position(pos: Vector2, viewportRect: Rect2) -> Vector2:
	var screenSize = viewportRect.size
	return Vector2(wrapf(pos.x, 0.0, screenSize.x), wrapf(pos.y, 0.0, screenSize.y))
