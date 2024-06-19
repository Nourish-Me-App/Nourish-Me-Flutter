import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bot_nav_bar_state.dart';

class BotNavBarCubit extends Cubit<BotNavBarState> {
  BotNavBarCubit() : super(BotNavBarInitial());

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(IndexChanged());
  }

  void resetIndex() {
    currentIndex = 0;
    emit(IndexChanged());
  }
}
