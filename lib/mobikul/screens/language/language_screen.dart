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
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_new/mobikul/app_widgets/app_tool_bar.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/screens/language/views/language_item_view.dart';
import '../../app_widgets/AppRestart.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/image_view.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/global_data.dart';
import '../../helper/utils.dart';
import '../../models/homePage/home_page_language.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  _LanguageScreenState createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List<LanguageData>? _listLanguageData = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    _listLanguageData?.addAll(GlobalData.homePageData?.storeData ?? []);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
        appBar: commonAppBar(
            Utils.getStringValue(context, AppStringConstant.language), context,
            isLeadingEnable: true, onPressed: () {
          Navigator.pop(context);
        }),
        body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              // Stack(
              children: <Widget>[
                ListView.builder(
                    itemCount: _listLanguageData?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var item = _listLanguageData?[index];

                      if (item == null && (item?.stores ?? []).isEmpty) {
                        //=============If no child's are found=========//
                        return Container();
                      }

                      return Container(
                        color: Theme.of(context).cardColor,
                        child: ExpansionTile(
                          //==========If sub category have child's=============//
                            initiallyExpanded: false,
                            iconColor: Theme.of(context).iconTheme.color,
                            title: Text(_listLanguageData?[index].name ?? "",
                                style: Theme.of(context).textTheme.headline4),
                            children: [
                              if (_listLanguageData?[index].stores != null)
                                Container(child: expandedTileContent(index))
                            ]),
                      );
                    }),
              ],
            )));
  }

  //=========View after tile expansion===========//
  Widget expandedTileContent(int index) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        // padding: const EdgeInsets.all(AppSizes.spacingGeneric),
        itemCount: (_listLanguageData?[index].stores?.length ?? 0),
        itemBuilder: (BuildContext context, int itemIndex) {
          return InkWell(
            onTap: () {
              if (appStoragePref.getStoreId().toString() != _listLanguageData?[index].stores?[itemIndex].id.toString()) {
                appStoragePref.setStoreCode(_listLanguageData?[index].stores?[itemIndex].code ?? "");
                appStoragePref.setStoreId((_listLanguageData?[index].stores?[itemIndex].id.toString()) ?? "");
                appStoragePref.setCurrencyCode(AppConstant.defaultCurrency);
                Utils.clearRecentProducts();
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.splash, (route) => false);
              }
            },
            child: Container(
              color: Theme.of(context).cardColor,
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.spacingLarge),
                  child: ListTile(
                    title: Text(
                        _listLanguageData?[index].stores?[itemIndex].name ??
                            "",
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1),
                    trailing: (appStoragePref.getStoreCode().toString() == _listLanguageData?[index].stores?[itemIndex].code.toString()
                        && appStoragePref.getStoreId().toString() == _listLanguageData?[index].stores?[itemIndex].id.toString()
                    )
                        ? Icon(
                      Icons.radio_button_checked,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    )
                        : Icon(
                      Icons.radio_button_off,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 20,
                    ),
                  )
              ),
            ),
          );
        });
  }
}
