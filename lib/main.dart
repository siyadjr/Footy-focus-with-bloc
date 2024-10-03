import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/PlayersBloc/players_bloc_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/TeamsBloc/teams_bloc_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/bloc/league_details_bloc.dart';
import 'package:footy_focus/Controllers/Bloc/legueBloc/league_for_players_bloc.dart';
import 'package:footy_focus/Views/Screens/screen_home.dart';
import 'package:footy_focus/Views/Screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LeagueDetailsBloc()),
        BlocProvider(create: (context) => PlayersBloc()..add(FetchPlayer(1))),
        BlocProvider(
          create: (context) => LeagueForPlayersBloc()..add(LoadLeagues()),
        ),
        BlocProvider(
          create: (context) => TeamsBlocBloc(),
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
