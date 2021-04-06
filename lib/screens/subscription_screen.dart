import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/custom_button.dart';

class SubscriptionScreen extends StatefulWidget {
  @override
  _SubscriptionScreenState createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectPlan = 0;
  bool _terms = false;
  List<String> _plans = ['Monthly', 'Quaterly', 'Half Yearly', 'Yearly'];
  List<int> _prices = [49, 120, 150, 250];

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
                    value: _terms,
                    onChanged: (value) {
                      setState(() {
                        _terms = value;
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
                onTap: () {},
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
          } else if (text == 'Quaterly') {
            _selectPlan = 1;
          } else if (text == 'Half Yearly') {
            _selectPlan = 2;
          } else if (text == 'Yearly') {
            _selectPlan = 3;
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
