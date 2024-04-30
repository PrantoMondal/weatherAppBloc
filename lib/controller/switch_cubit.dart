import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'switch_state.dart';

class SwitchCubit extends Cubit<SwitchState> {
  SwitchCubit() : super(const SwitchState(isBtnOn: false));

  void toggleSwitch() {
    emit(state.copyWith(isDarkThemeOn: !state.isBtnOn));
  }
}
