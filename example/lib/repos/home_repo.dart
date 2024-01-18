import 'dart:math';

import 'package:record_result/record_result.dart';

class HomeRepo {
  /// This function waits 300 milliseconds and then
  /// randomly returns a success or a failure
  FutureResult<int> getNumber() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));

    if (Random().nextBool()) {
      final number = Random().nextInt(64);
      return right(number);
    } else {
      return left(
        CacheFailure(message: "Couldn't get number", statusCode: 400),
      );
    }
  }
}
