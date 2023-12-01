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

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/homePage/home_page_banner.dart';

import '../../../app_widgets/circle_page_indicator.dart';
import '../../../app_widgets/image_view.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../network_manager/api_client.dart';
import '../../category/widgets/category_products.dart';

class HomeBanners extends StatefulWidget {
  List<Banners> banners = [];
  bool showTitle;

  HomeBanners(this.banners, this.showTitle);

  @override
  _HomeBannersState createState() => _HomeBannersState();
}

class _HomeBannersState extends State<HomeBanners> {
  final _pageController = PageController(initialPage: 0);
  final _currentPageNotifier = ValueNotifier<int>(0);
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
    //   if (_currentPageNotifier.value < widget.banners.length) {
    //     _currentPageNotifier.value++;
    //   } else {
    //     _currentPageNotifier.value = 0;
    //   }
    //
    //   if (widget.banners.length > 1) {
    //     _pageController.animateToPage(_currentPageNotifier.value,
    //         duration: const Duration(milliseconds: 60),
    //         curve: Curves.easeInToLinear);
    //   }
    // });
  }





  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _timer?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (widget.showTitle)
            Container(
              padding: const EdgeInsets.all(AppSizes.size4 / 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.size4 / 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.size16),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Utils.getStringValue(
                              context, AppStringConstant.offersForYou)
                          .toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1,
                    )),
              ),
            ),
          Container(
            padding: EdgeInsets.only(
                left: AppSizes.size4,
                right: AppSizes.size4,
                top: widget.showTitle ? 0 : AppSizes.size8),
            height: AppSizes.deviceWidth / 2 + 60,
            width: AppSizes.deviceWidth.toDouble(),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.banners.length,
              itemBuilder: (BuildContext context, int index) {
                //mobikul  pre-cache
                preCacheBannerData(widget.banners[index].type ?? "", (widget.banners[index].id ?? 0).toString());
                return InkWell(
                  onTap: () =>
                      handleBannerClicks(widget.banners[index], context),
                  child: Card(
                      margin: EdgeInsets.zero,
                      child: ImageView(
                        url: widget.banners[index].url ?? widget.banners[index].bannerImage ?? "",
                        fit: BoxFit.fill,
                      )),
                );
              },
              onPageChanged: (int index) {
                setState(() {
                  _currentPageNotifier.value = index;
                });
              },
            ),
          ),
          if (widget.banners.length > 1)
            Container(
              width: AppSizes.deviceWidth,
              color: Theme.of(context).cardColor,
              child: Center(
                child: _buildCircularindicator(_currentPageNotifier),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildCircularindicator(_currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
      child: CirclePageIndicator(
        dotColor: AppColors.darkGray,
        selectedDotColor:
            Theme.of(context).bottomAppBarTheme.color ?? Colors.black,
        itemCount: widget.banners.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }

  void handleBannerClicks(Banners banner, BuildContext context) {
    if (banner.type == "category") {
      Navigator.pushNamed(context, AppRoutes.catalog,
          arguments: getCatalogMap(
            banner.id.toString() ?? "",
            banner.name ?? "",
            banner.type,
            false,
          ));
    } else if (banner.type == "product") {
      Navigator.of(context).pushNamed(
        AppRoutes.productPage,
        arguments: getProductDataAttributeMap(
          banner.name.toString(),
          banner.id.toString(),
        ),
      );
    }
  }
}
