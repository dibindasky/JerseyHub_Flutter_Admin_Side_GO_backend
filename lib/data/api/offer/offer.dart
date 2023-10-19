import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:jerseyhub_admin/domain/core/api_endpoints/api_endpoints.dart';
import 'package:jerseyhub_admin/domain/core/failure/failures.dart';
import 'package:jerseyhub_admin/domain/models/offer/add_offer_model/add_offer_model.dart';
import 'package:jerseyhub_admin/domain/models/offer/delete_offer_qurrey/delete_offer_qurrey.dart';
import 'package:jerseyhub_admin/domain/models/offer/get_offer_response_model/get_offer_response_model.dart';
import 'package:jerseyhub_admin/domain/models/offer/offer_response_model/offer_response_model.dart';
import 'package:jerseyhub_admin/domain/models/token/token.dart';
import 'package:jerseyhub_admin/domain/repositories/offer_repository.dart';

class OfferApi implements OfferRepository {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiEndPoints.baseUrl));

  @override
  Future<Either<Failure, OfferResponseModel>> addOffer(
      {required AddOfferModel addCouponModel,
      required TokenModel tokenModel}) async {
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['AccessToken'] = tokenModel.accessToken;
      _dio.options.headers['RefreshToken'] = tokenModel.refreshToken;
      final response = await _dio.post(ApiEndPoints.offer);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(OfferResponseModel.fromJson(response.data));
      } else if (response.statusCode == 500) {
        return Left(Failure.serverFailure());
      } else {
        return Left(Failure.clientFailure());
      }
    } catch (e) {
      return Left(Failure.clientFailure());
    }
  }

  @override
  Future<Either<Failure, OfferResponseModel>> deleteOffer(
      {required TokenModel tokenModel,
      required DeleteOfferQurrey deleteCoupenQurrey}) async {
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['AccessToken'] = tokenModel.accessToken;
      _dio.options.headers['RefreshToken'] = tokenModel.refreshToken;
      final response = await _dio.delete(ApiEndPoints.offer,
          queryParameters: deleteCoupenQurrey.toJson());
      if (response.statusCode == 200) {
        return Right(OfferResponseModel.fromJson(response.data));
      } else if (response.statusCode == 500) {
        return Left(Failure.serverFailure());
      } else {
        return Left(Failure.clientFailure());
      }
    } catch (e) {
      return Left(Failure.clientFailure());
    }
  }

  @override
  Future<Either<Failure, GetOfferResponseModel>> getOffer(
      {required TokenModel tokenModel}) async {
    try {
      _dio.options.headers['content-Type'] = 'application/json';
      _dio.options.headers['AccessToken'] = tokenModel.accessToken;
      _dio.options.headers['RefreshToken'] = tokenModel.refreshToken;
      final response = await _dio.get(ApiEndPoints.offer);
      if (response.statusCode == 200) {
        return Right(GetOfferResponseModel.fromJson(response.data));
      } else if (response.statusCode == 500) {
        return Left(Failure.serverFailure());
      } else {
        return Left(Failure.clientFailure());
      }
    } catch (e) {
      return Left(Failure.clientFailure());
    }
  }
}
