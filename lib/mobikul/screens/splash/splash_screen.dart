
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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/models/homePage/home_screen_model.dart';
import '../../../main.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/global_data.dart';
import '../../helper/app_localizations.dart';
import '../../models/walk_through/walk_through_model.dart';
import 'bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  HomePageData? homePageDataModel;
  SplashScreenBloc? _splashScreenBloc;

  List<WalkthroughData>? walkthroughData  = [];

  @override
  void initState() {

    _splashScreenBloc = context.read<SplashScreenBloc>();
    _splashScreenBloc?.add(SplashScreenDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SplashScreenBloc, SplashScreenState>(
        builder: (BuildContext context, state) {
          if (state is SplashScreenInitial) {
            isLoading = true;
          } else if (state is SplashScreenSuccess) {
            isLoading = false;
            homePageDataModel = state.homePageData;
            GlobalData.homePageData = state.homePageData;
            setApplicationData();
          } else if (state is WalkThroughDataSuccess) {
            isLoading = false;
            walkthroughData = state.model.walkthroughData??[];
            if ((walkthroughData??[]).isNotEmpty) {
              WidgetsBinding.instance?.addPostFrameCallback((_) async{
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.walkThrough,(Route<dynamic> route) => false);
              });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) async{
                Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar,(Route<dynamic> route) => false);
              });
            }
          } else if (state is WalkThroughDataError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) async{
              Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar,(Route<dynamic> route) => false);
            });
          } else if (state is SplashScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AppDialogHelper.errorDialog(
                AppStringConstant.errorRequest,
                context,
                AppLocalizations.of(context),
                title: AppStringConstant.somethingWentWrong,
                cancelable: false,
                onConfirm: () async {
                  _splashScreenBloc?.emit(SplashScreenInitial());
                  _splashScreenBloc?.add(SplashScreenDataFetchEvent());
                },
              );
            });
          }
          return buildUI(context);
        },
      ),
    );
  }

  Widget buildUI(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: AppSizes.deviceWidth.toDouble(),
          height: AppSizes.deviceHeight.toDouble(),
          child: appStoragePref.getSplashScreen().isEmpty ? Image.asset(
            AppImages.splashScreen,
            fit: BoxFit.fill,
          ) :
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    appStoragePref.getSplashScreen() ?? "",
                  ),
                  fit: BoxFit.fill,
                )
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: isLoading,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom
    ]); // Revert the status bar visibility
  }

  void setApplicationData() {
    // if (appStoragePref.getStoreCode() == null && (homePageDataModel?.storeData?.length ?? 0) > 0) {
    //   appStoragePref.setStoreCode(homePageDataModel?.d?[0] ?? "en");
    // }

    appStoragePref.setSplashScreen(homePageDataModel?.splashImage?? "");
    appStoragePref.setSplashScreenDark(homePageDataModel?.darkSplashImage?? "");
    appStoragePref.setAppLogo(homePageDataModel?.appLogo?? "");
    appStoragePref.setAppLogoDark(homePageDataModel?.darkAppLogo?? "");

    appStoragePref.setIsTabCategoryView(((homePageDataModel?.tabCategoryView??"1") == "1"));


    if (appStoragePref.getCurrencyCode().isEmpty)
      appStoragePref.setCurrencyCode(homePageDataModel?.defaultCurrency?? AppConstant.defaultCurrency);

    setStoreData();
    setOnBoardingVersion();
    updatePricePref();

    WidgetsBinding.instance?.addPostFrameCallback((_) async{
      print("TEST_LOG=====showWalkThrough==> ${await appStoragePref.showWalkThrough()??""}");
      if (appStoragePref.showWalkThrough()) {
        _splashScreenBloc?.add(const WalkThroughDataFetchEvent());
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar,(Route<dynamic> route) => false);
      }
    });

  }

  void setStoreData() {
    if (homePageDataModel?.websiteId != null && (homePageDataModel?.websiteId.toString()??"").isNotEmpty) {
      appStoragePref.setWebsiteId(homePageDataModel?.websiteId.toString()??"");
    }
    homePageDataModel?.storeData?.forEach((element) {
      element.stores?.forEach((store) {
        if (appStoragePref.getStoreId() == store.id.toString()) {
          appStoragePref.setStoreCode(store.code??"");
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AppLocalizations.of(context)?.load(Locale.fromSubtags(languageCode: appStoragePref.getStoreCode()));
            MobikulApp.setLocale(context, Locale.fromSubtags(languageCode: appStoragePref.getStoreCode()));
          });
        }
      });
    });
  }

  void updatePricePref() {
    appStoragePref.setPricePattern(homePageDataModel?.priceFormat?.pattern??"");
    appStoragePref.setPrecision(homePageDataModel?.priceFormat?.precision??0);
  }

  void setOnBoardingVersion() async {
    if (homePageDataModel?.walkthroughVersion?.isNotEmpty??false) {
      if (appStoragePref.getWalkThroughVersion()?.isEmpty??true) {
        appStoragePref.setShowWalkThrough(true);
        appStoragePref.setWalkThroughVersion(homePageDataModel?.walkthroughVersion.toString()?? "");
      }
      if (double.parse(appStoragePref.getWalkThroughVersion().toString()??"") < double.parse(homePageDataModel?.walkthroughVersion.toString()??"0.0")) {
        appStoragePref.setShowWalkThrough(true);
        appStoragePref.setWalkThroughVersion(homePageDataModel?.walkthroughVersion.toString()?? "");
      }
    }
  }
}
