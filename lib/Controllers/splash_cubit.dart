// splash_cubit.dart

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial()) {
    _loadSplash();
  }

  Future<void> _loadSplash() async {
    await Future.delayed(const Duration(seconds: 3));
    emit(SplashLoaded()); 
  }
}
