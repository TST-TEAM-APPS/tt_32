import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pp_731/UI/create_event.dart';
import 'package:pp_731/UI/home_screen.dart';
import 'package:pp_731/Widgets/bottom_navigation_bar.dart';
import 'package:pp_731/style.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  List<Map<String, String>> onboardingData = [
    {
      "image": "Assets/Icons/onboarding1.png",
      "title": "Start organising your\nevents with ",
      "description": "Record the date, time and place and\nkeep track of them"
    },
    {
      "image": "Assets/Icons/onboarding2.png",
      "title": "Create event lists and\nkeep track details",
      "description": "Make a schedule that is convenient\nfor you"
    },
    {
      "image": "Assets/Icons/onboarding3.png",
      "title": "Create your first\nevent",
      "description": "Start your planning now"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 100,
                          bottom: 50,
                        ),
                        child: Image.asset(onboardingData[index]["image"]!),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                onboardingData[index]["title"]!,
                                style: Style.textStyle.copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                onboardingData[index]["description"]!,
                                style: Style.textStyle.copyWith(
                                  fontSize: 16,
                                  color: Color.fromRGBO(52, 52, 52, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Check if we are on the last page
                if (_currentPage == onboardingData.length - 1) ...[
                  // Render a single large button for the last page
                  Expanded(
                    child: CupertinoButton(
                      padding: EdgeInsets.all(30),
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => CreateEvent()),
                        );
                      },
                      child: Container(
                        width: 225,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            "Create Task",
                            style: Style.textStyle.copyWith(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ] else ...[
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => CreateEvent()),
                      );
                    },
                    child: Text(
                      "Skip",
                      style: Style.textStyle.copyWith(
                        color: Color.fromRGBO(52, 52, 52, 1),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
                    child: Row(
                      children: List.generate(onboardingData.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? Colors.black
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        );
                      }),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Container(
                      width: 80,
                      height: 34,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.black,
                      ),
                      child: Center(
                        child: Text(
                          "Next",
                          style: Style.textStyle.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

        ],
      ),
    );
  }
}
