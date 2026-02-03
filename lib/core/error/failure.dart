import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String errorMessage;
  final int statusCode;
  final bool isUnauthorizedUser;
  final bool? isNoInternet;

  const Failure({
    required this.errorMessage,
    required this.statusCode,
    required this.isUnauthorizedUser,
    this.isNoInternet,
  });
}

class ServerFailure extends Failure {
  final String? statusMessage;
  final String? errorFailMessage;
  final int? statusFailCode;
  final bool? isUnauthorized;
  final bool? isNoInternetConnection;

  const ServerFailure({
    required this.statusMessage,
    required this.statusFailCode,
    required this.errorFailMessage,
    this.isUnauthorized,
    this.isNoInternetConnection,
  }) : super(
          errorMessage: errorFailMessage ?? "",
          statusCode: statusFailCode ?? 200,
          isUnauthorizedUser: isUnauthorized ?? false,
          isNoInternet: isNoInternetConnection ?? false,
        );

  @override
  List<Object?> get props => [
        statusMessage,
        statusCode,
        errorMessage,
        isUnauthorizedUser,
        isNoInternet,
      ];

  @override
  String toString() {
    return '$statusCode $statusMessage $errorMessage';
  }
}

class AppFailure extends Failure {
  final int statusCodes;
  final String errorMessages;
  final bool? isUnauthorized;
  final bool? isNoInternetConnection;

  const AppFailure({
    required this.statusCodes,
    required this.errorMessages,
    this.isUnauthorized,
    this.isNoInternetConnection,
  }) : super(
          errorMessage: errorMessages,
          statusCode: statusCodes,
          isUnauthorizedUser: isUnauthorized ?? false,
          isNoInternet: isNoInternetConnection ?? false,
        );

  @override
  List<Object?> get props => [
        statusCode,
        errorMessage,
        isUnauthorizedUser,
        isNoInternet,
      ];

  @override
  String toString() {
    return '$statusCode $errorMessage';
  }
}
