import 'package:dartz/dartz.dart';
import 'package:sales_app/core/error/failure.dart';

abstract class UseCase<ResModel, ReqParams> {
  Future<Either<Failure, ResModel>> call(ReqParams params);
}
