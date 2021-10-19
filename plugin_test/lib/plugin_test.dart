
import 'package:flutter/material.dart';
import 'package:plugin_test/gyeony_node_model.dart';

class PluginTest extends StatefulWidget {

  PluginTest({
    required this.list
    , this.iconSize
    , this.textColor});

  final List<GyeonyNodeModel> list;
  final double? iconSize;
  final Color? textColor;

  @override
  _PluginTestState createState() => _PluginTestState();
}

class _PluginTestState extends State<PluginTest> {


  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        alignment: WrapAlignment.end,
        children: widget.list.map((nodeModel) {
          return InkWell(
            highlightColor: const Color(0xffd0d0d0),
            borderRadius: BorderRadius.all(
              Radius.circular(12.0),
            ),
            onTap: () {
              if(nodeModel.onPressed != null){
                nodeModel.onPressed!.call();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
                border: Border.all(
                  color: const Color(0xffd0d0d0),
                  width: 1.0,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(nodeModel.iconData != null && widget.iconSize != null)
                    Icon(nodeModel.iconData, size: widget.iconSize,),
                  Text(
                    nodeModel.name,
                    style: TextStyle(
                        color: widget.textColor ?? Colors.black
                    ),
                  )
                ],
              ),
            ),
          );
        }).toList()
    );
  }
}







