import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flame_first/joystick_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(GameWidget(game: SpaceShooterGame(),));
}


class SpaceShooterGame extends FlameGame with PanDetector{
  // late Player player;
  late JoystickExample joyStick;

  @override
  Color backgroundColor() {
    return Colors.black12;
  }

  @override
  Future<void> onLoad() async{
    await super.onLoad();
    // player = Player();
    joyStick = JoystickExample();
    // add(player);
    add(JoystickExample());
  }

  @override
  void onPanUpdate(DragUpdateInfo info){
    // player.move(info.delta.game);
  }

}

class Player extends SpriteComponent with HasGameRef<SpaceShooterGame>{

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('sprite-test.png');
    position = gameRef.size /2;
    width = 100;
    height = 150;
    anchor = Anchor.center;
  }

  // 네모칸 이동
  void move(Vector2 delta){
    position.add(delta);
  }
}


class JoystickExample extends FlameGame with HasDraggables {
  late final JoystickPlayer player;
  late final JoystickComponent joystick;

  @override
  Future<void> onLoad() async {
    final knobPaint = BasicPalette.blue.withAlpha(200).paint();
    final backgroundPaint = BasicPalette.blue.withAlpha(100).paint();
    joystick = JoystickComponent(
      // 컨트롤러 조이스틱 부분 (내부의 동그라미)
      knob: CircleComponent(radius: 30, paint: knobPaint),
      // 조이스틱의 드래그 반경 (외부의 동그라미)
      background: CircleComponent(radius: 70, paint: backgroundPaint),
      margin: const EdgeInsets.only(right: 40, bottom: 40),
    );
    player = JoystickPlayer(joystick);

    add(player);
    add(joystick);
  }

  @override
  void update(double dt) {
    super.update(dt);
    // player.x = player.x + dt;
  }

  // @override
  // Future<void>
}
