import '../../../core/constants/image_paths.dart';

extension AirlinesImageExtension on String {
  String get airlineImage {
    switch (this) {
      case "Aeroflot":
        return Airlines.aeroflot;
      case "Air Arabia":
        return Airlines.air_arabia;
      case "Air China":
        return Airlines.air_china;
      case "Air India":
        return Airlines.air_india;
      case "AirAsia":
        return Airlines.air_asia;
      case "Cathay Pacific":
        return Airlines.cathay_pacific;
      case "China Eastern":
        return Airlines.china_eastern;
      case "Emirates":
        return Airlines.emirates;
      case "Etihad Airways":
        return Airlines.etihad;
      case "Fly Dubai":
        return Airlines.fly_dubai;
      case "Gulf Air":
        return Airlines.gulf_air;
      case "Indigo":
        return Airlines.indigo;
      case "Jazeera Airways":
        return Airlines.jazeera_airways;
      case "Lion Air":
        return Airlines.lion_air;
      case "Malaysia Airlines":
        return Airlines.malaysia_airlines;
      case "Malindo":
        return Airlines.malindo;
      case "Oman Air":
        return Airlines.oman_air;
      case "Qatar Airways":
        return Airlines.qatar_airways;
      case "Salam Air":
        return Airlines.salam_air;
      case "Singapore Airlines":
        return Airlines.singapore_airlines;
      case "SpiceJet":
        return Airlines.spiceJet;
      case "SriLankan":
        return Airlines.srilankan;
      default:
        return Airlines.srilankan; 
    }
  }
}
