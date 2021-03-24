import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/add_to_series_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/add_series_services.dart';


/// This button is present on the upload_screen.dart as button
/// on clicking it, it should take the uploader to the new screen
/// where it would take in all the necessary information to add the given
/// video to the series


class AddSeriesButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: GestureDetector(
        onTap: () async{
          await context.read<AddSeriesServices>().getSeriesInfo();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddToSeriesScreen()));
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          padding: EdgeInsets.all(16.0),
          color: Color(0xFF1C1C1C),
          child: Row(
            children: [
              Icon(
                Icons.playlist_add,
                color: Colors.white38,
                size: 25.0,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Add to Series',
                style: TextStyle(
                  fontSize: 21.0,
                  color: Colors.white38,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
