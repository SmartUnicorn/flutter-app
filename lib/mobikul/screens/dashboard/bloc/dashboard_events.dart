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

abstract class DashboardEvent extends Equatable{
  const DashboardEvent();
  @override
  List<Object> get props => [];
}

class DashboardAddressFetchEvent extends DashboardEvent{}

class AddImageEvent extends DashboardEvent{
  final String image;
  final String type;
  const AddImageEvent(this.image,this.type);
}






