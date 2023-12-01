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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/screens/settings/bloc/settings_screen_event.dart';
import 'package:test_new/mobikul/screens/settings/bloc/settings_screen_repository.dart';
import 'package:test_new/mobikul/screens/settings/bloc/settings_screen_state.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_event.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_repository.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_state.dart';

class SettingsScreenBloc extends Bloc<SettingsScreenEvent,SettingsScreenState>{
  SettingsScreenRepository? repository;

  SettingsScreenBloc({this.repository}) : super(SettingsScreenInitialState()){
    on<SettingsScreenEvent>(mapEventToState);
  }


  void mapEventToState(
      SettingsScreenEvent event,
      Emitter<SettingsScreenState> emit,
      ) async {

  }
}