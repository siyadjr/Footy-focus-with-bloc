import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/TeamsBloc/teams_bloc_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/legueBloc/league_for_players_bloc.dart';
import 'package:footy_focus/Views/Screens/screen_home.dart';
import 'package:footy_focus/Views/Screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Initialize LeagueForPlayersBloc and trigger loading leagues
        BlocProvider(
          create: (context) => LeagueForPlayersBloc()..add(LoadLeagues()),
        ),
        // Add other blocs here as needed
        BlocProvider(
          create: (context) => TeamsBlocBloc(), // Replace with your actual bloc
        ),
      ],
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
