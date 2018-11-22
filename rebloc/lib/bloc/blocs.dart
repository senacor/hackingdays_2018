import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/bloc/onboarding.dart' as onboarding;
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart' as loyaltyCard;

List<Bloc<AppState>> createBlocs() {
  var blocs = new List<Bloc<AppState>>();
  onboarding.blocs.forEach((element) => blocs.add(element));
  loyaltyCard.blocs.forEach((element) => blocs.add(element));
  return blocs;
}