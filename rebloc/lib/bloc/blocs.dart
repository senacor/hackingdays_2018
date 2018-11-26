import 'package:rebloc/rebloc.dart';
import 'package:better_yunar/models/app_state.dart';
import 'package:better_yunar/bloc/loayaltyCard_bloc.dart' as loyaltyCard;
import 'package:better_yunar/bloc/achievements_bloc.dart' as achievements;
import 'package:better_yunar/bloc/onboarding.dart' as onboarding;
import 'package:better_yunar/bloc/loyaltyProgram_bloc.dart' as loyaltyProgram;


List<Bloc<AppState>> createBlocs() {
  var blocs = new List<Bloc<AppState>>();
  onboarding.blocs.forEach((element) => blocs.add(element));
  loyaltyCard.blocs.forEach((element) => blocs.add(element));
  achievements.blocs.forEach((element) => blocs.add(element));
  loyaltyProgram.blocs.forEach((element) => blocs.add(element));
  return blocs;
}