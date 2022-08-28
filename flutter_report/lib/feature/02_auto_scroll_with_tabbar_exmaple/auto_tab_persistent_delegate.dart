part of 'auto_scroll_with_tabbar_page.dart';

/// # 동행모집 상세 화면의 탭바 영역
class _AutoTabPersistentDelegate extends SliverPersistentHeaderDelegate
    {
      _AutoTabPersistentDelegate({
    required this.tabController,
    required this.onTapTabItem,
    required this.extent,
  });

  /// 탭바의 컨트롤러
  final TabController tabController;

  /// 각 탭 아이템을 선택한 경우의 콜백
  final void Function(TabBarCategory item) onTapTabItem;

  /// 선택된 라벨의 스타일
  final _labelStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 15.sp,
    color: Colors.white
  );

  /// 선택되지 않은 라벨의 스타일
  final _unselectedStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 15.sp,
      color: const Color(0xff999999)
  );

  /// [SliverPersistentHeaderDelegate]의 높이
  late final double extent;

  /// 텝 아이템 목록
  final List<TabBarCategory> items = <TabBarCategory>[
    TabBarCategory.first,
    TabBarCategory.second,
    TabBarCategory.third,
  ];

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xff1b1b1b),
        border: Border(
          bottom: BorderSide(color: Color(0xff1b1b1b)),
        ),
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        labelStyle: _labelStyle,
        unselectedLabelStyle: _unselectedStyle,
        onTap: (index) => onTapTabItem(items[index]),
        tabs: items
            .map((e) => SizedBox(
                  height: extent,
                  child: Text(
                    e.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
        ).toList(),
      ),
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => extent;

  @override
  bool shouldRebuild(_AutoTabPersistentDelegate oldDelegate) {
    return true;
  }
}


