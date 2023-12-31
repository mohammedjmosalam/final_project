part of 'splash_screen_cubit.dart';

class SplashScreenState extends Equatable {
  const SplashScreenState({
    this.navigatorSplash = NavigatorSplash.init,
    this.error = '',
  });
  final NavigatorSplash navigatorSplash;
  final String error;
  SplashScreenState copyWith(
          {NavigatorSplash? navigatorSplash, String? error}) =>
      SplashScreenState(
        navigatorSplash: navigatorSplash ?? this.navigatorSplash,
        error: error ?? this.error,
      );
  @override
  List<Object> get props => [
        navigatorSplash,
        error,
      ];
}
