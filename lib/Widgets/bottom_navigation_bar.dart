import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pp_731/UI/home_screen.dart';

import '../UI/calendar_screen.dart';
import '../UI/create_event.dart';
import '../UI/settings_screen.dart';

class ChangeBodies extends StatefulWidget {
  const ChangeBodies({super.key});

  @override
  State<ChangeBodies> createState() => _ChangeBodiesState();
}

class _ChangeBodiesState extends State<ChangeBodies>
    with TickerProviderStateMixin {
  TabController? _controller;
  int selectWidget = 0;

  void _onTabTapped(int index) {
    setState(() {
      selectWidget = index;
    });
  }

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: TabBarView(
        controller: _controller,
        children: [
          HomeScreen(),
          CalendarScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            height: 62,
            margin: EdgeInsets.only(
              bottom: 40,
              left: 90,
              right: 20,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Colors.white,
            ),
            child: TabBar(
              padding: EdgeInsets.zero,
              indicator: BoxDecoration(
                color: Colors.transparent,
              ),
              controller: _controller,
              onTap: _onTabTapped,
              tabs: [
                Tab(
                  icon: Container(
                    width: 56,
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        selectWidget == 0
                            ? 'Assets/Icons/Home Black.svg'
                            : 'Assets/Icons/Home (2).svg',
                      ),
                    ),
                  ),
                ),
                Tab(
                  icon: Container(
                    width: 56,
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        selectWidget == 1
                            ? 'Assets/Icons/Calendar black.svg'
                            : 'Assets/Icons/calendarmini.svg',
                      ),
                    ),
                  ),
                ),
                Tab(
                  icon: Container(
                    width: 56,
                    height: 56,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                        selectWidget == 2
                            ? 'Assets/Icons/Setting black.svg'
                            : 'Assets/Icons/Setting.svg',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 40,
            left: 20,
            child: CupertinoButton(
              padding: EdgeInsets.zero,
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color.fromRGBO(240, 134, 122, 1),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 31,
                ),
              ),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateEvent()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
