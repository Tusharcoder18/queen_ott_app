import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:queen_ott_app/services/upload_service.dart';

class AddDescriptionScreen extends StatefulWidget {
  @override
  _AddDescriptionScreenState createState() => _AddDescriptionScreenState();
}

class _AddDescriptionScreenState extends State<AddDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    int descriptionLength = Provider.of<UploadService>(context, listen: true)
        .returnVideoDescription()
        .length;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Description'),
      ),
      body: Column(
        children: [
          Expanded(
              flex: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: TextEditingController()
                          ..text =
                              Provider.of<UploadService>(context, listen: true)
                                      .returnVideoDescription() ??
                                  ''
                          ..selection = TextSelection(
                              baseOffset: Provider.of<UploadService>(context,
                                      listen: true)
                                  .returnVideoDescription()
                                  .length,
                              extentOffset: Provider.of<UploadService>(context,
                                      listen: true)
                                  .returnVideoDescription()
                                  .length),
                        minLines: 1,
                        maxLines: 10,
                        maxLength: 500,
                        onChanged: (value) {
                          Provider.of<UploadService>(context, listen: false)
                              .getVideoDescription(value);
                          print(value);
                          print(value.length);
                          descriptionLength = value.length;
                          setState(() {});
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                          hintText: 'Add description',
                          hintStyle: TextStyle(fontSize: 18.0),
                        ),
                        style: TextStyle(fontSize: 16.0),
                        showCursor: true,
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    color: Color(0xFF1C1C1C),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$descriptionLength/500",
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5.0),
                    height: 50,
                    width: double.infinity,
                    color: Color(0xFF1C1C1C),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Next"),
                          color: Colors.blue,
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
