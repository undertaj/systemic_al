import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'bloc_state.dart';

class BlocCubit extends Cubit<PageState> {
  BlocCubit() : super(PageInitial());
  late Timer _timer;
  // late List<int> _pages;

  void showResults() {
    emit(PageLoaded([], startedTimer: false));
  }

  void startTimer(List<int> p) {
    _timer = Timer.periodic(Duration(seconds: 2), (_) {
      // if (state is PageLoaded) {
        p.add(1);// Update state.pages.length
        emit(PageLoaded(p,startedTimer: true)); // Emit the updated state
      // }
    });
  }

  // @override
  void cancelTimer() {
    _timer.cancel(); // Cancel the timer when the BlocCubit is closed
    emit(PageInitial());
    // return super.close();
  }
}