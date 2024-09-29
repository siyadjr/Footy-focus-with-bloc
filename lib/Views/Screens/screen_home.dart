import 'package:flutter/material.dart';
import 'package:footy_focus/Views/Widgets/home_screen_widgets.dart';
import 'package:footy_focus/Views/Widgets/quick_access.dart';
import 'package:footy_focus/Views/Widgets/result_container.dart';
import 'package:footy_focus/constant.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackGroundColor, // Soft Sky
      body: SafeArea(
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildAppBar(),
                  buildMainContent(),
                  const QuickAccess(),
                  const ResultContainer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
