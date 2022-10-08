import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class GameBackGround extends SpriteComponent with HasGameRef {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('room.jpeg');
    // var origin = sprite!.originalSize; // <-- 실제사이즈
    // size = origin;

    final gameSize = gameRef.size; // <-- 화면 사이즈
    size = Vector2(gameSize.x, gameSize.y);
  }
}
