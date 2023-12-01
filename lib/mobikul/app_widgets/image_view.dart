/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';

class ImageView extends StatefulWidget {
  String? url;
  double height;
  double width;
  BoxFit fit;
  final borderRadius;
  bool? isBottomPadding = true;

  ImageView(
      {this.url = "",
      this.width = 0.0,
      this.height = 0.0,
      this.fit = BoxFit.fill,
      this.borderRadius,
      this.isBottomPadding});

  @override
  State<ImageView> createState() => _ImageViewState();

// @override
// Widget build(BuildContext context) {
//   return Container(
//     decoration: const BoxDecoration(
//         // color: AppColors.red,
//         borderRadius: BorderRadius.all(Radius.circular(16))
//     ),
//     child: FadeInImage(
//       placeholder: const AssetImage(AppImages.placeholder),
//       image: NetworkImage(url ?? ''),
//       imageErrorBuilder: (context, error, stackTrace) {
//         return Image.asset(AppImages.placeholder,
//             width: width != 0.0 ? width : 40.0,
//             height: height != 0.0 ? height : 40.0);
//       },
//       fit: fit,
//       width: width != 0.0 ? width : 40.0,
//       height: height != 0.0 ? height : 40.0,
//     ),
//   );
// }
}

class _ImageViewState extends State<ImageView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
      ),
      child:widget.url==null?Container(
        width: widget.width != 0.0 ? widget.width : 40.0,
        height: widget.height != 0.0 ? widget.height : 40.0,
        decoration:  const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(AppImages.placeholder,)
          ),
        ),
      )
          :
          /* FadeInImage(
        placeholder: const AssetImage(AppImages.placeholder),
        image: (widget.url == null)? NetworkImage('') :  NetworkImage(widget.url ?? ''),
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(AppImages.placeholder,
              width: widget.width != 0.0 ? widget.width : 40.0,
              height: widget.height != 0.0 ? widget.height : 40.0);
        },
        fit: widget.fit,
        width: widget.width != 0.0 ? widget.width : 40.0,
        height: widget.height != 0.0 ? widget.height : 40.0,
      ),*/

          Padding(
              padding: EdgeInsets.only(
                  bottom: widget.isBottomPadding == false ? 0.0 : 10.0),
              child: ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: widget.url ?? '',
                  width: widget.width != 0.0 ? widget.width : 40.0,
                  height: widget.height != 0.0 ? widget.height : 40.0,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Container(
                    width: widget.width != 0.0 ? widget.width : 40.0,
                    height: widget.height != 0.0 ? widget.height : 40.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(8),
                      image: DecorationImage(
                        image: const AssetImage(
                          AppImages.placeholder,
                        ),
                        fit: widget.fit,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: widget.width != 0.0 ? widget.width : 40.0,
                    height: widget.height != 0.0 ? widget.height : 40.0,
                    decoration: BoxDecoration(
                      borderRadius:
                          widget.borderRadius ?? BorderRadius.circular(8),
                      image: const DecorationImage(
                          image: AssetImage(
                        AppImages.placeholder,
                      )),
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
