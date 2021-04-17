import 'package:flutter/material.dart';
import 'package:queen_ott_app/models/season.dart';
import 'package:queen_ott_app/models/series.dart';
import 'package:queen_ott_app/models/video.dart';
import 'package:queen_ott_app/screens/series_details_screen.dart';
import 'package:queen_ott_app/widgets/custom_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class SubscriptionScreen extends StatefulWidget {
  SubscriptionScreen({this.plans, this.prices});

  final List<String> plans;
  final List<int> prices;

  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectPlan = 0;
  int _amount = 49;
  bool _termsCheck = false;
  List<String> _plans;
  List<int> _prices;
  String _key = 'rzp_test_E9FL3va4DIckGC'; // Temporary test key
  Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay(); // Create Razorpay instance

    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    _plans = widget.plans;
    _prices = widget.prices;
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear(); // Removes all listeners
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success');
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(title: Center(child: Text('Payment Successful')));
        });
    print(response.orderId);
    print(response.paymentId);
    print(response.signature);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Failure');
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(title: Center(child: Text('Payment Failed')));
        });
    print(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External Wallet');
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
              title: Center(child: Text('Payment Successful(Wallet)')));
        });
    print(response.walletName);
  }

  void openCheckout() {
    var options = {
      'key': _key,
      'amount': _amount * 100,
      'name': 'Queen OTT',
      'description': 'Subscription to Queen OTT services',
      ''
          'prefill': {'contact': '8888888888', 'email': 'test@gmail.com'}
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Choose the plan that's right for you.",
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Select a plan from the available plans.",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 15,
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: List.generate(4, (index) {
                return Container(
                    child: _rowButton(
                        color: index == _selectPlan
                            ? Colors.blue
                            : Colors.transparent,
                        text: _plans[index],
                        price: _prices[index]));
              }),
            ),
            Row(
              children: [
                Checkbox(
                    value: _termsCheck,
                    onChanged: (value) {
                      setState(() {
                        _termsCheck = value;
                      });
                    }),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Accept all terms and conditions',
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {},
              child: CustomButton(
                text: 'Continue',
                color: Colors.blue,
                onTap: () {
                  // openCheckout();
                  if (_termsCheck) {
                    print('Payment init');
                    final _seriesTitle = 'Guitar Lessons 101';
                    final _seriesDescription = 'Learn guitar the better way.';
                    final _seriesThumbnail =
                        'https://images.unsplash.com/photo-1543945696-4f1116f30c03?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2107&q=80';
                    final _seriesGenre = ['Music'];
                    final _seriesSeasons = [
                      Season(1, [Video('Lesson1', 'Description', '1', '2')])
                    ];

                    final series = Series(_seriesTitle, _seriesDescription,
                        _seriesThumbnail, _seriesGenre, _seriesSeasons);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SeriesDetailScreen(series)));
                  } else {
                    final snackBar = SnackBar(
                      content: Text(
                        'Please accept the terms and conditions!',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      backgroundColor: Colors.grey,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                icon: Icon(Icons.check_circle),
              ),
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  Widget _rowButton({Color color, String text, int price}) {
    return InkWell(
      onTap: () {
        setState(() {
          if (text == 'Monthly') {
            _selectPlan = 0;
            _amount = 49;
          } else if (text == 'Quaterly') {
            _selectPlan = 1;
            _amount = 120;
          } else if (text == 'Half Yearly') {
            _selectPlan = 2;
            _amount = 150;
          } else if (text == 'Yearly') {
            _selectPlan = 3;
            _amount = 250;
          }
          print(_selectPlan);
        });
      },
      child: Container(
        margin: EdgeInsets.all(4),
        // height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.lightBlueAccent),
            borderRadius: BorderRadius.all(
              Radius.circular(4),
            ),
            color: color),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.headline1,
            ),
            Text(
              'Rs.${price.toString()}',
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
    );
  }
}
