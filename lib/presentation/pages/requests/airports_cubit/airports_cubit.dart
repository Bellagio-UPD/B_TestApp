import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/storage/data_state.dart';
import '../../../../data/models/airports_model/airports_model.dart';
import '../../../../domain/usecases/airports_usecase/get_airports_usecase.dart';

part 'airports_state.dart';

class AirportsCubit extends Cubit<AirportsState> {
  final GetAirportsUsecase? getAirportsUsecase;

  AirportsCubit({this.getAirportsUsecase}) : super(AirportInitialState());

  Future<void> getAirports() async {
    try {
      final allAirports = await getAirportsUsecase!.call(params: null);
      if (allAirports is DataSuccess || allAirports.data != null) {
        emit(AirportLoadedState(
            airportsList: allAirports.data, error: allAirports.error));
      } else {
        emit(AirportErrorState(error: allAirports.error));
      }
    } on DioException catch (e) {
      emit(AirportErrorState(error: e));
    }
  }
}
