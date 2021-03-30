import 'package:flutter/material.dart';

class SeasonDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [_appBar(), _episodesList(context)],
      ),
    );
  }

  Widget _appBar() {
    return SliverAppBar(
      expandedHeight: 570,
      floating: true,
      title: Text('Show name'),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          children: [
            Column(
              children: [
                FadeInImage(
                  placeholder: AssetImage('assets/movieTwo.jpg'),
                  image: AssetImage('assets/movieOne.jpg'),
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    width: double.infinity,
                    // color: Colors.pink,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Show Name',
                          style: TextStyle(fontSize: 30, color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 70,
                              height: 30,
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
                              width: 70,
                              height: 30,
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
                              width: 70,
                              height: 30,
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
                        SizedBox(height: 10),
                        Text(
                          'Synopsis',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _episodesList(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(<Widget>[
        ListView.builder(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: 15,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
                child: SizedBox(
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Text('Episode $index')],
                  ),
                ),
              );
            })
      ]),
    );
  }
}
