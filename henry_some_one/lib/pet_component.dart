import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class PetComponent extends SpriteAnimationComponent
    with CollisionCallbacks, HasGameRef {
  final Vector2 velocity;

  PetComponent(
      this.velocity,
      Vector2 position,
      Vector2 size, {
        double angle = -pi / 4,
      }) : super(
    position: position,
    size: size,
    angle: angle,
    anchor: Anchor.center,
  );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    animation = await gameRef.loadSpriteAnimation(
      'pet_sheet.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.2,
        textureSize: Vector2.all(16),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity * dt;
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints,
      PositionComponent other,
      ) {
    super.onCollisionStart(intersectionPoints, other);
    velocity.negate();
    flipHorizontally();
  }
}
