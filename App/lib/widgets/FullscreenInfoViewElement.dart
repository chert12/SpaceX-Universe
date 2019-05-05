import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:spacex_universe/services/AppConstants.dart';
import 'package:spacex_universe/services/Utilities.dart';

abstract class FullscreenInfoViewElement extends StatelessWidget {
  const FullscreenInfoViewElement({Key key}) : super(key: key);

  Widget build(BuildContext context) {
    return SizedBox.shrink();
  }

  @protected
  Widget buildUrlImage(String imageUrl, String heroTag, BuildContext context) {
    if (null == imageUrl || imageUrl.isEmpty) {
      return Hero(
          tag: heroTag,
          child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                image: AssetImage(AppConstants.ROCKET_IMAGE_PATH),
              )))));
    } else {
      return Hero(
          tag: heroTag,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            placeholder: (context, url) =>
                new Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => new Icon(Icons.error),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
          ));
    }
  }

  @protected
  Widget buildInternalImage(String image, BuildContext context) {
    if (null == image || image.isEmpty) {
      return SizedBox.shrink();
    } else {
      return SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                  ))));
    }
  }

  @protected
  Widget buildListElement(String title, String value) {
    if (title == null || value == null) {
      return SizedBox.shrink();
    }
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                value,
                style: TextStyle(color: Colors.black38, fontSize: 16),
              ),
            ],
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 1.0, color: Colors.black12))
        ],
      ),
    );
  }

  @protected
  Widget buildListTitle(String title) {
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 2.0, color: Colors.black12))
        ],
      ),
    );
  }

  @protected
  Widget buildLinkElement(String title, String link, BuildContext context) {
    if (title == null || link == null || title.isEmpty || link.isEmpty) {
      return SizedBox.shrink();
    }
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          InkWell(
              onTap: () {
                Utilities.launchUrl(link);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: Colors.black87,
                  ),
                ],
              )),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 1.0, color: Colors.black12))
        ],
      ),
    );
  }

  @protected
  Widget buildImageGallery(List<String> images, BuildContext context) {
    if (null == images || images.length <= 0) {
      return SizedBox.shrink();
    }

    var wList = new List<Widget>();
    var imageGallery = new List<GalleryExampleItem>();
    for (int i = 0; i < images.length; i++) {
      var galleryExample =
          new GalleryExampleItem(id: "imageGallery_$i", resource: images[i]);
      imageGallery.add(galleryExample);
      wList.add(new GalleryExampleItemThumbnail(
        galleryExampleItem: galleryExample,
        onTap: () {
          _openImageGallery(context, imageGallery, i);
        },
      ));
    }
    return Padding(
        padding: EdgeInsets.only(top:5, bottom: 10),
        child:Container(
        height: 100,
        child: ListView(scrollDirection: Axis.horizontal, children: wList)));

//    var pageOptions = new List<PhotoViewGalleryPageOptions>();
//
//    for (int i = 0; i < images.length; i++) {
//      pageOptions.add(new PhotoViewGalleryPageOptions(
//        imageProvider: CachedNetworkImageProvider(images[0]),
//        heroTag: "imageGallery_$i",
//      ));
//    }
//
//    return Container(
//      height: 250,
//        child: PhotoViewGallery(
//      pageOptions: pageOptions,
//      loadingChild: new CircularProgressIndicator(),
//      backgroundDecoration: const BoxDecoration(
//        color: Colors.black,
//      ),
//      pageController: new PageController(initialPage: 0),
//      //onPageChanged: onPageChanged,
//    ));
  }

  @protected
  Widget buildElementWithDescription(String description, String text) {
    if (text == null) {
      return SizedBox.shrink();
    }
    return new Padding(
      padding: new EdgeInsets.all(7),
      child: Column(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                description,
                style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              new Padding(
                  padding: new EdgeInsets.only(top: 5),
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black, fontSize: 13),
                  ))
            ],
          ),
          new Padding(
              padding: new EdgeInsets.only(top: 5),
              child: Container(height: 2.0, color: Colors.black12))
        ],
      ),
    );
  }

  void _openImageGallery(
    BuildContext context,
    List<GalleryExampleItem> galleryItems,
    final int index,
  ) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GalleryPhotoViewWrapper(
                galleryItems: galleryItems,
                backgroundDecoration: const BoxDecoration(
                  color: Colors.black,
                ),
                initialIndex: index,
              ),
        ));
  }
}

class GalleryExampleItem {
  GalleryExampleItem({this.id, this.resource, this.isSvg = false});

  final String id;
  final String resource;
  final bool isSvg;
}

class GalleryExampleItemThumbnail extends StatelessWidget {
  const GalleryExampleItemThumbnail(
      {Key key, this.galleryExampleItem, this.onTap})
      : super(key: key);

  final GalleryExampleItem galleryExampleItem;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 5.0),
        child: GestureDetector(
          onTap: onTap,
          child: Hero(
            tag: galleryExampleItem.id,
            child: CachedNetworkImage(
                imageUrl: galleryExampleItem.resource, height: 80.0),
          ),
        ));
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  GalleryPhotoViewWrapper(
      {this.loadingChild,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale,
      this.initialIndex,
      @required this.galleryItems})
      : pageController = PageController(initialPage: initialIndex);

  final Widget loadingChild;
  final Decoration backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<GalleryExampleItem> galleryItems;

  @override
  State<StatefulWidget> createState() {
    return _GalleryPhotoViewWrapperState();
  }
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: widget.backgroundDecoration,
          constraints: BoxConstraints.expand(
            height: MediaQuery.of(context).size.height,
          ),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              PhotoViewGallery.builder(
                scrollPhysics: const BouncingScrollPhysics(),
                builder: _buildItem,
                itemCount: widget.galleryItems.length,
                loadingChild: widget.loadingChild,
                backgroundDecoration: widget.backgroundDecoration,
                pageController: widget.pageController,
                onPageChanged: onPageChanged,
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Image ${currentIndex + 1}",
                  style: const TextStyle(
                      color: Colors.white, fontSize: 17.0, decoration: null),
                ),
              )
            ],
          )),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    GalleryExampleItem item = widget.galleryItems[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(item.resource),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroTag: item.id,
    );
  }
}
