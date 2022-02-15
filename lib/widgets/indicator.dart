import 'dart:math';

import 'package:flutter/material.dart';
import 'package:viewpager/screens/HomePage.dart';


class BuildIndicator extends StatefulWidget {
  final int currentPage;
  final int currentIcon;
  const BuildIndicator({Key? key, required this.currentPage,
    required this.currentIcon}) : super(key: key);

  @override
  State<BuildIndicator> createState() => _BuildIndicatorState();
}

class _BuildIndicatorState extends State<BuildIndicator> with SingleTickerProviderStateMixin{

  late AnimationController _animController;
  @override
  void initState() {
    _animController = AnimationController(vsync: this,
    duration: const Duration(
      milliseconds: 500
    ),
    );

    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
    _animController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.currentIcon == 0)
      {
        _animController.reverse();
      }else {
      _animController.forward();
    }
    return  RotationTransition(
      turns: Tween(begin: 0.0, end: 0.75).animate(_animController),
      child: Container(

        margin: const EdgeInsets.only(bottom: 35),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(

          border: Border.all(color: Colors.white,
          width: 2,),
          borderRadius: BorderRadius.circular(30)
        ),
        child: Row(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < imageUrl.length; i++)
              if (i == widget.currentPage)
                ...[indicatorItem(true)] else
                indicatorItem(false),
          ],
        ),
      ),
    );
  }

  Widget indicatorItem(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
          color: isActive ? Colors.white : Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(12))),
    );
  }
}
