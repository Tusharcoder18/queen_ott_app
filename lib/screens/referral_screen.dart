import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:queen_ott_app/constants.dart';
import 'package:queen_ott_app/widgets/custom_button.dart';
import 'package:share/share.dart';

class ReferAndEarnScreen extends StatelessWidget {
  final referAsset = 'assets/refer.svg';
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: screenHeight * 0.03,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "For each referral you and your friends get 1 month extra",
              style:
                  Theme.of(context).textTheme.headline1.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Or you can avail 20% off the subscription plan",
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: 'Referral Code'));
                ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                  backgroundColor: Colors.grey,
                  duration: Duration(seconds: 2),
                  content: Text(
                    'Copied to clipboard!',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ));
              },
              child: TextField(
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.copy),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: kGoldenColor),
                  ),
                  hintText: 'Referral Code',
                ),
                readOnly: true,
                style: Theme.of(context).textTheme.headline1,
                enabled: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              text: 'Share',
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  .copyWith(color: Colors.black),
              icon: Icon(
                Icons.share,
                color: Colors.black,
              ),
              color: kGoldenColor,
              onTap: () async {
                try {
                  await Share.share(
                      'Use my link to join the app and you will get 1 month free');
                } catch (e) {
                  print(e);
                }
              },
            ),
            Expanded(
                child: SvgPicture.asset(
              referAsset,
            )),
          ],
        ),
      ),
    );
  }
}
