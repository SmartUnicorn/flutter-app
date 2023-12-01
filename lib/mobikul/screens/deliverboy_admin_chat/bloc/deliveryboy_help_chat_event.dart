

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

abstract class DeliveryboyHelpChatEvent extends Equatable {
  const DeliveryboyHelpChatEvent();

  @override
  List<Object> get props => [];
}

class SellerListFetchEvent extends DeliveryboyHelpChatEvent {
  final String query;
  const SellerListFetchEvent(this.query);
}

class UpdateTokenEvent extends DeliveryboyHelpChatEvent{
  final String userId;
  final String name;
  final String avatar;
  final String accountType;
  final String os;
  final String sellerId;
  const UpdateTokenEvent(this.userId, this.name, this.avatar, this.accountType, this.os, this.sellerId);
}



/*  @Field("userId") String userId,
      @Field("name") String username,
      @Field("avatar") String avatar,
      @Field("token") String token,
      @Field("accountType") String accountType,
      @Field("os") String os,
      @Field("sellerId") String sellerId*/