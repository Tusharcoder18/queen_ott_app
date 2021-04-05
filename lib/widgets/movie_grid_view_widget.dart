import 'package:flutter/material.dart';
import 'package:queen_ott_app/screens/test.dart';

class MovieGridViewWidget extends StatelessWidget {
  MovieGridViewWidget(
      {this.videoDescriptionList,
      this.videoList,
      this.videoNameList,
      this.videoThumbnailList,
      this.videoUrlList});

  final List<String> videoThumbnailList;
  final List<dynamic> videoList;
  final List<String> videoUrlList;
  final List<String> videoNameList;
  final List<String> videoDescriptionList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 300,
        child: GridView.count(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 3,
          childAspectRatio: 0.8,
          crossAxisSpacing: 6,
          mainAxisSpacing: 10,
          children: List.generate(videoThumbnailList.length, (index) {
            return InkWell(
              onTap: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Test(
                      videoUrl: videoUrlList[index],
                      thumbnailUrl: videoThumbnailList[index],
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: FadeInImage(
                    placeholder: NetworkImage(videoThumbnailList[index]),
                    image: NetworkImage(videoThumbnailList[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
