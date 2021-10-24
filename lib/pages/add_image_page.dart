import 'package:auto_route/auto_route.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_portfolio/common/logging/app_log_helper.dart';
import 'package:media_portfolio/services/firebase_storage_service.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({Key? key}) : super(key: key);

  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  TextEditingController _controller = TextEditingController();
  UploadTask? _uploadTask;
  double? _progress;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        previousPageTitle: 'Explorer',
        middle: Text('Add Image'),
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            AutoRouter.of(context).pop();
          },
          child: GestureDetector(
            child: Text('Cancel'),
            onTap: () {
              AutoRouter.of(context).pop();
            },
          ),
        ),
      ),
      child: CupertinoPageScaffold(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 21),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: _uploadTask != null
                    ? LinearProgressIndicator(
                        value: _progress,
                      )
                    : SizedBox.shrink(),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _progress != null
                      ? Text(
                          'Uploading ${(_progress! * 100).toStringAsFixed(2)} %',
                        )
                      : SizedBox.shrink(),
                  Text(
                    'isAppUnderDevelopment : ${RemoteConfig.instance.getBool('is_app_underdevelopment')}',
                  ),
                  GestureDetector(
                    onTap: () async {
                      FirebaseStorageService storage = FirebaseStorageService();
                      String? filePath = await storage.getFilePath();
                      if (filePath != null) {
                        _uploadTask = storage.uploadFile(filePath);

                        if (_uploadTask != null) {
                          // Once image is uploaded close page.
                          _uploadTask!.whenComplete(() {
                            AutoRouter.of(context).pop();
                          });
                          // listen file progress
                          _uploadTask!.snapshotEvents.listen((event) {
                            SLog.sLog(
                                'Progress : ${event.bytesTransferred.toString()} / ${event.totalBytes.toString()}');
                            setState(() {
                              _progress = event.bytesTransferred.toDouble() /
                                  event.totalBytes.toDouble();
                            });
                          });
                        }
                      }
                    },
                    child: Center(
                      child: Icon(
                        CupertinoIcons.cloud_upload,
                        size: 36,
                      ),
                    ),
                  ),
                  Center(
                    child: Text('Upload'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
