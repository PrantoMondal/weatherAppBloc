part of 'switch_cubit.dart';

@immutable
class SwitchState {
  final bool isBtnOn;

  const SwitchState({required this.isBtnOn});

  SwitchState copyWith({bool? isDarkThemeOn}) {
    return SwitchState(
      isBtnOn: isDarkThemeOn ?? this.isBtnOn,
    );
  }
}
