import 'package:record_result/src/errors/failure.dart';

/// A [Result] is a type that represents either a success or a [Failure].
///
/// The [Result] type is often used in functional programming
/// to handle the outcomes of operations. It can either contain
/// a successful value (success) or
/// an unsuccessful value represented by a [Failure].
///
/// Example:
/// ```dart
/// Result<int> result = right(42);
/// if (result.isSuccess) {
///   print('Operation succeeded with result: ${result.success}');
/// } else {
///   print('Operation failed with error: ${result.failure!.errorMessage}');
/// }
/// ```
typedef Result<T> = ({T? success, Failure? failure});

/// A [FutureResult] is a type that represents a [Future] of a [Result].
///
/// It is a convenient way to work with asynchronous operations that may produce
/// either a successful result or a failure.
///
/// Example:
/// ```dart
/// FutureResult<int> futureResult = fetchSomeData();
/// futureResult.then((result) {
///   if (result.isSuccess) {
///     print('Operation succeeded with result: ${result.success}');
///   } else {
///     print('Operation failed with error: ${result.failure!.errorMessage}');
///   }
/// });
/// ```
typedef FutureResult<T> = Future<Result<T>>;

/// A [StreamResult] is a type that represents a [Stream] of a [Result].
///
/// It is useful for handling asynchronous streams of results,
/// where each element can be either a success or a failure.
///
/// Example:
/// ```dart
/// StreamResult<int> streamResult = fetchDataAsStream();
/// await for (Result<int> result in streamResult) {
///   if (result.isSuccess) {
///     print('Received successful result: ${result.success}');
///   } else {
///     print('Received failure: ${result.failure!.errorMessage}');
///   }
/// }
/// ```
typedef StreamResult<T> = Stream<Result<T>>;

/// A [ResultVoid] is a type that represents either a void success
/// or a [Failure].
///
/// This type is useful when the operation doesn't produce a specific value,
/// and success is indicated by the absence of a failure.
///
/// Example:
/// ```dart
/// ResultVoid result = voidSuccess;
/// if (result.isSuccess) {
///   print('Operation succeeded!');
/// } else {
///   print('Operation failed with error: ${result.failure!.errorMessage}');
/// }
/// ```
typedef ResultVoid = Result<void>;

/// A [FutureResultVoid] is a type that represents a [Future] of a [ResultVoid].
///
/// It is used for asynchronous operations that don't produce a specific value,
/// and success is indicated by the absence of a failure.
///
/// Example:
/// ```dart
/// FutureResultVoid futureResult = performAsyncOperation();
/// futureResult.then((result) {
///   if (result.isSuccess) {
///     print('Operation succeeded!');
///   } else {
///     print('Operation failed with error: ${result.failure!.errorMessage}');
///   }
/// });
/// ```
typedef FutureResultVoid = Future<ResultVoid>;

/// A [StreamResultVoid] is a type that represents a [Stream] of a [ResultVoid].
///
/// It is used for handling asynchronous streams of results where each element
/// can be either a void success or a [Failure].
///
/// Example:
/// ```dart
/// StreamResultVoid streamResultVoid = fetchDataAsStream();
/// await for (ResultVoid result in streamResultVoid) {
///   if (result.isSuccess) {
///     print('Received successful result!');
///   } else {
///     print('Received failure: ${result.failure!.errorMessage}');
///   }
/// }
/// ```
typedef StreamResultVoid = Stream<ResultVoid>;

/// A static [Result] that is void.
///
/// This is a convenient constant representing a void
/// success in the [Result] type.
/// It can be used when an operation doesn't produce a specific value,
///  and success is indicated by the absence of a failure.
///
/// Example:
/// ```dart
/// ResultVoid result = voidSuccess;
/// if (result.isSuccess) {
///   print('Operation succeeded!');
/// } else {
///   print('Operation failed with error: ${result.failure!.errorMessage}');
/// }
/// ```
const voidSuccess = (success: null, failure: null);

/// Creates a successful result with the specified [param].
///
/// Example:
/// ```dart
/// Result<int> result = right(42);
/// ```
Result<T> right<T>(T param) => (success: param, failure: null);

/// Creates an unsuccessful result with the specified [param].
///
/// Example:
/// ```dart
/// Failure failure = Failure(message: 'Something went wrong', statusCode: 500);
/// Result<String> result = left(failure);
/// ```
Result<T> left<T>(Failure param) => (success: null, failure: param);

/// An extension on the [Result] class to provide additional utility methods
/// for handling success and failure scenarios.
extension Fold<T> on Result<T> {
  /// Takes two functions as arguments. The first function is called if the
  /// [Result] is a success or both the success and failure are null,
  /// the second function is called if the [Result] is a
  /// failure.
  ///
  /// Returns the value returned by the function that was called.
  ///
  /// Example:
  /// ```dart
  /// Result<int> result = right(42);
  /// String output = result.fold(
  ///   (success) => 'Success: $success',
  ///   (failure) => 'Failure: ${failure.errorMessage}',
  /// );
  /// print(output); // Output: Success: 42
  /// ```
  B fold<B>(
    B Function(T? success) ifSuccess,
    B Function(Failure failure) ifFailure,
  ) {
    if (success != null) {
      return ifSuccess(success as T);
    } else if (failure != null) {
      return ifFailure(failure!);
    } else {
      return ifSuccess(null);
    }
  }

  /// Returns true if the [Failure] is null, false otherwise.
  ///
  /// Example:
  /// ```dart
  /// Result<int> successResult = right(42);
  /// print(successResult.isSuccess); // Output: true
  ///
  /// Result<int> failureResult = left(
  ///   Failure(message: 'Error', statusCode: 500)
  /// );
  /// print(failureResult.isSuccess); // Output: false
  /// ```
  bool get isSuccess => failure == null;

  /// Returns true if the [Result] is a failure, false otherwise.
  ///
  /// Example:
  /// ```dart
  /// Result<int> successResult = right(42);
  /// print(successResult.isFailure); // Output: false
  ///
  /// Result<int> failureResult = left(
  ///   Failure(message: 'Error', statusCode: 500)
  /// );
  /// print(failureResult.isFailure); // Output: true
  /// ```
  bool get isFailure => failure != null;

  /// Takes a function as an argument. The function is called if the [Result] is
  /// a success.
  ///
  /// Example:
  /// ```dart
  /// Result<int> successResult = right(42);
  /// successResult.ifSuccess((success) {
  ///   print('Operation succeeded with result: $success');
  /// }); // Output: Operation succeeded with result: 42
  /// ```
  void ifSuccess(void Function(T? success) ifSuccess) {
    if (isSuccess) {
      ifSuccess(success);
    }
  }

  /// Takes a function as an argument. The function is called if the [Result] is
  /// a failure.
  ///
  /// Example:
  /// ```dart
  /// Result<int> failureResult = left(
  ///   Failure(message: 'Error', statusCode: 500)
  /// );
  /// failureResult.ifFailure((failure) {
  ///   print('Operation failed with error: ${failure.errorMessage}');
  /// });
  /// ```
  void ifFailure(void Function(Failure failure) ifFailure) {
    if (isFailure) {
      ifFailure(failure!);
    }
  }
}
