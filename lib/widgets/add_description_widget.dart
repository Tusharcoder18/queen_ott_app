import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/screens/add_description_screen.dart';
import 'package:queen_ott_app/services/upload_service.dart';

Widget addDescriptionWidget(
    BuildContext context, double screenHeight, double screenWidth) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => AddDescriptionScreen()));
      },
      child: Container(
        height: screenHeight * 0.1,
        padding: EdgeInsets.all(16.0),
        color: Color(0xFF1C1C1C),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              FontAwesomeIcons.pen,
              color: Colors.white38,
              size: 20.0,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              Provider.of<UploadService>(context, listen: false)
                          .returnVideoDescription() !=
                      ''
                  ? Provider.of<UploadService>(context, listen: false)
                      .returnVideoDescription()
                  : 'Add Description',
              style: Theme.of(context).textTheme.headline1,
            ),
            SizedBox(
              width: screenWidth * 0.35,
            ),
            Icon(
              Icons.arrow_forward_ios_outlined,
              color: Colors.white38,
              size: 25.0,
            ),
          ],
        ),
      ),
    ),
  );
}
