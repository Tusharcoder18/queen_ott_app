import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class SelectGenreWidget extends StatefulWidget {
  const SelectGenreWidget({
    Key key,
    @required this.screenHeight,
    @required this.temp,
  }) : super(key: key);

  final double screenHeight;
  final Function temp;

  @override
  _SelectGenreWidgetState createState() => _SelectGenreWidgetState();
}

class _SelectGenreWidgetState extends State<SelectGenreWidget> {
  bool showOptions = false;
  IconData arrowIcon = Icons.keyboard_arrow_down_sharp;

  void changeShowOptions() {
    if (!showOptions) {
      showOptions = true;
      arrowIcon = Icons.keyboard_arrow_up_sharp;
    } else {
      showOptions = false;
      arrowIcon = Icons.keyboard_arrow_down_sharp;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0),
      child: Column(
        children: [
          Container(
            height: widget.screenHeight * 0.1,
            padding: EdgeInsets.all(16.0),
            color: Color(0xFF1C1C1C),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Genre',
                  style: TextStyle(
                    fontSize: 21.0,
                    color: Colors.white38,
                  ),
                ),
                GestureDetector(
                  child: Icon(
                    arrowIcon,
                    color: Colors.white38,
                    size: 35.0,
                  ),
                  onTap: () {
                    changeShowOptions();
                  },
                )
              ],
            ),
          ),
          showOptions == false
              ? Container()
              : Column(
                  children: [
                    CheckBoxListValue(
                      itemName: 'Action',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Animation',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Crime',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Comedy',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Drama',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Fantasy',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Historical',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Horror',
                      temp: widget.temp,
                    ),
                    CheckBoxListValue(
                      itemName: 'Romance',
                      temp: widget.temp,
                    ),
                  ],
                )
        ],
      ),
    );
  }
}

class CheckBoxListValue extends StatefulWidget {
  CheckBoxListValue({this.itemName, this.temp});

  final Function temp;
  final String itemName;

  @override
  _CheckBoxListValueState createState() => _CheckBoxListValueState();
}

class _CheckBoxListValueState extends State<CheckBoxListValue> {

  @override
  Widget build(BuildContext context) {
    bool _checked = Provider.of<UploadService>(context, listen: false).isGenreInList(genreName: widget.itemName);
    return CheckboxListTile(
      title: Text(widget.itemName),
      value: Provider.of<UploadService>(context, listen: false)
          .isGenreInList(genreName: widget.itemName),
      onChanged: (bool value) {
        setState(() {
          if (!_checked) {
            Provider.of<UploadService>(context, listen: false)
                .addGenreToList(genreName: widget.itemName);
             _checked =  Provider.of<UploadService>(context, listen: false)
                .isGenreInList(genreName: widget.itemName);
           // _checked = true;
            // genre = widget.itemName;
            widget.temp(widget.itemName);
            print(widget.itemName);
          } else {
            Provider.of<UploadService>(context, listen: false)
                .removeGenreFromList(genreName: widget.itemName);
            _checked = Provider.of<UploadService>(context, listen: false)
                .isGenreInList(genreName: widget.itemName);
            // genre = "";
            widget.temp("");
          }
        });
      },
    );
  }
}
