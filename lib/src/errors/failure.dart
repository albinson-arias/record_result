import 'package:equatable/equatable.dart';

/// An abstract class representing a failure in the application.
/// Extend this class to create specific failure types
/// with custom messages and status codes.
abstract class Failure extends Equatable {
  /// Creates a new instance of [Failure] with the
  /// specified [message] and [statusCode].
  /// Throws an [AssertionError] if the [statusCode] is not a [String] or [int].
  Failure({required this.message, required this.statusCode})
      : assert(
          statusCode is String || statusCode is int,
          'StatusCode cannot be a ${statusCode.runtimeType}',
        );

  /// The error message associated with the failure.
  final String message;

  /// The status code associated with the failure.
  final dynamic statusCode;

  /// A formatted error message that includes the status code
  /// and the original message.
  String get errorMessage =>
      '$statusCode${statusCode is String ? '' : ' Error'}: $message';

  @override
  List<dynamic> get props => [message, statusCode];
}

/// A [Failure] extension meant to be used for API errors.
///
/// The [ApiFailure] class extends the [Failure] class and
/// is designed to handle errors specific to API-related operations.
/// It includes information about the error [message]
/// and [statusCode].
///
/// Example:
/// ```dart
/// final apiFailure = ApiFailure(
///   message: 'Invalid API response',
///   statusCode: 404
/// );
/// ```
class ApiFailure extends Failure {
  /// Creates a new instance of [ApiFailure] with the
  /// specified [message] and [statusCode].
  ApiFailure({required super.message, required super.statusCode});
}

/// A [Failure] extension meant to be used for Cache errors.
///
/// The [CacheFailure] class extends the [Failure] class
/// and is designed to handle errors specific to caching operations.
/// It includes information about the error [message]
/// and [statusCode].
///
/// Example:
/// ```dart
/// final cacheFailure = CacheFailure(
///   message: 'Cache read error',
///   statusCode: 'CACHE_ERROR'
/// );
/// ```
class CacheFailure extends Failure {
  /// Creates a new instance of [CacheFailure] with the
  /// specified [message] and [statusCode].
  CacheFailure({required super.message, required super.statusCode});
}

/// A [Failure] extension meant to be used for Server errors.
///
/// The [ServerFailure] class extends the [Failure] class
/// and is designed to handle errors specific to server-related operations.
/// It includes information about the error [message]
/// and [statusCode].
///
/// Example:
/// ```dart
/// final serverFailure = ServerFailure(
///   message: 'Server connection failed',
///   statusCode: 500
/// );
/// ```
class ServerFailure extends Failure {
  /// Creates a new instance of [ServerFailure] with the
  /// specified [message] and [statusCode].
  ServerFailure({required super.message, required super.statusCode});
}
