import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_ott_app/screens/season_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/add_series_services.dart';

class AddToSeriesScreen extends StatefulWidget {
  @override
  _AddToSeriesScreenState createState() => _AddToSeriesScreenState();
}

class _AddToSeriesScreenState extends State<AddToSeriesScreen> {


  /// This contains info of the list that is there
  Widget _listInformation({String inputText, int indexNumber}) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async{
              print("Delete Service Called");
              context.read<AddSeriesServices>().deleteSeries(
                  inputText: inputText,
              );
              print(_seriesNameList);
              setState(() {
                _seriesNameList.remove(inputText);
              });
              print(_seriesNameList);
            },
            child: Container(
              child: Icon(Icons.restore_from_trash_outlined),
            ),
          ),
          GestureDetector(
            onTap: () async{
              print("Index number = $indexNumber");
              context.read<AddSeriesServices>().getEpisodeInfo(
                seriesName: inputText
              ).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>SeasonListScreen())));
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 60,
              color: Colors.black38,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(inputText),
                  Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  /// This dialog box would pop up if the entered series is not unique
  Future<void> _showMyDialogIfNotUnique() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('The series Already Exists'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter a unique series to continue'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  /// This is for the pop up window
  Future<void> _showMyDialog() async {
    String textFieldValue;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Series'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Center(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: TextField(
                        onChanged: (String value) {
                          textFieldValue = value;
                          print(textFieldValue);
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[
            /// This is used to add series to the screen
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if(_seriesNameList.indexOf(textFieldValue) < 0){
                  Provider.of<AddSeriesServices>(context, listen: false)
                      .addNewSeries(
                      seriesName: textFieldValue);
                  setState(() {
                    _seriesList.add(SeriesInfoContainer(inputText: textFieldValue, notifyParent: refresh,));
                    _seriesNameList.add(textFieldValue);
                  });
                  Navigator.of(context).pop();
                } else {
                  _showMyDialogIfNotUnique();
                }

              },
            ),
          ],
        );
      },
    );
  }

  void refresh() {
    setState(() {
    });
  }

  List<Widget> _seriesList = <Widget>[];
  List<String> _seriesNameList = <String>[];

  @override
  void initState() {
    super.initState();
    setState(() {
      _seriesNameList = context.read<AddSeriesServices>().returnSeriesInfoList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add to',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _seriesNameList.length.toDouble() * 60,
                child: ListView.builder(
                  itemCount: _seriesNameList.length,
                  itemBuilder: (context, index) {
                    return  _listInformation(inputText: _seriesNameList[index], indexNumber: index);//SeriesInfoContainer(inputText: _seriesNameList[index], indexNumber: index, notifyParent: refresh,);
                  },
                ),
              ),

              SizedBox(
                height: 5,
              ),

              /// Create new series button
              GestureDetector(
                onTap: () {
                  _showMyDialog();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 80,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF121212),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        size: 30,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        child: Text(
                          'Add new series',
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                          ),
                        ),
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
}


/// Widget which contains the bin icon, Series name and right arrow icon
/// On clicked it would take you to the season Screen
class SeriesInfoContainer extends StatefulWidget {
  SeriesInfoContainer({@required this.inputText, this.indexNumber, this.notifyParent});

  final String inputText;
  final int indexNumber;
  final Function()  notifyParent;

  @override
  _SeriesInfoContainerState createState() => _SeriesInfoContainerState();
}

class _SeriesInfoContainerState extends State<SeriesInfoContainer> {
  @override
  Widget build(BuildContext context) {
    context.read<AddSeriesServices>().getSeriesInfo();
    return Container(
      padding: EdgeInsets.only(left: 10),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async{
              print("Delete Service Called");
              context.read<AddSeriesServices>().deleteSeries(
                  inputText: widget.inputText
              );
              widget.notifyParent();
            },
            child: Container(
              child: Icon(Icons.restore_from_trash_outlined),
            ),
          ),
          GestureDetector(
            onTap: () async{
              print("Index number = ${widget.indexNumber}");
               context.read<AddSeriesServices>().getEpisodeNumber(
                episodeNumber: widget.indexNumber
              );
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SeasonListScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              height: 60,
              color: Colors.black38,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.inputText),
                  Icon(Icons.chevron_right_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


