import 'package:e_waste/app/widgets/constants.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(EWasteLayout.PADDING),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _dialogContent(context),
    );
  }

  _dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[_bottomCartPart(context), _topCircularImagePart()],
    );
  }

  _bottomCartPart(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: EWasteLayout.AVATAR_RADIUS + EWasteLayout.PADDING,
        bottom: EWasteLayout.PADDING,
        left: EWasteLayout.PADDING,
        right: EWasteLayout.PADDING,
      ),
      margin: EdgeInsets.only(top: EWasteLayout.AVATAR_RADIUS),
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(EWasteLayout.PADDING),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          SizedBox(height: 24.0),
          Align(
            alignment: Alignment.bottomRight,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).pop(); // To close the dialog
              },
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }

  _topCircularImagePart() {
    return Positioned(
      left: EWasteLayout.PADDING,
      right: EWasteLayout.PADDING,
      child: CircleAvatar(
        backgroundColor: Colors.blueAccent,
        radius: EWasteLayout.AVATAR_RADIUS,
      ),
    );
  }
}
