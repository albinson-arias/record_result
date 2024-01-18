part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  const HomeLoaded({required this.loadedNumber});

  final int loadedNumber;
  @override
  List<Object> get props => [loadedNumber];
}

final class HomeError extends HomeState {
  const HomeError({required this.errorMessage});

  final String errorMessage;
  @override
  List<Object> get props => [errorMessage];
}
