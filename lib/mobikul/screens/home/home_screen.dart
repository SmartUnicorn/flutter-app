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

import 'dart:math';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/helper/PreCacheApiHelper.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/helper/extension.dart';
import 'package:test_new/mobikul/screens/home/widgets/category_widget_type1.dart';
import 'package:test_new/mobikul/screens/home/widgets/category_widget_type2.dart';
import 'package:test_new/mobikul/screens/home/widgets/home_banners.dart';
import 'package:test_new/mobikul/screens/home/widgets/product_carasoul_widget_type1.dart';
import 'package:test_new/mobikul/screens/home/widgets/product_carasoul_widget_type2.dart';
import 'package:test_new/mobikul/screens/home/widgets/product_carasoul_widget_type4.dart';
import 'package:test_new/mobikul/screens/home/widgets/recent_view.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/app_tool_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/global_data.dart';
import '../../helper/app_localizations.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../helper/push_notifications_manager.dart';
import '../../helper/utils.dart';
import '../../models/homePage/home_page_carausel.dart';
import '../../models/homePage/home_screen_model.dart';
import '../../models/homePage/sort_order.dart';
import '../../models/productDetail/product_detail_page_model.dart';
import 'widgets/product_carasoul_widget_type3.dart';
import 'bloc/home_screen_bloc.dart';
import 'bloc/home_screen_events.dart';
import 'bloc/home_screen_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool get wantKeepAlive => true;
  HomeScreenBloc? homePageBloc;
  bool isLoading = true;
  HomePageData? homePageData;
  List<Widget> homePageWidgets = [];
  List<SortOrder> sortedOrder = [];
  bool isFirstCall = true;
  @override
  void initState() {

    var box = HiveStore.openBox("graphqlClientStore").then((value) {
      mainBox = value;
    });
    PushNotificationsManager().checkInitialMessage(context);
    homePageBloc = context.read<HomeScreenBloc>();
    if (isFirstCall) {
      if (GlobalData.homePageData != null) {
        if (homePageData == null) {
          homePageData = GlobalData.homePageData;
          homePageBloc?.emit(HomeScreenDataLoading());
        }
      } else {
        homePageBloc?.add(const HomeScreenDataFetchEvent(false));
      }
    } else {
      homePageBloc?.add(const HomeScreenDataFetchEvent(false));
    }
    precCacheCategoryPage(homePageData?.categories?[0].id ?? 0);
    super.initState();
    PushNotificationsManager().setUpFirebase(context);
  }


  @override
  Widget build(BuildContext context) {
    return DoubleBack(
        message: Utils.getStringValue(
            context, AppStringConstant.pressBackAgainToExit),
        child: Scaffold(
          appBar: appToolBar(
              Utils.getStringValue(context, AppStringConstant.appName), context,
              isHomeEnable: true,
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.search);
                    },
                    icon: const Icon(
                      Icons.search,
                    )),
                IconButton(
                    onPressed: () {
                      notificationBottomModelSheet(context);
                    },
                    icon: const Icon(
                      Icons.notifications,
                    ))
              ]),
          body: mainView(),
        ));
  }


  Widget mainView() {
    return BlocBuilder<HomeScreenBloc, HomeScreenState>(
      builder: (context, currentState) {
        if (currentState is HomeScreenInitial) {
          isLoading = true;
        } else if (currentState is HomeScreenDataLoading) {
          isLoading = false;
          setUpDynamicLayouts();
          if (isFirstCall) {
            homePageBloc?.add(const HomeScreenDataFetchEvent(false));
            isFirstCall = false;
          }
        } else if (currentState is HomeScreenSuccess) {
          isLoading = false;
          homePageWidgets = [];

          GlobalData.homePageData = currentState.homePageData;
          homePageData = currentState.homePageData;

          homePageBloc?.add(const CartCountFetchEvent());
          homePageBloc?.emit(HomeScreenDataLoading());
        }else if (currentState is CartCountSuccess) {
          isLoading = false;
          appStoragePref.setCartCount(currentState.homePageData?.cartCount);
          homePageBloc?.emit(HomeScreenEmptyState());
        }
        else if (currentState is OtherError) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AppDialogHelper.errorDialog(
              currentState.message??AppStringConstant.errorRequest,
              context,
              AppLocalizations.of(context),
              title: AppStringConstant.somethingWentWrong,
              cancelable: false,
              onConfirm: () async {
                appStoragePref.logoutUser();
                homePageBloc?.add(const HomeScreenDataFetchEvent(false));
              },
            );
          });
        } else if (currentState is HomeScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AppDialogHelper.errorDialog(
              AppStringConstant.errorRequest,
              context,
              AppLocalizations.of(context),
              title: AppStringConstant.somethingWentWrong,
              cancelable: false,
              onConfirm: () async {
                homePageBloc?.add(const HomeScreenDataFetchEvent(false));
              },
            );
          });
        }
        return _buildUI();
      },
    );
  }

  final ScrollController _scrollController = ScrollController();
  Widget _buildUI() {
    return Stack(
      children: [
        RefreshIndicator(
          color: Theme.of(context).iconTheme.color,
          onRefresh: () {
            return Future.delayed(Duration.zero).then((value) {
              HiveStore().reset();
              homePageBloc?.add(const HomeScreenDataFetchEvent(true));
            });
          },
          child: Visibility(
              visible: (homePageData != null),
              child: SingleChildScrollView(
                primary: false,
                controller: _scrollController,
                child: Column(
                  children: [
                    Column(
                      children: homePageWidgets!,
                    ),
                    space(),

                    (appStoragePref.getShowRecentProduct())
                        ? Column(children: [
                            const RecentView(),
                            space(),
                          ])
                        : Container(),
                    //Will show at the end of the page!
                    footer(context)
                  ],
                ),
              )),
        ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  void setUpDynamicLayouts() async {
    appStoragePref
        .setIsTabCategoryView(((homePageData?.tabCategoryView ?? "1") == "1"));
    setOnBoardingVersion();

    sortedOrder = getSortedCarouselsData(homePageData?.sortOrder) ?? [];
    print("TEST_LOG==> SortOrder ==> ${sortedOrder}");
    if ((sortedOrder ?? []).isNotEmpty) {
      if (!isFirstCall) {
        if (homePageData?.bannerImages?.isNotEmpty ?? false) {
          var bannerImage = Carousel();
          bannerImage.id = "bannerimage";
          bannerImage.type = "banner";
          bannerImage.banners = homePageData?.bannerImages;
          homePageData?.carousel?.add(bannerImage);
        }

        if (homePageData?.featuredCategories?.isNotEmpty ?? false) {
          var category = Carousel();
          category.id = "featuredcategories";
          category.type = "category";
          category.featuredCategories = homePageData?.featuredCategories;
          homePageData?.carousel?.add(category);
        }
      }

      sortedOrder?.forEach((element) {
        for (var item in homePageData!.carousel!) {
          if (element.layoutId == item.id) {
            switch (item.type) {
              case "product":
                {
                  addProductCarousel(item);
                  break;
                }
              case "image":
                {
                  homePageWidgets?.add(Column(
                    children: [
                      space(),
                      HomeBanners((item?.banners ?? []), false),
                    ],
                  ));
                  break;
                }
              case "category":
                {
                  homePageWidgets?.add(Column(
                    children: [
                      space(),
                      homePageData?.themeType != 1
                          ? CategoryWidgetType2(
                              context, item?.featuredCategories)
                          : CategoryWidgetType1(
                              context, item?.featuredCategories),
                    ],
                  ));
                  break;
                }
              case "banner":
                {
                  homePageWidgets?.add(Column(
                    children: [
                      space(),
                      HomeBanners((item?.banners ?? []), true),
                    ],
                  ));
                  break;
                }
            }
          }
        }
      });
    } else {
      var bannerImage = Carousel();
      bannerImage.id = "bannerimage";
      bannerImage.type = "banner";
      bannerImage.banners = homePageData?.bannerImages;

      var category = Carousel();
      category.id = "featuredcategories";
      category.type = "category";
      category.featuredCategories = homePageData?.featuredCategories;
    }
  }

  List<SortOrder>? getSortedCarouselsData(List<SortOrder>? sortedOrder) {
    List<SortOrder>? sortOrder = [];

    sortedOrder?.forEach((mainElement) {
      if (mainElement.getPositionArray().length == 1) {
        sortOrder?.add(mainElement);
      } else {
        mainElement.getPositionArray().forEach((element) {
          SortOrder? sortOrderObject = SortOrder.empty();
          sortOrderObject.position = element;
          sortOrderObject.layoutId = mainElement.layoutId;
          sortOrderObject.type = mainElement.type;
          sortOrder?.add(sortOrderObject);
        });
      }
    });

    sortOrder.sort((a, b) => int.parse(a.position!.replaceAll(",", "")??"").compareTo(int.parse(b.position!.replaceAll(",", "")??"")));
    return sortOrder;
  }

  void addProductCarousel(Carousel carousel) async {
    switch (selectRandomCarouselLayout(carousel.productList!.length)) {
      case 1:
        {
          homePageWidgets?.add(Column(
            children: [
              space(),
              ProductCarasoulType2(
                (carousel?.productList ?? []),
                context,
                carousel?.id ?? '',
                (carousel?.label ?? ''),
              ),
            ],
          ));
          break;
        }
      case 2:
        {
          homePageWidgets?.add(Column(
            children: [
              space(),
              productCarasoulWidgetType3(
                  (carousel?.productList ?? []),
                  (carousel?.id ?? ""),
                  (carousel?.label ?? ''),
                  context,
                  homePageBloc ?? HomeScreenBloc()),
            ],
          ));
          break;
        }
      case 3:
        {
          homePageWidgets?.add(Column(
            children: [
              space(),
              ProductCarasoulType1(
                  (carousel?.productList ?? []),
                  context,
                  (carousel?.id ?? ''),
                  (carousel?.label ?? ''),
                  homePageBloc ?? HomeScreenBloc()),
            ],
          ));
          break;
        }
      case 4:
        {
          // homePageWidgets?.add(Column(
          //   children: [
          //     ProductCarasoulype4(
          //         (carousel?.productList ?? []),
          //         context,
          //         (carousel?.id ?? ''),
          //         (carousel?.label ?? ''),
          //         homePageBloc ?? HomeScreenBloc()),
          //   ],
          // ));

          homePageWidgets?.add(Column(
            children: [
              space(),
              ProductCarasoulType1(
                  (carousel?.productList ?? []),
                  context,
                  (carousel?.id ?? ''),
                  (carousel?.label ?? ''),
                  homePageBloc ?? HomeScreenBloc()),
            ],
          ));
          break;
        }
    }
  }

  int selectRandomCarouselLayout(int size) {
    if (size > 1) {
      return Random().nextInt(size - 1) + 1;
    } else {
      return 1;
    }
  }

  Widget footer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1,
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSizes.size15),
        child: Column(
          children: [
            Text(Utils.getStringValue(context, AppStringConstant.bottomOfPage),
                style: Theme.of(context).textTheme.bodyText1),
            GestureDetector(
              child: Container(
                margin: const EdgeInsets.only(top: AppSizes.spacingSmall),
                child: Text(
                    Utils.getStringValue(context, AppStringConstant.backToTop),
                    style: Theme.of(context).textTheme.headline5),
              ),
              onTap: () => {
                _scrollController.animateTo(
                    _scrollController.position.minScrollExtent,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease)
              },
            )
          ],
        ),
      ),
    );
  }

  Widget space() {
    return Container(
      height: AppSizes.size12,
      //  color: MobikulTheme.dividerColor,
    );
  }

  void setOnBoardingVersion() {
    if (homePageData?.walkthroughVersion?.isNotEmpty ?? false) {
      if (double.parse(appStoragePref.getWalkThroughVersion().toString()??"") < double.parse(homePageData?.walkthroughVersion.toString()??"0.0")) {
        appStoragePref.setShowWalkThrough(true);
        appStoragePref.setWalkThroughVersion(homePageData?.walkthroughVersion.toString()?? "");
      }
    }
  }
}
