part of 'auto_scroll_with_tabbar_page.dart';

/// 탭바에 사용되는 탭들의 정보
enum TabBarCategory{
  first('첫번째', Colors.orangeAccent),
  second('두번째', Colors.brown),
  third('세번째', Colors.lightGreen);

  final String name;
  final Color color;
  const TabBarCategory(this.name, this.color);
}