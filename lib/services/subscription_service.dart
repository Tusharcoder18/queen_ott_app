import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionService extends ChangeNotifier {
  bool isSubscribed = false;
  String key = 'rzp_test_H4Jt3Vhw1RXrNb'; //add client's key
  Razorpay razorpay;
  int amount = 100;
  String phoneNumber;
  String emailId;

  void initial() {
    razorpay = Razorpay(); // Create Razorpay instance

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void dispose() {
    super.dispose();
    razorpay.clear(); // Removes all listeners
  }
  

  void _handlePaymentSuccess(
    PaymentSuccessResponse response,
    BuildContext context,
  ) {
    print('Success');
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text('Payment Successful'),
          ),
        );
      },
    );
    isSubscribed = true;
    print(response.orderId);
    print(response.paymentId);
    print(response.signature);
  }

  void _handlePaymentError(
    PaymentFailureResponse response,
    BuildContext context,
  ) {
    print('Failure');
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text('Payment Failed'),
          ),
        );
      },
    );
    isSubscribed = false;
    print(response.message);
  }

  void _handleExternalWallet(
    ExternalWalletResponse response,
    BuildContext context,
  ) {
    print('External Wallet');
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Payment Successful(Wallet)',
            ),
          ),
        );
      },
    );
    isSubscribed = true;
    print(response.walletName);
  }

  void openCheckout() {
    var options = {
      'key': key,
      'amount': amount * 100,
      'name': 'Queen OTT',
      'description': 'Subscription to Queen OTT services',
      'prefill': {
        'contact': '9969113464', //Add phoneNumber
        'email': 'test@gmail.com', //Add emailId
      }
    };

    try {
      razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }
}
