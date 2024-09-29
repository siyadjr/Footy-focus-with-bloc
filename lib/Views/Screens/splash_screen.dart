// splash_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:footy_focus/Controllers/splash_cubit.dart';
import 'package:footy_focus/Controllers/splash_state.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: BlocConsumer<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashLoaded) {
             
              Navigator.of(context).pushReplacementNamed('/home');
            }
          },
          builder: (context, state) {
            return  Center(
              child: Image.asset('lib/Assets/Logo footy focus.png')
            );
          },
        ),
      ),
    );
  }
}
