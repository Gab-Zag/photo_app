import 'package:flutter_bloc/flutter_bloc.dart';
import 'couter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState());

  void addCounter(int n) {
    int counter = state.counter ?? 0;
    int inputUser;
    inputUser = counter + n;
    emit(state.copyWith(counter: inputUser));
  }
}