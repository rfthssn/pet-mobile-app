import 'package:flutter/material.dart';
import 'package:pet_mobile_app/screens/weight_chart/bottom_sheet_widget.dart';

class AddWeightButton extends StatefulWidget {
  const AddWeightButton({Key? key}) : super(key: key);

  @override
  _AddWeightButtonState createState() => _AddWeightButtonState();
}

class _AddWeightButtonState extends State<AddWeightButton> {
  bool _show = true;
  @override
  Widget build(BuildContext context) {
    return _show? ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.add),
            Text("Weight")
          ],
        ),
        style: ElevatedButton.styleFrom(
            fixedSize: Size(100, 20),
            primary: Colors.orangeAccent,
            onPrimary: Colors.deepOrange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18)
            )
        ),
        onPressed: (){
          var sheetController = showBottomSheet(context: context,
              builder: (context)=> BottomSheetWidget()
          );
          _showButton(false);
          sheetController.closed.then((value){
            _showButton(true);
          });
        }
    ) : Container();
  }

  void _showButton(bool value){
    setState(() {
      _show = value;
    });
  }
}


