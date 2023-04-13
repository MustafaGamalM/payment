import 'package:payment_app/core/api_services/api_service.dart';
import 'package:payment_app/core/app_constatns.dart';
import 'package:payment_app/core/error_handler.dart';
import 'package:dio/src/response.dart';
import 'package:dartz/dartz.dart';
import 'package:payment_app/features/payment/data/repo/payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  final ApiServices _apiServices = ApiServices();

  @override
  Future<Either<Failure, Response>> getPaymentAuthRequest() async {
    try {
      var res = await _apiServices.post(
          endPoint: ApPConstatns.authEndPoint,
          data: {"api_key": ApPConstatns.apiKey});
      return Right(res);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getOrderRegistrationID(String price) async {
    try {
      var res =
          await _apiServices.post(endPoint: ApPConstatns.orderEndPoint, data: {
        'auth_token': ApPConstatns.authTokenFirst,
        "delivery_needed": "false",
        "amount_cents": price,
        "currency": "EGP",
        "items": [],
      });
      return Right(res);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getPaymentRequest({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    try {
      var res = await _apiServices
          .post(endPoint: ApPConstatns.paymentKeyEndPoint, data: {
        "auth_token": ApPConstatns.authTokenFirst,
        "amount_cents": price,
        "expiration": 3600,
        "order_id": ApPConstatns.orderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ApPConstatns.paymentCardId,
        "lock_order_when_paid": "false"
      });
      return Right(res);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Response>> getRefCode() async {
    try {
      var res = await _apiServices
          .post(endPoint: ApPConstatns.refCodeEndPoint, data: {
        "source": {"identifier": "AGGREGATOR", "subtype": "AGGREGATOR"},
        "payment_token": ApPConstatns.finalPaymentToken
      });
      return Right(res);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
