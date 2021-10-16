import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:media_portfolio/common/my_route/my_route.gr.dart';
import 'package:media_portfolio/pages/add_image_page.dart';
import 'package:media_portfolio/services/firebase_auth_service.dart';
import 'package:octo_image/octo_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var myNetworkImages = [
    'https://picsum.photos/150?image=9',
    'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.pexels.com/photos/2820884/pexels-photo-2820884.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
    'https://images.unsplash.com/photo-1547721064-da6cfb341d50',
    'https://protocoderspoint.com/wp-content/uploads/2019/10/mypic-300x300.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (_, __) {
          return [
            CupertinoSliverNavigationBar(
              largeTitle: Text('Explore'),
              leading: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(CupertinoIcons.add),
                onPressed: () {
                  AutoRouter.of(context).push(
                    AddImageRoute(),
                  );
                },
              ),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                child: Text('Logout'),
                onPressed: () {
                  FirebaseAuthService().signOut().then(
                    (value) {
                      AutoRouter.of(context).replace(LoginRoute());
                    },
                  );
                },
              ),
              // trailing: CupertinoButton(
              //   padding: const EdgeInsets.all(0),
              //   child: Icon(
              //     CupertinoIcons.ellipsis_vertical,
              //   ),
              //   onPressed: () {},
              // ),
            ),
          ];
        },
        body: StaggeredGridView.countBuilder(
          // Give space to item
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          // How many columns
          crossAxisCount: 2,

          itemCount: 50,
          itemBuilder: (_, index) {
            int i = Random().nextInt(myNetworkImages.length);
            return MyGridImageView(
              url: myNetworkImages[i],
              onImageClick: () {
                AutoRouter.of(context).push(
                  ImageFullScreenPreviewRoute(imageUrl: myNetworkImages[i]),
                );
              },
            );
          },
          staggeredTileBuilder: (index) => StaggeredTile.fit(1),
        ),
      ),
    );
  }
}

class MyGridImageView extends StatefulWidget {
  late String url;
  VoidCallback? onImageClick;

  MyGridImageView({
    required this.url,
    this.onImageClick,
    Key? key,
  }) : super(key: key);

  @override
  _MyGridImageViewState createState() => _MyGridImageViewState();
}

class _MyGridImageViewState extends State<MyGridImageView> {
  @override
  Widget build(BuildContext context) {
    return CupertinoContextMenu(
      previewBuilder: (_, __, ___) => SizedBox.expand(
        child: MyGridImageView(url: widget.url),
      ),
      actions: [
        CupertinoContextMenuAction(
          child: Text('Share'),
          trailingIcon: CupertinoIcons.share,
          onPressed: () {},
        ),
        CupertinoContextMenuAction(
          isDestructiveAction: true,
          child: Text('Delete'),
          trailingIcon: CupertinoIcons.delete,
          onPressed: () {},
        ),
      ],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: GestureDetector(
          onTap: () {
            if (widget.onImageClick != null) widget.onImageClick!();
          },
          child: Image.network(
            widget.url,
            // widget
            //     .myNetworkImages[Random().nextInt(widget.myNetworkImages.length)]
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
