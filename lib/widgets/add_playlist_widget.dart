import 'package:flutter/material.dart';

Widget addPlaylistWidget(BuildContext context, double screenHeight) {
  return Padding(
    padding: EdgeInsets.only(top: 4.0),
    child: Container(
      height: screenHeight * 0.1,
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
            'Add to playlist',
            style: TextStyle(
              fontSize: 21.0,
              color: Colors.white38,
            ),
          ),
        ],
      ),
    ),
  );
}
