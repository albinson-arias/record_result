import 'package:record_result/src/errors/failure.dart';
import 'package:test/test.dart';

void main() {
  group('ApiFailure constructor', () {
    test('constructor should return correct instance', () {
      // Arrange
      const message = 'Albinson was here';
      const code = '1106';

      // Act
      final result = ApiFailure(message: message, statusCode: code);

      // Assert
      expect(result.message, message);
      expect(result.statusCode, code);
    });

    test(
      'constructor should throw '
      'if statusCode is given something other than an int or a String',
      () {
        // Assert
        expect(
          () =>
              ApiFailure(message: 'Hola', statusCode: const {'error': 'Holas'}),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });
  group('CacheFailure constructor', () {
    test('constructor should return correct instance', () {
      // Arrange
      const message = 'Albinson was here';
      const code = '1106';

      // Act
      final result = CacheFailure(message: message, statusCode: code);

      // Assert
      expect(result.message, message);
      expect(result.statusCode, code);
    });

    test(
      'constructor should throw '
      'if statusCode is given something other than an int or a String',
      () {
        // Assert
        expect(
          () => CacheFailure(
            message: 'Hola',
            statusCode: const {'error': 'Holas'},
          ),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });
  group('ServerFailure constructor', () {
    test('constructor should return correct instance', () {
      // Arrange
      const message = 'Albinson was here';
      const code = '1106';

      // Act
      final result = ServerFailure(message: message, statusCode: code);

      // Assert
      expect(result.message, message);
      expect(result.statusCode, code);
    });

    test(
      'constructor should throw '
      'if statusCode is given something other than an int or a String',
      () {
        // Assert
        expect(
          () => ServerFailure(
            message: 'Hola',
            statusCode: const {'error': 'Holas'},
          ),
          throwsA(isA<AssertionError>()),
        );
      },
    );
  });

  test('Props should return correct list of objects', () {
    // Arrange
    const message = 'Albinson was here';
    const code = '1106';

    // Act
    final result = ApiFailure(message: message, statusCode: code);

    // Assert
    expect(result.props, [message, code]);
  });

  test(
      'errorMessage should return correct '
      'ƒormat when statusCode is a String', () {
    // Arrange
    const message = 'Albinson was here';
    const code = 'Hola';

    // Act
    final result = ApiFailure(message: message, statusCode: code);

    // Assert
    expect(result.errorMessage, 'Hola: Albinson was here');
  });
  test(
      'errorMessage should return correct '
      'ƒormat when statusCode is a int', () {
    // Arrange
    const message = 'Albinson was here';
    const code = 1106;

    // Act
    final result = ApiFailure(message: message, statusCode: code);

    // Assert
    expect(result.errorMessage, '1106 Error: Albinson was here');
  });
}
