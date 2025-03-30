import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/tournaments_usecase/get_tournaments_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/tournaments_model/tournaments_model.dart';

part 'tournaments_state.dart';

class TournamentsCubit extends Cubit<TournamentsState> {
  final GetTournamentsUsecase? getTournamentsUsecase;

  TournamentsCubit({this.getTournamentsUsecase})
      : super(TournamentsInitialState());

  Future<void> getTournaments() async {
    try {
      final allTournaments = await getTournamentsUsecase!.call(params: null);
      if (allTournaments is DataSuccess || allTournaments.data != null) {
        emit(TournamentsLoadedState(
            tournamentList: allTournaments.data, error: allTournaments.error));
      } else {
        if (allTournaments.data == null || allTournaments.data!.isEmpty) {
          emit(TournamentsLoadedState(
              tournamentList: allTournaments.data,
              error: allTournaments.error));
        } else {
          emit(TournamentsErrorState(error: allTournaments.error));
        }
      }
    } on DioException catch (e) {
      emit(TournamentsErrorState(error: e));
    }
  }
}
