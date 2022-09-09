import 'package:flutter/material.dart';
import 'package:flutter_report/feature/main_frame.dart';
import 'package:flutter_report/main.dart';

class ExpansionChildPage extends StatefulWidget {
  const ExpansionChildPage({Key? key}) : super(key: key);

  @override
  State<ExpansionChildPage> createState() => _ExpansionChildPageState();
}

class _ExpansionChildPageState extends State<ExpansionChildPage> with TickerProviderStateMixin {
  static final Animatable<double> _easeInTween = CurveTween(curve: Curves.easeIn);
  late AnimationController _controller;
  late Animation<double> _heightFactor;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _heightFactor = _controller.drive(_easeInTween);
    if (_isExpanded) {
      _controller.value = 1.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainFrame(
      route: FeatureEnum.expansionChild,
      child: Column(
        children: [
          _header(context),
          _expandableBody(),
        ],
      ),
    );
  }

  Widget _header(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      width: MediaQuery.of(context).size.width,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        children: [
          const Text('please tab! --->'),
          const Spacer(),
          GestureDetector(
            onTap: () => _handleTap(),
            child: const Icon(Icons.keyboard_arrow_down, size: 20,),
          ),
        ],
      ),
    );
  }

  Widget _expandableBody(){
    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChild,
      child: _animationChild(),
    );
  }

  Widget _buildChild(BuildContext context, Widget? child){
    return ClipRect(
      child: Align(
        alignment: Alignment.center,
        heightFactor: _heightFactor.value,
        child: child,
      ),
    );
  }

  Widget _animationChild(){
    final bool closed = !_isExpanded && _controller.isDismissed;
    return Offstage(
      offstage: closed,
      child: TickerMode(
        enabled: !closed,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          color: Colors.brown,
        ),
      ),
    );
  }


  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }
}
