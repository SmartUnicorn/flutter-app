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

part of 'splash_screen_bloc.dart';

abstract class SplashScreenEvent extends Equatable{
  const SplashScreenEvent();

  @override
  List<Object> get props => [];
}

class SplashScreenDataFetchEvent extends SplashScreenEvent{

  const SplashScreenDataFetchEvent();

  @override
  List<Object> get props => [];

}

class WalkThroughDataFetchEvent extends SplashScreenEvent{
  const WalkThroughDataFetchEvent();
}