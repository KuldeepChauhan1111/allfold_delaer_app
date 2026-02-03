import 'package:dartz/dartz.dart';
import 'package:sales_app/core/domain/usecases/usecase.dart';
import 'package:sales_app/core/error/failure.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_request.dart';
import 'package:sales_app/features/product/data/models/get_product_by_categories_response.dart';
import 'package:sales_app/features/product/domain/repo/product_repo.dart';

class GetProductsByCategoriesUseCase extends UseCase<
    GetProductByCategoriesResponse, GetProductByCategoriesRequest> {
  final ProductRepo repo;

  GetProductsByCategoriesUseCase(this.repo);

  @override
  Future<Either<Failure, GetProductByCategoriesResponse>> call(
      GetProductByCategoriesRequest params) {
    return repo.getProductByCategory(params);
  }
}
