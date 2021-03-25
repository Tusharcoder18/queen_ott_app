import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/authentication_service.dart';
import 'package:queen_ott_app/services/upload_service.dart';
import 'package:queen_ott_app/widgets/home_video_display_list_widget.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';

class HomeScreenWidget extends StatelessWidget {
  // This is to give font style to the different headings
  // on the screen
  final TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 15,
  );

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    User _user = Provider.of<AuthenticationService>(context).currentUser;
    String _name = _user.displayName ?? 'User';
    _name = _name.split(" ")[0];

    return SingleChildScrollView(
      child: Container(
        width: screenWidth,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.05,
              child: Text(
                'Welcome $_name',
                style: TextStyle(fontSize: screenHeight * 0.03),
              ),
            ),
            Container(
              height: screenHeight * 0.2,
              width: screenWidth,
              color: Colors.pink,
              child: Image.asset(
                'assets/moviePoster.jpg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.022,
            ),
            Container(
              height: 20,
              width: screenWidth,
              child: Text(
                'Continue Watching',
                style: _textStyle,
              ),
            ),
            ContinueWatchingWidget(screenWidth: screenWidth),
            Container(
              height: 20,
              width: screenWidth,
              child: Text(
                'Recommended Shows',
                style: _textStyle,
              ),
            ),
            RecommendedShowWidget(screenWidth: screenWidth),
            Container(
              height: 20,
              width: screenWidth,
              child: Text(
                'Watch shows in you Language',
                style: _textStyle,
              ),
            ),
            LanguageShowsWidget(screenWidth: screenWidth),
            // Container(
            //   height: 20,
            //   width: screenWidth,
            //   child: Text(
            //     'Award Winning Shows',
            //     style: _textStyle,
            //   ),
            // ),
            // AwardWinningShowsWidget(screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }
}

class AwardWinningShowsWidget extends StatelessWidget {
  const AwardWinningShowsWidget({
    @required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Container(
        height: 120,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.green,
                  child: Image.asset(
                    'assets/movieOne.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.green,
                  child: Image.asset(
                    'assets/movieThree.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.green,
                  child: Image.asset(
                    'assets/movieTwo.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LanguageShowsWidget extends StatelessWidget {
  LanguageShowsWidget({
    @required this.screenWidth,
  });

  final double screenWidth;

  final TextStyle _textStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          height: 150,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green, Colors.lightBlueAccent]),
                  ),
                  child: Center(
                      child: Text(
                    'Hindi',
                    style: _textStyle,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green, Colors.lightBlueAccent]),
                  ),
                  child: Center(
                      child: Text(
                    'English',
                    style: _textStyle,
                  )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.green, Colors.lightBlueAccent]),
                  ),
                  child: Center(
                      child: Text(
                    'Punjabi',
                    style: _textStyle,
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// This Widget contains all the shows to be displayed under recommended shows
class RecommendedShowWidget extends StatelessWidget {
  const RecommendedShowWidget({
    @required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return VideoGridWidget();
  }
}

// This widget contains all the shows which the user was previously watching
class ContinueWatchingWidget extends StatelessWidget {
  const ContinueWatchingWidget({
    @required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: HomeVideoListWidget(),
    );
  }
}
