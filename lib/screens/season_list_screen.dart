import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/add_series_services.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class SeasonListScreen extends StatefulWidget {
  @override
  _SeasonListScreenState createState() => _SeasonListScreenState();
}

class _SeasonListScreenState extends State<SeasonListScreen> {
  List<dynamic> _episodeList = [];
  List<bool> _isChecked = [];


  /// This function would add new season to the list
  void _addNewSeason() {
    Map<String, dynamic> _addNewMap = <String, dynamic>{};
    _episodeList.add(_addNewMap);
    print(_episodeList);
    _addIsChecked();
    setState(() {
    });
  }

  /// This would add new _isChecked with a value of false
  void _addIsChecked(){
    _isChecked.add(false);
  }

  void _printEpisodeList() {
    _episodeList = context.read<AddSeriesServices>().returnEpisodeList();
    print(_episodeList);
    print(_episodeList.length);
    for(int i = 0; i<_episodeList.length; i++){
      _isChecked.add(false);
    }
    print(_isChecked);
    setState(() {
    });
  }

  /// Just return the length of the no. of episodes in the given season
  int _returnEpisodeListLength({int index}) {
    Map<String, dynamic> _mapList = _episodeList[index];
    return _mapList.length;
  }

  @override
  void initState() {
    super.initState();
    _printEpisodeList();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: screenHeight,
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // This Container shall contain the list view
              Expanded(
                flex: 1,
                child: Container(
                  color: Colors.blueGrey,
                  child: _episodeList.length == 0
                      ? Container()
                      : ListView.builder(
                          itemCount: _episodeList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15.0, bottom: 5.0, top: 5),
                              child: Container(
                                color: Colors.black,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                                      child: Container(
                                        height:  40,
                                        child: CheckboxListTile(
                                          title: Text('Season ${index+1}'),
                                          value: _isChecked[index],
                                          onChanged: (bool value){
                                            setState(() {
                                              if(_isChecked[index]){
                                                _isChecked[index] = false;
                                                context.read<UploadService>().getCurrentSeason(index: -1);
                                                context.read<UploadService>().getStatusOfChecked(status: false);
                                              }
                                              else{
                                                _isChecked[index] = true;
                                                context.read<UploadService>().getCurrentSeason(index: index);
                                                context.read<UploadService>().getStatusOfChecked(status: true);
                                              }
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    _episodeList.length == 0 ? Container() : Container(
                                      height: _returnEpisodeListLength(index: index).toDouble()*40,
                                      child: ListView.builder(
                                        itemCount: _returnEpisodeListLength(
                                            index: index),
                                        itemBuilder: (context, index) {
                                          return Container(
                                            padding: EdgeInsets.only(left: 15.0),
                                            height: 40,
                                            child: Text("Episode ${index + 1}"),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),

              /// This Container would contain the add new season button
              InkWell(
                onTap: (){
                  _addNewSeason();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  color: Color(0xFF121212),
                  height: 70,
                  width: screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 30.0,
                      ),
                      Text(
                        'Add New Episode',
                        style: GoogleFonts.roboto(
                            fontSize: 22.0, fontWeight: FontWeight.bold),
                      )
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
}
