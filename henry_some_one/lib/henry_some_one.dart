library henry_some_one;

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:henry_some_one/animated_player.dart';
import 'package:henry_some_one/game_background.dart';
import 'package:henry_some_one/item.dart';
import 'package:henry_some_one/item_list_bottom_sheet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HenrySomeOneGame extends StatefulWidget {
  const HenrySomeOneGame({Key? key}) : super(key: key);

  @override
  State<HenrySomeOneGame> createState() => _HenrySomeOneGameState();
}

class _HenrySomeOneGameState extends State<HenrySomeOneGame> {

  List<int> list = [];

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      minHeight: 40,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      panel: ItemListBottomSheet(onTapItem: onTapItem ,),
      body: GameWidget.controlled(
        gameFactory: () => MyStaticGame(list : list),
        loadingBuilder: (context) => const Material(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
        errorBuilder: (context, ex) => const Material(
          child: Center(
            child: Text('에러났슈'),
          ),
        ),
      ),
    );
  }

  void onTapItem(int index){
    debugPrint(index.toString());
    if(list.contains(index)) return;
    list.add(index);
    setState(() {});
  }
}

class MyStaticGame extends FlameGame with HasCollisionDetection {

  List<int> list;
  MyStaticGame({required this.list});

  @override
  Color backgroundColor() => const Color(0x00000000);

  final GameBackGround _backGround = GameBackGround();
  @override
  Future<void> onLoad() async {
    // 화면 고정
    add(ScreenHitbox());
    await add(_backGround);

    // 플레이어의 사이즈
    final playerSize = Vector2(150, 100);
    // 플레이어의 위치
    final playerPosition = Vector2(200, 600);
    // 플레이어의 위치 및 사이즈 input
    add(AnimatedPlayer(playerPosition, playerSize));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if(list.isEmpty) return;
    Vector2 position = Vector2(list.last * 50, 100);
    add(Item(position, index: list.last));
  }
}
