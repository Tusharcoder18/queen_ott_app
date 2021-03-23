import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeasonListScreen extends StatefulWidget {
  @override
  _SeasonListScreenState createState() => _SeasonListScreenState();
}

class _SeasonListScreenState extends State<SeasonListScreen> {
  List<Widget> _seasonList = <Widget>[SeasonListInfo()];

  Future<void> _showMyDialog() async {
    String textFieldValue;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add a new season'),
          content: Column(
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
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _seasonList.add(SeasonListInfo());
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seasons'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                child: ListView.builder(
                  itemCount: _seasonList.length,
                  itemBuilder: (context, index) {
                    return _seasonList[index];
                  },
                ),
              ),
            ),

            SizedBox(
              height: 5,
            ),

            /// Create new series button
            GestureDetector(
              onTap: () {
                _seasonList.add(SeasonListInfo(textInfo:   "Season " + (_seasonList.length + 1).toString() ,));
                setState(() {

                });
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
                        'Add new season',
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
    );
  }
}

class SeasonListInfo extends StatefulWidget {

  SeasonListInfo({this.textInfo = "Season 1"});

  final String textInfo;

  @override
  _SeasonListInfoState createState() => _SeasonListInfoState();
}

class _SeasonListInfoState extends State<SeasonListInfo> {
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(widget.textInfo),
      value: _checked,
      onChanged: (bool value) {
        setState(() {
          if (_checked)
            _checked = false;
          else
            _checked = true;
        });
      },
    );
  }
}
