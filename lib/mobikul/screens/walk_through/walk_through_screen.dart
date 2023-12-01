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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/app_widgets/app_outlined_button.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/helper/utils.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/circle_page_indicator.dart';
import '../../app_widgets/image_view.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/PreCacheApiHelper.dart';
import '../../helper/app_storage_pref.dart';
import '../../models/walk_through/walk_through_model.dart';
import '../../network_manager/api_client.dart';
import 'bloc/walk_through_bloc.dart';
import 'bloc/walk_through_event.dart';
import 'bloc/walk_through_state.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  WalkThroughBloc? _walkThroughBloc;
  bool isLoading = false;
  var lst;
  WalkThroughModel? walkViewThroughModel;
  List<WalkthroughData> itemListData = [];
  final _currentPageNotifier = ValueNotifier<int>(0);

  void initState() {
    super.initState();
    _walkThroughBloc = context.read<WalkThroughBloc>();
    precCacheHomePage(false);
    _walkThroughBloc?.add(const WalkThroughFetchEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<WalkThroughBloc, WalkThroughState>(
          builder: (context, currentState) {
        if (currentState is WalkThroughInitial) {
          isLoading = true;
        } else if (currentState is WalkThroughSuccess) {
          isLoading = false;
          walkViewThroughModel = currentState.model;
          itemListData.addAll(walkViewThroughModel?.walkthroughData ?? []);
        } else if (currentState is WalkThroughError) {
          isLoading = false;
          // WidgetsBinding.instance?.addPostFrameCallback((_) {
          //   AlertMessage.showError("currentState.message", context);
          // });

          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
        }
        return isLoading ? const Loader() : _buildUI();
      }),
    );
  }

  Widget _buildUI() {
    if ((walkViewThroughModel?.walkthroughData??[]).isEmpty) {
      // appStoragePref.setShowWalkThrough(false);
      Navigator.of(context).pushNamedAndRemoveUntil(
          AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
    }
    return SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ((walkViewThroughModel?.walkthroughData??[]).isNotEmpty) ?
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                _buildPageView(),
                const SizedBox(
                  height: AppSizes.size10,
                ),
                SizedBox(
                  width: AppSizes.deviceWidth,
                  child: Center(
                    child: _buildCircularindicator(_currentPageNotifier),
                  ),
                ),
              ],
            ),
            // SizedBox(height:MediaQuery.of(context).size.width/10,),
            if (_currentPageNotifier.value ==
                (int.parse("${walkViewThroughModel?.walkthroughData?.length}") -
                    1))
              Column(
                children: [
                  button(),
                ],
              )
            else
              textButton()
          ],
        ) :
            Container()
    );
  }

  Widget _buildPageView() {
    return SizedBox(
        height: AppSizes.deviceHeight / 2.8 + 200,
        child: CarouselSlider.builder(
            itemCount: walkViewThroughModel?.walkthroughData?.length,
            options: CarouselOptions(
              onPageChanged: (index, reason) {
                setState(() {
                  _currentPageNotifier.value = index;
                });
              },
              enlargeCenterPage: true,
              height: AppSizes.deviceHeight / 2.8 + 250,
              viewportFraction: 0.8,
              enableInfiniteScroll: false,
            ),
            itemBuilder: (context, index, i) {
              return InkWell(
                  onTap: () {},
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30, 40, 30, 15.0),
                          child: SizedBox(
                            height: AppSizes.deviceHeight / 2.8,
                            width: AppSizes.deviceWidth / 1.5,
                            child: Card(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ImageView(
                                url: walkViewThroughModel
                                        ?.walkthroughData?[index].name ??
                                    "",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: AppSizes.deviceWidth / 1.8,
                          child: Text(
                              walkViewThroughModel
                                      ?.walkthroughData?[index].productId ??
                                  "",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: AppSizes.deviceWidth / 2,
                          child: Text(
                              walkViewThroughModel
                                      ?.walkthroughData?[index].content ??
                                  "",
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14)),
                        ),
                      ],
                    ),
                  ));
            }));
  }

  Widget textButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(19.0, 0, 19.0, 0.0),
          child: SizedBox(
            height: AppSizes.genericButtonHeight,
            child: appOutlinedButton(
              context,
              height: 40,
              textColor: AppColors.white,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              borderRadius: 10,
                  () {
                    appStoragePref.setShowWalkThrough(false);
                    Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
              },
              "${Utils.getStringValue(context, AppStringConstant.skip)} ",
            ),
          ),
        ),
      ],
    );
  }

  Widget button() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(19.0, 0, 19.0, 0.0),
          child: ElevatedButton(
            onPressed: () {
              appStoragePref.setShowWalkThrough(false);
              Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.bottomTabBar, (Route<dynamic> route) => false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    Utils.getStringValue(context, AppStringConstant.continue_to_next),
                    style: Theme.of(context)
                        .textTheme
                        .button
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCircularindicator(_currentPageNotifier) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: CirclePageIndicator(
        dotColor: AppColors.lightGray,
        selectedDotColor:
            Theme.of(context).bottomAppBarTheme.color ?? Colors.white,
        itemCount: walkViewThroughModel?.walkthroughData?.length,
        currentPageNotifier: _currentPageNotifier,
      ),
    );
  }
}
