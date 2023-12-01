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


abstract class LanguageScreenState extends Equatable {
  const LanguageScreenState();

  @override
  List<Object> get props => [];
}

class LanguageInitialState extends LanguageScreenState{}

class LanguageLoadingState extends LanguageScreenState{}

class LanguageSuccessState extends LanguageScreenState{
}

class LanguageErrorState extends LanguageScreenState{
  final String message;
  const LanguageErrorState(this.message);

  @override
  List<Object> get props => [];
}


