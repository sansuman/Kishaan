
import 'package:Testing2/pages/menu_containt_page.dart';
import 'package:Testing2/text/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class UserDetails extends StatefulWidget {
  UserDetails({Key key,this.userId}):super(key : key);
  final String userId;
  @override
  _UserDetails createState() => _UserDetails();
}

class _UserDetails extends State<UserDetails> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alterPhoneController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
 // TextEditingController phoneController = TextEditingController();
  String _chosenDistrictValue;
  String _chosenBlockValue;
  var otp =00000;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        body: Padding(
            padding:EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      TextDescription.app_name,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w500,
                          fontSize: 30),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'User Details\t',
                      style: TextStyle(fontSize: 20),
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,

                    maxLength: 10,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Name',
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: phoneController,
                    enabled: false,
                    maxLength: 10,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: TextDescription.mobile_enter,
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: alterPhoneController,
                    maxLength: 10,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Alternate Number",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: villageController,
                    maxLengthEnforced: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Village Name",
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButton<String>(

                    focusColor:Colors.white,
                    value: _chosenDistrictValue,
                    elevation: 5,
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      'Android',
                      'IOS',
                      'Flutter',
                      'Node',
                      'Java',
                      'Python',
                      'PHP',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style:TextStyle(color:Colors.black),),
                      );
                    }).toList(),
                    hint:Text(
                      "Please choose a District Name",
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenDistrictValue = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: DropdownButton<String>(

                    focusColor:Colors.white,
                    value: _chosenBlockValue,
                    elevation: 5,
                    iconEnabledColor:Colors.black,
                    items: <String>[
                      'Android',
                      'IOS',
                      'Flutter',
                      'Node',
                      'Java',
                      'Python',
                      'PHP',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value,style:TextStyle(color:Colors.black),),
                      );
                    }).toList(),
                    hint:Text(
                      "Please choose a Block Name",
                    ),
                    onChanged: (String value) {
                      setState(() {
                        _chosenBlockValue = value;
                      });
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    obscureText: true,
                    controller: pinCodeController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Pin Code",
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text('Submit'),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MenuContaint()));
                        },
                    )),

              ],
            )));
  }
  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Success!"),
          content: Text(message),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailPage()));
              },
            ),
          ],
        );
      },
    );
  }
  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new FlatButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}