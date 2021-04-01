import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CustomStaggeredWidget extends StatelessWidget {
  const CustomStaggeredWidget({
    Key key,
    @required this.imageList,
    @required this.count,
  }) : super(key: key);

  final List<String> imageList;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      margin: EdgeInsets.all(8.0),
      child: StaggeredGridView.countBuilder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
          itemCount: count,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: FadeInImage(
                  placeholder: AssetImage(imageList[index]),
                  image: AssetImage(imageList[index]),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
          staggeredTileBuilder: (index) {
            return StaggeredTile.count(1, index.isEven ? 1.2 : 1.8);
          }),
    );
  }
}
