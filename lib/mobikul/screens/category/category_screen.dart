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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/constants/global_data.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_bloc.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_events.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_states.dart';
import 'package:test_new/mobikul/screens/category/widgets/category_banners.dart';
import 'package:test_new/mobikul/screens/category/widgets/category_products.dart';
import 'package:test_new/mobikul/screens/category/widgets/category_tile.dart';

import '../../app_widgets/app_bar.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../helper/PreCacheApiHelper.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../models/categoryPage/category_page_response.dart';
import '../../models/homePage/home_screen_model.dart';
import '../category_listing/category_listing_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  CategoryScreenBloc? categoryScreenBloc;
  bool isLoading = true;
  HomePageData? homePageData;
  CategoryPageResponse? _categoryPageResponse;
  int _selectedIndex = 0;
  bool? isSubCategoryLoading;

  @override
  void initState() {
    homePageData = GlobalData.homePageData;
    categoryScreenBloc = context.read<CategoryScreenBloc>();
    categoryScreenBloc?.add(
        CategoryScreenDataFetchEvent(homePageData?.categories?[0].id ?? 0));
    categoryScreenBloc?.emit(CategoryScreenInitial());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        Utils.getStringValue(context, AppStringConstant.categories),
        context,
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
        ],
      ),
      body: _buildMainUi(),
    );
  }

  Widget _buildMainUi() {
    return BlocBuilder<CategoryScreenBloc, CategoryScreenState>(
      builder: (context, currentState) {
        if (currentState is CategoryScreenInitial) {
          isLoading = true;
        } else if (currentState is CategoryScreenSuccess) {
          isLoading = false;
          _categoryPageResponse = currentState.categoryPageResponse;
        } else if (currentState is CategoryScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {});
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Container(
      color: Theme.of(context).cardColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          categoryListView(),
          (isLoading == true)
              ? SizedBox(
            width: MediaQuery.of(context).size.width -
                MediaQuery.of(context).size.width / 3.5,
            child: const Loader(),
          )
              : subcategoryListView()
        ],
      ),
    );
  }

  //========For Left (main) categories==========//
  Widget categoryListView() {
    return Container(
      color: Colors.grey.withOpacity(0.2),
      child: SizedBox(
        width: AppSizes.deviceWidth / 3.5,
        height: AppSizes.deviceHeight,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: (homePageData?.categories ?? [])?.length,
            itemBuilder: (BuildContext context, int index) {
              //mobikul  pre-cache
              precCacheCategoryPage(homePageData?.categories?[index].id ?? 0);
              return InkWell(
                  onTap: () {
                    _categoryPageResponse?.productList = null;
                    categoryScreenBloc?.add(CategoryScreenDataFetchEvent(
                        homePageData?.categories?[index].id ?? 0));
                    categoryScreenBloc?.emit(CategoryScreenInitial());
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? Theme.of(context).cardColor
                            : Colors.transparent,
                      ),
                      height: AppSizes.deviceHeight * 0.06,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          homePageData?.categories?[index].name ?? "",
                          textAlign: TextAlign.center,
                          style: _selectedIndex == index
                              ? Theme.of(context).textTheme.bodyText2?.copyWith(
                              fontSize: AppSizes.textSizeSmall,
                              color: Theme.of(context).iconTheme.color)
                              : Theme.of(context)
                              .textTheme
                              .bodyText2
                              ?.copyWith(fontSize: AppSizes.textSizeSmall),
                        ),
                      )));
            }),
      ),
    );
  }

  //======For Right (sub) categories========//
  Widget subcategoryListView() {
    var width = MediaQuery.of(context).size.width -
        MediaQuery.of(context).size.width / 3.5;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            if ((_categoryPageResponse?.smallBannerImage ?? []).isNotEmpty)
              SizedBox(
                width: width,
                child: CategoryBanners(
                    (_categoryPageResponse?.smallBannerImage ?? [])),
              ),
            SizedBox(
              width: width,
              child: (_categoryPageResponse?.categories ?? []).isNotEmpty
                  ? Column(
                children: [
                  CategoryTile(
                    subCategories: _categoryPageResponse?.categories,
                  ),
                  const SizedBox(height: AppSizes.size15),
                  categoryProducts()
                ],
              )
                  : categoryProducts(),
            ),
          ],
        ),
      ),
    );
  }

  //=========Showing products for selected category=======//
  Widget categoryProducts() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size10),
      child: buildCategoryProducts(
          _categoryPageResponse?.productList ?? [],
          context,
          isSubCategoryLoading,
          homePageData?.categories?[_selectedIndex].id.toString(),
          homePageData?.categories?[_selectedIndex].name ?? ""),
    );
  }
}
