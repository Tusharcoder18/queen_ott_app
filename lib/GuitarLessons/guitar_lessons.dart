import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/GuitarLessons/guitar_video_fetchin_service.dart';
import 'package:queen_ott_app/screens/test.dart';
import 'package:queen_ott_app/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class GuitarPage extends StatefulWidget {
  @override
  _GuitarPageState createState() => _GuitarPageState();
}

class _GuitarPageState extends State<GuitarPage> {
  List<List<String>> guitarList = [];
  bool loading = false;

  Future<void> getList() async {
    final list = await context.read<GuitarService>().returnLessonList();
    guitarList = list;
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    setState(() {
      loading = true;
    });
    getList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading == true
        ? LoadingWidget()
        : SafeArea(
            child: Scaffold(
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Guitar Lessons',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'OpenSans',
                          fontSize: 30.0),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        itemCount: guitarList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.94,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.purple],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight)),
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Test(
                                              videoUrl: guitarList[index][0],
                                            ),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            'Lesson ${index + 1}',
                                            style: TextStyle(
                                                fontFamily: 'OpenSans',
                                                fontSize: 25.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        launch(guitarList[index][1]);
                                      },
                                      child: Container(
                                        color: Colors.white24,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Download PDF'),
                                            Icon(Icons.download_rounded),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
