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

abstract class ProfileScreenEvent extends Equatable{
  const ProfileScreenEvent();

  @override
  List<Object> get props => [];
}

class LogOutDataFetchEvent extends ProfileScreenEvent{

}

class AddImageEvent extends ProfileScreenEvent{
  final String image;
  final String type;
  const AddImageEvent(this.image,this.type);

  @override
  List<Object> get props => [];
}