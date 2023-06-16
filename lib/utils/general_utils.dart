import 'package:fluttertoast/fluttertoast.dart';

void showToastMessage(String text) {
  Fluttertoast.showToast(
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    fontSize: 16.0,
  );
}
