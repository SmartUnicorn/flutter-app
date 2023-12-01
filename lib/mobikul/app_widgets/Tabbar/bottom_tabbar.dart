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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:test_new/mobikul/screens/cart/bloc/cart_screen_repository.dart';
import 'package:test_new/mobikul/screens/category/category_screen.dart';
import 'package:test_new/mobikul/screens/profile/bloc/profile_screen_repository.dart';
import 'package:test_new/mobikul/screens/wishlist/wishlist_screen.dart';
import '../../constants/app_constants.dart';
import '../../screens/cart/cart_screen.dart';
import '../../screens/category/bloc/category_screen_bloc.dart';
import '../../screens/category/bloc/category_screen_repository.dart';
import '../../screens/category_listing/category_listing_screen.dart';
import '../../screens/home/bloc/home_screen_bloc.dart';
import '../../screens/home/bloc/home_screen_repository.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/profile/bloc/profile_screen_bloc.dart';
import '../../screens/profile/profile_screen.dart';
import 'badge_icon_update.dart';

class TabBarController {
  static StreamController<int> countController =
      StreamController<int>.broadcast();

  TabBarController._privateConstructor();

  static final TabBarController _instance =
      TabBarController._privateConstructor();

  factory TabBarController() {
    return _instance;
  }

  static void dispose() {}
}

class BottomTabBarWidget extends StatefulWidget {
  const BottomTabBarWidget({Key? key}) : super(key: key);

  @override
  _BottomTabBarWidgetState createState() => _BottomTabBarWidgetState();
}

class _BottomTabBarWidgetState extends State<BottomTabBarWidget> {
  int _selectedIndex = 0;
  int categoryIndex = 0;

  @override
  void initState() {
    _selectedIndex = 0;
    _setCartBadge();
    super.initState();
  }

  //to sync cart count on badge.
  void _setCartBadge() async {
    TabBarController.countController.sink.add(appStoragePref.getCartCount());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void moveToCategory(int index) {
    setState(() {
      _selectedIndex = index;
      categoryIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetList = [
      MultiBlocProvider(
        providers: [
          BlocProvider<HomeScreenBloc>(
            create: (context) => HomeScreenBloc(
              repository: HomeScreenRepositoryImp(),
            ),
          ),
        ],
        child: const HomeScreen(),
      ),
      (appStoragePref.getIsTabCategoryView())
          ? MultiBlocProvider(
              providers: [
                BlocProvider<CategoryScreenBloc>(
                  create: (context) => CategoryScreenBloc(
                    repository: CategoryScreenRepositoryImp(),
                  ),
                ),
              ],
              child: const CategoryScreen(),
            )
          : const CategorySearchScreen(),
      MultiBlocProvider(
        providers: [
          BlocProvider<CartScreenBloc>(
            create: (context) => CartScreenBloc(
              repository: CartScreenRepositoryImp(),
            ),
          ),
        ],
        child: const CartScreen(),
      ),
      MultiBlocProvider(
        providers: [
          BlocProvider<ProfileScreenBloc>(
            create: (context) => ProfileScreenBloc(
              repository: ProfileScreenRepositoryImp(),
            ),
          ),
        ],
        child: ProfileScreen(),
      ),
    ];
    return WillPopScope(
      onWillPop: () async {
        Navigator.canPop(context)
            ? Navigator.pop(context)
            : _selectedIndex != 0
                ? setState(() => _selectedIndex = 0)
                : SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: widgetList.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          fixedColor: Theme.of(context).iconTheme.color,
          items: [
            BottomNavigationBarItem(
              label: Utils.getStringValue(context, AppStringConstant.home),
              icon: const Icon(Icons.home_outlined),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.category_outlined),
              label:
                  Utils.getStringValue(context, AppStringConstant.categories),
            ),
            BottomNavigationBarItem(
              icon: const BadgeIconUpdate(),
              label: Utils.getStringValue(context, AppStringConstant.cart),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.account_circle_outlined),
              label: Utils.getStringValue(context, AppStringConstant.account),
            ),
          ],
        ),
      ),
    );
  }
}
