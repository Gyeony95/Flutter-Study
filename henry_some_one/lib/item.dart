import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Item extends SpriteComponent with HasGameRef {
  int index;
  Item( Vector2 position,
      {required this.index}) :super( position: position,);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('items/item_$index.png');
    size = Vector2(40, 40);
  }
}
