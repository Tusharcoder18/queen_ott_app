import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/movie_grid_widget.dart';

// This widget contains all the shows which the user was previously watching

class ContinueWatchingWidget extends StatefulWidget {
  @override
  _ContinueWatchingWidgetState createState() => _ContinueWatchingWidgetState();
}

class _ContinueWatchingWidgetState extends State<ContinueWatchingWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: MovieGridWidget(
        physics: ScrollPhysics(),
      ),
    );
  }
}
