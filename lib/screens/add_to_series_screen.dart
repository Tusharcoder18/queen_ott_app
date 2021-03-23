import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:google_fonts/google_fonts.dart';
import 'package:queen_ott_app/screens/season_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/add_series_services.dart';

class AddToSeriesScreen extends StatefulWidget {
  @override
  _AddToSeriesScreenState createState() => _AddToSeriesScreenState();
}

class _AddToSeriesScreenState extends State<AddToSeriesScreen> {
  // This is for the pop up window
  Future<void> _showMyDialog() async {
    String textFieldValue;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('AlertDialog Title'),
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
                Provider.of<AddSeriesServices>(context, listen: false)
                    .addNewSeries(
                        seriesName: textFieldValue,
                        seriesList: "Series " + _seriesList.length.toString());
                _seriesList.add(SeriesInfoContainer(inputText: textFieldValue));
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Widget> _seriesList = <Widget>[];

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: _seriesList.length.toDouble() * 60,
                child: ListView.builder(
                  itemCount: _seriesList.length,
                  itemBuilder: (context, index) {
                    return _seriesList[index];
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

class SeriesInfoContainer extends StatefulWidget {
  SeriesInfoContainer({@required this.inputText});

  final String inputText;

  @override
  _SeriesInfoContainerState createState() => _SeriesInfoContainerState();
}

class _SeriesInfoContainerState extends State<SeriesInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SeasonListScreen()));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        height: 60,
        color: Colors.black26,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.inputText),
            Icon(Icons.chevron_right_rounded),
          ],
        ),
      ),
    );
  }
}
