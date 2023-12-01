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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/screens/profile/views/profile_banner_view.dart';
import 'package:test_new/mobikul/screens/profile/views/profile_menu.dart';
import '../../app_widgets/Tabbar/common_banner_view.dart';
import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_bar.dart';
import '../../app_widgets/app_outlined_button.dart';
import '../../app_widgets/dialog_helper.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_string_constant.dart';
import '../../helper/app_localizations.dart';
import '../../helper/app_storage_pref.dart';
import '../../helper/utils.dart';
import '../../models/account_info/account_info_model.dart';
import '../../models/base_model.dart';
import '../dashboard/views/collapse_appbar.dart';
import 'bloc/profile_screen_bloc.dart';
import 'bloc/profile_screen_events.dart';
import 'bloc/profile_screen_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _profileState();
  }
}

class _profileState extends State<ProfileScreen> {
  bool isUserLogin = false;
  ProfileScreenBloc? profileScreenBloc;
  bool isLoading = false;
  BaseModel? model;
  AccountInfoModel? imageModel;
  bool isDarkMode = false;

  @override
  void initState() {
    profileScreenBloc = context.read<ProfileScreenBloc>();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
        Utils.getStringValue(context, AppStringConstant.account),
        context,
      ),
      body: BlocBuilder<ProfileScreenBloc, ProfileScreenState>(
          builder: (context, currentState) {
        if (currentState is LoadingState) {
          isLoading = true;
        } else if (currentState is LogOutSuccess) {
          isLoading = false;
          model = currentState.baseModel;
          appStoragePref.logoutUser();
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showSuccess(
                currentState.baseModel?.message != ''
                    ? currentState.baseModel?.message ?? ''
                    : Utils.getStringValue(
                        context, AppStringConstant.logOutMessage),
                context);
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.splash, (route) => false);
          });
        } else if (currentState is AddImageState) {
          isLoading = false;
          imageModel = currentState.model;
          if (currentState.model?.success ?? false) {
            var data = appStoragePref.getUserData();
            data?.profileImage = imageModel?.profileImage;
            data?.bannerImage = imageModel?.bannerImage;
            appStoragePref.setUserData(data);
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? '', context);
            });
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.model?.message ?? '', context);
            });
          }
        } else if (currentState is ProfileScreenError) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }
        return (appStoragePref.isLoggedIn() ?? false)
            ? collapseAppBar(context, ProfileBannerView((image, type) {
                profileScreenBloc?.add(AddImageEvent(image, type));
              }), buildUI(), AppSizes.profileIconSize + 100)
            : profileMenu(
                () {
                  profileScreenBloc?.add(LogOutDataFetchEvent());
                },
                AppLocalizations.of(context),
                () {
                  setState(() {});
                });
      }),
    );
  }

  Widget buildUI() {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Stack(children: [
            profileMenu(
                () {
                  profileScreenBloc?.add(LogOutDataFetchEvent());
                },
                AppLocalizations.of(context),
                () {
                  setState(() {});
                }),
            Visibility(visible: isLoading, child: const Loader())
          ]),
          Visibility(
            visible: (appStoragePref.isLoggedIn()),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    DialogHelper.confirmationDialog(
                      Utils.getStringValue(
                          context, AppStringConstant.logoutDescription),
                      context,
                      AppLocalizations.of(context),
                      title: Utils.getStringValue(
                          context, AppStringConstant.logoutTitle),
                      onConfirm: () {
                        profileScreenBloc?.add(LogOutDataFetchEvent());
                      },
                    );
                  },
                  child: Center(
                    child: Text(
                      Utils.getStringValue(context, AppStringConstant.signOut)
                          .toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
