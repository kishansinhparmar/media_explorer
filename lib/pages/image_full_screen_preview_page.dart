import 'package:flutter/cupertino.dart';

class ImageFullScreenPreviewPage extends StatefulWidget {
  final String imageUrl;

  const ImageFullScreenPreviewPage(this.imageUrl, {Key? key}) : super(key: key);

  @override
  _ImageFullScreenPreviewPageState createState() =>
      _ImageFullScreenPreviewPageState();
}

class _ImageFullScreenPreviewPageState
    extends State<ImageFullScreenPreviewPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Explorer',
        middle: Text('Preview'),
      ),
      child: SafeArea(
        child: Image.network(
          widget.imageUrl,
          // widget
          //     .myNetworkImages[Random().nextInt(widget.myNetworkImages.length)]
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
