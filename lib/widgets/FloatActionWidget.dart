
import 'package:flutter/material.dart';


class FloatActionWidget extends StatefulWidget {
  final ValueChanged<int>  valueChanged;
  final int currentIcon;
  const FloatActionWidget({Key? key,
  required this.valueChanged, required this.currentIcon}) : super(key: key);

  @override
  _FloatActionWidgetState createState() => _FloatActionWidgetState();
}

class _FloatActionWidgetState extends State<FloatActionWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: FloatingActionButton(

        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, animation) =>
              RotationTransition(
                turns:  child.key==const ValueKey('icVertical')? Tween<double>(
                    begin:0.75,
                    end: 1.0
                ).animate(animation):
                Tween<double>(begin: 1.0,end: 0.75).animate(animation),
                child: ScaleTransition(scale: animation, child: child),
              ),
          child: widget.currentIcon ==0 ?const Icon(Icons.height,
            key: ValueKey('icHorizontal'),
            size: 40,) :
          const Icon(Icons.format_list_bulleted,
            key: ValueKey('icVertical'),
            size: 40,),
        ),
        onPressed: () {
         widget.valueChanged(widget.currentIcon);

        },

      ),
    );
  }
}
