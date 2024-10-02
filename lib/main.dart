// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/bloc/league_for_players_bloc.dart';
import 'package:footy_focus/Views/Screens/screen_home.dart';
import 'package:footy_focus/Views/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LeagueForPlayersBloc()..add(LoadLeagues()), // Initialize Bloc and trigger loading leagues
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My App',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
