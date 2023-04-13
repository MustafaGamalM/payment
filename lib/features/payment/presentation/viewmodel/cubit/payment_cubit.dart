import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:payment_app/core/app_constatns.dart';
import 'package:payment_app/features/payment/data/repo/payment_repo.dart';
import 'package:payment_app/features/payment/data/repo/payment_repo_impl.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());
  static PaymentCubit get(context) => BlocProvider.of(context);
  final PaymentRepo _paymentRepo = PaymentRepoImpl();

  getPaymentAuthRequest() async {
    emit(GetPaymentAuthRequestLoadingSatate());

    var res = await _paymentRepo.getPaymentAuthRequest();
    res.fold((l) {
      emit(GetPaymentAuthRequestErrorSatate());
    }, (r) {
      print(r.data['token']);
      ApPConstatns.authTokenFirst = r.data['token'];
      emit(GetPaymentAuthRequestSuccessSatate());
    });
  }

  Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(GetOrderRegistrationLoadingState());

    var res = await _paymentRepo.getOrderRegistrationID(price);

    res.fold((l) {
      print('Error in order id 🤦‍♂️');
      print(e.toString());
      emit(GetOrderRegistrationErrorState());
    }, (r) {
      ApPConstatns.orderId = r.data['id'];
      getPaymentRequest(
          email: email,
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          price: price);
      print('The order id 🍅 ${r.data['id']}');
      emit(GetOrderRegistrationSuccessState());
    });
  }

  getPaymentRequest({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(GetPaymentKeyLoadingState());

    var res = await _paymentRepo.getPaymentRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        price: price);
    res.fold((l) {
      print('request errrrrr');
      print(e.toString());
      emit(GetPaymentKeyErrorState());
    }, (r) {
      ApPConstatns.finalPaymentToken = r.data['token'];

      print("doneeeeeeeeeeeeeeeee");
      print(ApPConstatns.finalPaymentToken);
      emit(GetPaymentKeySuccessState());
    });
  }

  getRefCode() async {
    emit(GetRefCodeLoadingState());
    var res = await _paymentRepo.getRefCode();
    res.fold((l) {
      print('error');
      print(e.toString());
      emit(GetRefCodeErrorState());
    }, (r) {
      print(r.data['id']);
      ApPConstatns.refCode = r.data['id'];
      print('rffffffff');
      emit(GetRefCodeSuccessState());
    });
  }
}
