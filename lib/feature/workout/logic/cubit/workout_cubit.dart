import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nourish_me/core/helpers/app_constants.dart';
import 'package:nourish_me/core/helpers/cache_helper.dart';
import 'package:nourish_me/feature/workout/data/model/workout_model.dart';
import 'package:nourish_me/feature/workout/data/repo/workout_repo.dart';

part 'workout_state.dart';

class WorkoutCubit extends Cubit<WorkoutState> {
  WorkoutCubit(this.workoutRepo) : super(WorkoutInitial());

  late WorkoutRepo workoutRepo;
  Future<void> fetchWorkout(String path) async {
    emit(WorkoutLoadingState());
    var result = await workoutRepo.fetchWorkout(
        path, (await CacheHelper().getSecuredData(key: AppConstants.token))!);
    result.fold(
      (error) => emit(WorkoutFailureState(error)),
      (workoutModel) {
        emit(WorkoutSuccessState(workoutModel));
      },
    );
  }
}
