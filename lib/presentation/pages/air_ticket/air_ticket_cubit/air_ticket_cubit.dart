import 'package:bellagio_mobile_user/core/storage/data_state.dart';
import 'package:bellagio_mobile_user/domain/usecases/air_tickets_ucecase/get_air_tickets_usecase.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/models/air_tickets_model/air_tickets_model.dart';

part 'air_ticket_state.dart';

class AirTicketsCubit extends Cubit<AirTicketsState> {
  final GetAirTicketsUsecase? getAirTicketsUsecase;

  AirTicketsCubit({this.getAirTicketsUsecase}) : super(AirTicketInitialState());

  Future<void> getAirTickets() async {
    try {
      final allAirTickets = await getAirTicketsUsecase!.call(params: null);
      if (allAirTickets is DataSuccess || allAirTickets.data != null) {
        emit(AirTicketLoadedState(
            airTicketInfoList: allAirTickets.data, error: allAirTickets.error));
      } else {
        if (allAirTickets.data == null || allAirTickets.data!.isEmpty) {
          emit(AirTicketLoadedState(
              airTicketInfoList: allAirTickets.data,
              error: allAirTickets.error));
        } else {
          emit(AirTicketErrorState(error: allAirTickets.error));
        }
      }
    } on DioException catch (e) {
      emit(AirTicketErrorState(error: e));
    }
  }
}
