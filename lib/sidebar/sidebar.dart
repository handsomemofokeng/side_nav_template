import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:side_nav_template/Global.dart';

class SideBar extends StatefulWidget {
  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar>
    with SingleTickerProviderStateMixin<SideBar> {
  bool isSideBarOpened = false;
  final _animationDuration = const Duration(milliseconds: 500);

  AnimationController _animationController;
  StreamController<bool> isSideBarOpenedStreamController;
  Stream<bool> isSideBarOpenedStream;
  StreamSink<bool> isSideBarOpenedSink;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    isSideBarOpenedStreamController = PublishSubject<bool>();
    isSideBarOpenedStream = isSideBarOpenedStreamController.stream;
    isSideBarOpenedSink = isSideBarOpenedStreamController.sink;
  }

  @override
  void dispose() {
    _animationController.dispose();
    isSideBarOpenedStreamController.close();
    isSideBarOpenedSink.close();
    super.dispose();
  }

  void onMenuTapped() {
    final animationStatus = _animationController.status;
    final isAnimationCompleted = animationStatus == AnimationStatus.completed;

    if (isAnimationCompleted) {
      isSideBarOpenedSink.add(false);
      _animationController.reverse();
    } else {
      isSideBarOpenedSink.add(true);
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AnimatedPositioned(
      duration: _animationDuration,
      top: 0,
      bottom: 0,
      left: isSideBarOpened ? 0 : 0,
      right: isSideBarOpened ? 0 : screenWidth - 45,
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Global.colorBlue,
            ),
          ),
          Align(
            alignment: Alignment(0, -0.9),
            child: GestureDetector(
              onTap: () {
                onMenuTapped();
              },
              child: Container(
                width: 35.0,
                height: 110.0,
                color: Global.colorBlue,
                alignment: Alignment.centerLeft,
                child: AnimatedIcon(
                  progress: _animationController.view,
                  icon: AnimatedIcons.menu_close,
                  color: Global.colorAccent,
                  size: 25,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
