import 'package:auto_route/auto_route.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:media_portfolio/services/firebase_storage_service.dart';

class AddImagePage extends StatefulWidget {
  const AddImagePage({Key? key}) : super(key: key);

  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImagePage> {
  TextEditingController _controller = TextEditingController();

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'isAppUnderDevelopment : ${RemoteConfig.instance.getBool('is_app_underdevelopment')}',
              ),
              GestureDetector(
                onTap: () async {
                  FirebaseStorageService storage = FirebaseStorageService();
                  String? filePath = await storage.getFilePath();
                  if (filePath != null) {
                    storage.uploadFile(filePath);
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
        ),
      ),
    );
  }
}
