
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

abstract class ContactUsState {
  const ContactUsState();

  @override
  List<Object?> get props => [];

}

class ContactUsInitialState extends ContactUsState{}

class ContactUsLoadingState extends ContactUsState{}

class ContactUsSuccessState extends ContactUsState{
}

class ContactUsErrorState extends ContactUsState{
  final String message;
  const ContactUsErrorState(this.message);
}


class AddCommentSuccessState extends ContactUsState{
  final BaseModel data;
  const AddCommentSuccessState(this.data);
}

class ContactUsEmptyState extends ContactUsState{

}

