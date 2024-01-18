import 'package:equatable/equatable.dart';
import 'package:example/repos/home_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:record_result/record_result.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required HomeRepo homeRepo})
      : _homeRepo = homeRepo,
        super(HomeInitial());

  final HomeRepo _homeRepo;

  Future<void> getNumber() async {
    emit(HomeLoading());

    final result = await _homeRepo.getNumber();

    result.fold(
      (success) => emit(HomeLoaded(loadedNumber: success!)),
      (failure) => emit(HomeError(errorMessage: failure.errorMessage)),
    );
  }
}
