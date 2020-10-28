import 'package:flutter/material.dart';
import 'package:shopApp/utils/size_config.dart';

class LoadingDialogView extends StatelessWidget {
  final String _text;

  const LoadingDialogView(this._text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(width: SizeConfig.blockSizeHorizontal * 10),
            Text(_text)
          ],
        ),
      ),
    );
  }
}
