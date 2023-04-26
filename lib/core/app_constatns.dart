class ApPConstatns {
  static const String baseUrl = "https://accept.paymob.com/api/";
  static const String authEndPoint = "auth/tokens";
  static const String orderEndPoint = "ecommerce/orders";
  static const String paymentKeyEndPoint = "acceptance/payment_keys";
  static const String refCodeEndPoint = "acceptance/payments/pay";

  static const String apiKey =
      "";

  static String authTokenFirst = "";
  static int orderId = 0;
  static String finalPaymentToken = "";

  static int refCode = 0;
  static var kioskId = 3734684;
  static var paymentCardId = 3731392;

  // kiosk payment
  static const String kioskPaymentEndPoint = "acceptance/payments/pay";

  static String viseUrl =
      "${baseUrl}acceptance/iframes/752629?payment_token=$finalPaymentToken";
}

class AppImages {
  static const String refCodeImage =
      "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String visaImage =
      "https://cdn-icons-png.flaticon.com/128/349/349221.png";
}
