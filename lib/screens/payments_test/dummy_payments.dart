import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class DummyPaymentsScreen extends StatefulWidget {
  const DummyPaymentsScreen({Key key}) : super(key: key);

  @override
  _DummyPaymentsScreenState createState() => _DummyPaymentsScreenState();
}

class _DummyPaymentsScreenState extends State<DummyPaymentsScreen> {
  Razorpay razorpay;
  TextEditingController amountToPay = new TextEditingController();

  @override
  void initState() {
    super.initState();
    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerWallet);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
  }

  void handlerSuccess() {
    print("Payment Successful");
  }

  void handlerError() {
    print("Payment Error");
  }

  void handlerWallet() {
    print("External Wallet");
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_H4Jt3Vhw1RXrNb',
      'amount': 1000,
      'name': 'Sample app',
      'description': 'Subscription of the app.',
      'prefill': {
        'contact': '8888888888',
        'email': 'test@razorpay.com',
      },
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dummy Payments"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: amountToPay,
              decoration: InputDecoration(
                hintText: "Enter Amount",
              ),
            ),
            SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                openCheckout();
              },
              child: Container(
                child: Center(
                  child: Text("Pay"),
                ),
                color: Colors.blue,
                height: 40,
              ),
            )
          ],
        ),
      ),
    );
  }
}
