import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SeasonDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _appBar(screenHeight, screenWidth),
          _episodesList(screenHeight, screenWidth)
        ],
      ),
    );
  }

  Widget _appBar(double screenHeight, double screenWidth) {
    return SliverAppBar(
      expandedHeight: screenHeight * 0.65,
      backgroundColor: Colors.black,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        // collapseMode: CollapseMode.pin,
        background: Container(
          child: Stack(
            fit: StackFit.expand,
            children: [
              FadeInImage(
                placeholder: AssetImage('assets/movieTwo.jpg'),
                image: AssetImage('assets/movieOne.jpg'),
                fit: BoxFit.cover,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                    stops: [0.1, 0.6, 1.0],
                    colors: [Colors.black54, Colors.transparent, Colors.black],
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.02,
                      vertical: screenHeight * 0.005),
                  width: double.infinity,
                  // color: Colors.pink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Show Name',
                        style: TextStyle(
                            fontSize: screenHeight * 0.035,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        height: screenHeight * 0.01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.17,
                            height: screenHeight * 0.04,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Text(
                                'Action',
                                style: TextStyle(fontSize: 12),
                              ),
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: screenWidth * 0.17,
                            height: screenHeight * 0.04,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Text(
                                'Drama',
                                style: TextStyle(fontSize: 12),
                              ),
                              color: Colors.blueGrey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                            width: screenWidth * 0.17,
                            height: screenHeight * 0.04,
                            child: MaterialButton(
                              onPressed: () {},
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              child: Text(
                                'Sci-fi',
                                style: TextStyle(fontSize: 12),
                              ),
                              color: Colors.blueGrey,
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Text(
                        'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book...',
                        style: TextStyle(
                            fontSize: screenHeight * 0.019,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          TextButton(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.add,
                                  size: screenWidth * 0.1,
                                ),
                                Text(
                                  'Watch List',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  FontAwesomeIcons.heart,
                                  size: screenWidth * 0.08,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Like',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.share,
                                  size: screenWidth * 0.1,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: screenWidth * 0.03,
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _episodesList(double screenHeight, double screenWidth) {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenWidth * 0.02,
                    horizontal: screenHeight * 0.005),
                child: SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      index == 0
                          ? Text(
                              'Episodes',
                              style: TextStyle(fontSize: screenHeight * 0.03),
                            )
                          : Text('Episode $index')
                    ],
                  ),
                ),
              );
            })
      ]),
    );
  }
}
