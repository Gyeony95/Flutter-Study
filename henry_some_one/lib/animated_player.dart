import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class AnimatedPlayer extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {

  AnimatedPlayer(
    Vector2 position,
    Vector2 size,
  ) : super(
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  @override
  Future<void>? onLoad() async {
    animation = await gameRef.loadSpriteAnimation(
      'animated_player.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.5,
        textureSize: Vector2(16, 16),
      ),
    );
    return super.onLoad();
  }
}
