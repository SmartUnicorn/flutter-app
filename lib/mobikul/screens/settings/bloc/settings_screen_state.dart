

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

import 'package:equatable/equatable.dart';

import '../../../models/base_model.dart';

abstract class SettingsScreenState extends Equatable {
  const SettingsScreenState();

  @override
  List<Object?> get props => [];

}


class SettingsScreenInitialState extends SettingsScreenState{}

class SettingsScreenLoadingState extends SettingsScreenState{}

class SettingsScreenSuccessState extends SettingsScreenState{
}

class SettingsScreenErrorState extends SettingsScreenState{
  final String message;
  const SettingsScreenErrorState(this.message);
}

