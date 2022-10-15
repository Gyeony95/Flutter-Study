import 'package:flutter/material.dart';

class ItemListBottomSheet extends StatelessWidget {
  final Function(int) onTapItem;
  const ItemListBottomSheet({Key? key, required this.onTapItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 20.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 100.0 / 50.0,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () => onTapItem.call(index),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
              ),
              alignment: Alignment.center,
              child: Image.asset('assets/images/items/item_$index.png'),
            ),
          );
        },
      ),
    );
  }
}
