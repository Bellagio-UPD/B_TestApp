import 'package:bellagio_mobile_user/data/models/request_model/sub_models/hotel_reservation_model.dart';

import '../../../data/models/request_model/sub_models/deposit_details_model.dart';

abstract class DetailsEntity {
  const DetailsEntity();

  factory DetailsEntity.fromJson(Map<String, dynamic> json) {
    // Here, you could check for requestType in the JSON and
    // instantiate the appropriate subclass based on the requestType.
    final requestType = json['requestType'];

    switch (requestType) {
      case 'HotelReservation':
        return HotelReservations.fromJson(json);
      case 'Deposit':
        return DepositDetails.fromJson(json);
      // case 'TransportRequest':
      //   return TransportRequestDetails.fromJson(json);
      // case 'AirTicketBooking':
      //   return AirTicketBookingDetails.fromJson(json);
      default:
        throw UnsupportedError('Unsupported request type: $requestType');
    }
  }

  Map<String, dynamic> toJson();
}
