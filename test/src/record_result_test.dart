import 'package:record_result/record_result.dart';
import 'package:record_result/src/errors/failure.dart';
import 'package:test/test.dart';

void main() {
  group('right function', () {
    test('creates a successful result with the specified parameter', () {
      // Arrange
      const value = 42;

      // Act
      final result = right(value);

      // Assert
      expect(result.isSuccess, isTrue);
      expect(result.success, equals(value));
      expect(result.failure, isNull);
    });
  });

  group('left function', () {
    test('creates an unsuccessful result with the specified failure', () {
      // Arrange
      final failure =
          ApiFailure(message: 'Something went wrong', statusCode: 500);

      // Act
      final result = left<String>(failure);

      // Assert
      expect(result.isFailure, isTrue);
      expect(result.success, isNull);
      expect(result.failure, equals(failure));
    });
  });
  group('result Fold', () {
    group('fold', () {
      test(
        '''Given a [Result] with a valid success and null failure ifSuccess callback should be called''',
        () {
          // Arrange
          const Result<int> result = (success: 1, failure: null);
          var ifSuccessCalled = false;

          // Act
          result.fold(
            (success) => ifSuccessCalled = true,
            (failure) => null,
          );

          // Assert
          expect(ifSuccessCalled, true);
        },
      );

      test(
        '''Given a [Result] with a null success and a valid failure ifFailure callback should be called''',
        () {
          // Arrange
          final Result<int> result = (
            success: null,
            failure:
                ApiFailure(message: 'Albinson was here', statusCode: '2002')
          );
          var ifFailureCalled = false;

          // Act
          result.fold(
            (success) => null,
            (failure) => ifFailureCalled = true,
          );

          // Assert
          expect(ifFailureCalled, true);
        },
      );

      test(
        '''Given a [Result] with a null success and a null failure should call success callback''',
        () {
          // Arrange
          const ResultVoid result = (success: null, failure: null);
          var ifSuccessCalled = false;
          var ifFailureCalled = false;

          // Act
          result.fold(
            (success) => ifSuccessCalled = true,
            (failure) => ifFailureCalled = true,
          );

          // Assert
          expect(ifSuccessCalled, true);
          expect(ifFailureCalled, false);
        },
      );

      test(
        '''Given a [ResultVoid] with a void success and null failure ifSuccess callback should be called''',
        () {
          // Arrange
          const ResultVoid result = (success: null, failure: null);
          var ifSuccessCalled = false;
          var ifFailureCalled = false;

          // Act
          result.fold(
            (success) => ifSuccessCalled = true,
            (failure) => ifFailureCalled = true,
          );

          // Assert
          expect(ifSuccessCalled, true);
          expect(ifFailureCalled, false);
        },
      );

      test(
        'Given a [ResultVoid] with a void success and a failure ifSuccess '
        'callback should not be called and ifFailure callback should be called',
        () {
          // Arrange
          final failure =
              ApiFailure(message: 'Albinson was here', statusCode: '2002');
          final ResultVoid result = (success: null, failure: failure);
          var ifSuccessCalled = false;
          var ifFailureCalled = false;

          // Act
          result.fold(
            (success) => ifSuccessCalled = true,
            (failure) => ifFailureCalled = true,
          );

          // Assert
          expect(ifSuccessCalled, false);
          expect(ifFailureCalled, true);
        },
      );
    });

    group('isSuccess', () {
      test(
        'Given a [Result] with a failure value should return false',
        () {
          // Arrange
          final Result<int> result = (
            success: null,
            failure:
                ApiFailure(message: 'Albinson was here', statusCode: '2002')
          );

          // Act
          final resultIsSuccess = result.isSuccess;

          // Assert
          expect(resultIsSuccess, false);
        },
      );
      test(
        'Given a [Result] with a null failure value should return true',
        () {
          // Arrange
          const Result<int> result = (success: 1, failure: null);

          // Act
          final resultIsSuccess = result.isSuccess;

          // Assert
          expect(resultIsSuccess, true);
        },
      );

      test(
        'Given a [Result] with both null and success values should return true',
        () {
          // Arrange
          const ResultVoid result = (success: null, failure: null);

          // Act
          final resultIsSuccess = result.isSuccess;

          // Assert
          expect(resultIsSuccess, true);
        },
      );
    });
    group('isFailure', () {
      test(
        'Given a [Result] with a null failure value should return false',
        () {
          // Arrange
          const Result<int> result = (success: 1, failure: null);

          // Act
          final resultIsFailure = result.isFailure;

          // Assert
          expect(resultIsFailure, false);
        },
      );
      test(
        'Given a [Result] with a exception value should return true',
        () {
          // Arrange
          final Result<int> result = (
            success: null,
            failure:
                ApiFailure(message: 'Albinson was here', statusCode: '2002')
          );

          // Act
          final resultIsFailure = result.isFailure;

          // Assert
          expect(resultIsFailure, true);
        },
      );

      test(
        'Given a [Result] with both null and success value should return false',
        () {
          // Arrange
          const ResultVoid result = (success: null, failure: null);

          // Act
          final resultIsFailure = result.isFailure;

          // Assert
          expect(resultIsFailure, false);
        },
      );
    });

    group('ifSuccess', () {
      test(
        '''Given a [Result] with a failure value ifSuccess callback should not be called''',
        () {
          // Arrange
          final Result<int> result = (
            success: null,
            failure:
                ApiFailure(message: 'Albinson was here', statusCode: '2002')
          );

          // Act
          var ifSuccessCalled = false;
          result.ifSuccess((_) => ifSuccessCalled = true);

          // Assert
          expect(ifSuccessCalled, false);
        },
      );
      test(
        '''Given a [Result] with a null failure value ifSuccess callback should be called''',
        () {
          // Arrange
          const Result<int> result = (success: 1, failure: null);

          // Act
          var ifSuccessCalled = false;
          result.ifSuccess((_) => ifSuccessCalled = true);

          // Assert
          expect(ifSuccessCalled, true);
        },
      );

      test(
        'Given a [Result] with both success and failure null values '
        'ifSuccess callback should be called',
        () {
          // Arrange
          const ResultVoid result = (success: null, failure: null);

          // Act
          var ifSuccessCalled = false;
          result.ifSuccess((_) => ifSuccessCalled = true);

          // Assert
          expect(ifSuccessCalled, true);
        },
      );
    });
    group('ifFailure', () {
      test(
        '''Given a [Result] with a null failure value ifFailure callback should not be called''',
        () {
          // Arrange
          const Result<int> result = (success: 1, failure: null);

          // Act
          var ifFailureCalled = false;
          result.ifFailure((_) => ifFailureCalled = true);

          // Assert
          expect(ifFailureCalled, false);
        },
      );
      test(
        '''Given a [Result] with a valid failure value ifFailure callback should be called''',
        () {
          // Arrange
          final Result<int> result = (
            success: null,
            failure:
                ApiFailure(message: 'Albinson was here', statusCode: '2002')
          );

          // Act
          var ifFailureCalled = false;
          result.ifFailure((_) => ifFailureCalled = true);

          // Assert
          expect(ifFailureCalled, true);
        },
      );

      test(
        'Given a [Result] with both success and failure null values '
        'ifFailure callback should not be called',
        () {
          // Arrange
          const ResultVoid result = (success: null, failure: null);

          // Act
          var ifFailureCalled = false;
          result.ifFailure((_) => ifFailureCalled = true);

          // Assert
          expect(ifFailureCalled, false);
        },
      );
    });
  });
}
