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

import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../models/dashboard/UserDataModel.dart';

class ProfileBannerView extends StatefulWidget {
  Function(String, String)? addImageCallback;
  Function(String)? deleteImageCallBack;

  ProfileBannerView(this.addImageCallback, {Key? key}) : super(key: key);

  @override
  _ProfileBannerViewState createState() => _ProfileBannerViewState();
}

class _ProfileBannerViewState extends State<ProfileBannerView> {
  String? bannerImage;
  String? profileImage;
  String name = "";
  String email = "";
  AppLocalizations? _localizations;

  @override
  void initState() {
    UserDataModel? userModel = appStoragePref.getUserData();
    bannerImage = userModel?.bannerImage;
    profileImage = userModel?.profileImage;
    name = userModel?.name ?? "";
    super.initState();
  }

  void getDetails() {
    setState(() {
      UserDataModel? userModel = appStoragePref.getUserData();
      bannerImage = userModel?.bannerImage;
      profileImage = userModel?.profileImage;
      name = userModel?.name ?? "";
      email = userModel?.email ?? "";
    });
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    getDetails();
    return SizedBox(
        width: AppSizes.deviceWidth,
        child: commonBannerView(bannerImage, profileImage, name, email));
  }

  Widget commonBannerView(
      String? bannerImage, String? profileImage, String name, String email) {
    return SizedBox(
      width: AppSizes.deviceWidth,
      child: Card(
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 0, right: 0),
            child: Stack(
              children: [
                Container(
                  decoration: ((bannerImage??"").isNotEmpty) ? BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        bannerImage ?? '',
                      ),
                      fit: BoxFit.fill,
                    ),
                  ) :
                  const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImages.bannerImage,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  right: 0,
                  child: Container(
                      width: AppSizes.deviceWidth,
                      decoration: const BoxDecoration(
                        color: AppColors.transparentBackground,
                        shape: BoxShape.rectangle,
                      )),
                ),
                Positioned(
                  left: 0,
                  bottom: 2,
                  child: SizedBox(
                      width: AppSizes.deviceWidth,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: AppSizes.spacingTiny,
                          horizontal: AppSizes.spacingTiny,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: AppSizes.profileIconSize,
                              width: AppSizes.profileIconSize,
                              child: ImageView(
                                url: profileImage,
                                fit: BoxFit.fill,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            const SizedBox(width: AppSizes.spacingGeneric),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      ?.copyWith(
                                        fontSize: AppSizes.textSizeMedium,
                                        color: Colors.white
                                      ),
                                ),
                                const SizedBox(
                                  height: AppSizes.spacingTiny,
                                ),
                                Text(
                                  email,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.copyWith(
                                        fontSize: AppSizes.textSizeMedium,
                                        color: Colors.white
                                      ),
                                ),
                              ],
                            )
                          ],
                        ),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
