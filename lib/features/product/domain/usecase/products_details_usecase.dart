import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/product/data/models/product_details_request.dart';
import 'package:sales_app/features/product/data/models/product_details_response.dart';
import 'package:sales_app/features/product/domain/repo/product_repo.dart';

class ProductsDetailsUsecase
    extends UseCase<ProductDetailsResponse, ProductDetailsRequest> {
  final ProductRepo repo;

  ProductsDetailsUsecase(this.repo);

  @override
  Future<Either<Failure, ProductDetailsResponse>> call(
      ProductDetailsRequest params) {
    return repo.getProductDetails(params);
  }
}
