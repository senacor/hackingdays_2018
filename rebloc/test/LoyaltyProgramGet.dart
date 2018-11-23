import 'package:better_yunar/models/loyaltyProgram.dart';
import 'package:better_yunar/screens/addCardScreen.dart';
import 'package:test_api/test_api.dart';

void main() {
  test("String.split() splits the string on the delimiter", () async {
    List<LoyaltyProgram> l = await AddCardScreen.loadPrograms();
    expect(l, 'sss');
  });
}
