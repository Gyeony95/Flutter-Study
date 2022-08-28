import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_report/feature/02_auto_scroll_with_tabbar_exmaple/auto_scroll_with_tabbar_page.dart';

mixin AnchorPositionMixin {
  /// 텝 항목별 앵커포인트를 맵핑하여 저장
  final Map<TabBarCategory, double?> _positions = {};

  /// ### 스크롤 포지션에 대한 보정값.
  /// 전체 구조가 [SliverLayout]을 사용하고 있기에 상단 앱바및 탭바 영역이 콘텐츠를
  /// 덮고 있는 형태로 구성된다. 따라서 상단 영역의 높이만큼 포지션 변경 이벤트에 보정값을
  /// 더해주어서 계산한다.
  double get revision;

  /// ### 스크롤 오프셋 변경에 대한 리스너 일시정지 여부
  /// 탭 변경이벤트와 스크롤 변경 이벤트의 중복을 방지하는 플래그이다.
  bool _paused = false;

  /// ### 탭바 에니메이션 시간이 지난 후 [_paused]값을 바꾸는 타이머
  Timer? _pauseTimer;

  GlobalKey _firstKey = GlobalKey();

  GlobalKey _secondKey = GlobalKey();

  GlobalKey _thirdKey = GlobalKey();

  GlobalKey get firstKey {
    if (_firstKey.currentWidget != null) {
      _firstKey = GlobalKey();
    }
    return _firstKey;
  }

  GlobalKey get secondKey {
    if (_secondKey.currentWidget != null) {
      _secondKey = GlobalKey();
    }
    return _secondKey;
  }

  GlobalKey get thirdKey {
    if (_thirdKey.currentWidget != null) {
      _thirdKey = GlobalKey();
    }
    return _thirdKey;
  }

  /// ### 각 키들의 포지션을 확인한다.
  /// 상세 화면의 postFrameCallback 에서 호출되며, 렌더링된 직후 각 위젯의 포지션을 확인한다.
  void checkPosition(double scrollPosition) {
    var firstPosition = _getPosition(_firstKey);
    firstPosition =
    firstPosition != null ? firstPosition + scrollPosition : null;
    var secondPosition = _getPosition(_secondKey);
    secondPosition =
    secondPosition != null ? secondPosition + scrollPosition : null;
    var thirdPosition = _getPosition(_thirdKey);
    thirdPosition = thirdPosition != null ? thirdPosition + scrollPosition : null;
    _positions[TabBarCategory.first] = firstPosition;
    _positions[TabBarCategory.second] = secondPosition;
    _positions[TabBarCategory.third] = thirdPosition;
  }

  /// 특정 키로부터 클로벌 포지션을 구하는 함수
  double? _getPosition(GlobalKey key) {
    if (key.currentContext == null) {
      return null;
    }
    final box = key.currentContext?.findRenderObject() as RenderBox?;
    final offset = box?.localToGlobal(Offset.zero);
    return offset?.dy;
  }

  /// ### ⭐ 스크롤 변화에 대한 리스너
  void anchorListener(double position) {
    if (_paused) {
      return;
    }
    // 포지션에 보정값을 더한다.
    position += revision;

    final firstPosition = _positions[TabBarCategory.first];
    final secondPosition = _positions[TabBarCategory.second];
    final thirdPosition = _positions[TabBarCategory.third];
    if (thirdPosition != null && position >= thirdPosition) {
      onChangeProperTab(TabBarCategory.third);
      return;
    } else if (secondPosition != null && position >= secondPosition) {
      onChangeProperTab(TabBarCategory.second);
      return;
    } else if (firstPosition != null && position >= firstPosition) {
      onChangeProperTab(TabBarCategory.first);
      return;
    }
  }

  /// 스크롤변경에 따라 적절한 탭이 변걍될 경우 호출되는 콜백
  void onChangeProperTab(TabBarCategory tabItem);

  /// 탭바 선택시 [onTapTabItem]이 호출되고, 어떤 탭이 선택되었는지에 따라 이동해야하는
  /// 포지션을 계산해서 해당 콜백으로 전달한다.
  void shouldMoveScroll(double position);

  /// 탭바의 아이템이 탭된 경우 호출되는 콜백
  void onTapTabItem(TabBarCategory item) {
    if (_paused) {
      return;
    }
    final position = _positions[item];
    if (position != null) {
      _pauseScrollEvent();
      shouldMoveScroll(position - revision);
    }
  }

  /// [anchorListener]에서 스크롤 위치에 따라서 [onChangeProperTab]을 통해서
  /// 특정 탭으로 이동시키는 작업을 진행한다. 만약 [shouldMoveScroll]에서 탭 변경 방식을
  /// animate 방식을 사용하게 되면, 애니메이션 명령이 겹챠서 행동이 이상해보일 수 있다.
  /// 따라서 [shouldMoveScroll]을 호출하기 전에 해당 메서드를 통해서 [kTabScrollDuration]
  /// 동안 스크롤이벤트에 대해서 무시하게 한다.
  void _pauseScrollEvent() {
    _paused = true;
    _pauseTimer?.cancel();
    _pauseTimer = Timer(kTabScrollDuration, () {
      _paused = false;
      _pauseTimer = null;
    });
  }
}
