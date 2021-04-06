import 'package:flutter/material.dart';
import 'package:queen_ott_app/widgets/video_grid_widget.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  String _searchKey;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: TextFormField(
                    autofocus: true,
                    style: Theme.of(context)
                        .textTheme
                        .headline1
                        .copyWith(color: Colors.black),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search for shows, movies here',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.grey),
                    ),
                    onChanged: (value) {
                      _searchKey = value;
                      // We can call a function here for the search functionality to work
                      print(_searchKey);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Popular Searches',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
                Expanded(
                  child: VideoGridWidget(
                    count: 14,
                    physics: ScrollPhysics(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class SearchScreeenFunction extends SearchDelegate<String> {
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     // TODO: implement buildActions
//     return [
//       IconButton(icon: Icon(Icons.close), onPressed: () {
//         query = '';
//       }),
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     // TODO: implement buildLeading
//     return IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () {
//           close(context, null);
//         });
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     return ;
//   }
// }
