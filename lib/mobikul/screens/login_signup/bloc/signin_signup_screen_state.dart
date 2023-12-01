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

part of 'signin_signup_screen_bloc.dart';

abstract class SigninSignupScreenState extends Equatable {
  const SigninSignupScreenState();

  @override
  List<Object> get props => [];
}

class LoadingState extends SigninSignupScreenState {}

class SignupScreenInitial extends SigninSignupScreenState {}

class SignupScreenFormDataState extends SigninSignupScreenState {
  const SignupScreenFormDataState(this.data);

  final SignUpScreenModel data;
  @override
  List<Object> get props => [];
}

class SignupScreenFormSuccess extends SigninSignupScreenState {
  const SignupScreenFormSuccess(this.data);

  final SignupResponseModel data;

  @override
  List<Object> get props => [];
}

class ForgotPasswordState extends SigninSignupScreenState {
  const ForgotPasswordState(this.data);

  final BaseModel data;


  @override
  List<Object> get props => [data];
}

class LoginState extends SigninSignupScreenState {
  const LoginState(this.data);

  final LoginResponseModel data;


  @override
  List<Object> get props => [data];
}


// ignore: must_be_immutable
class SigninSignupScreenError extends SigninSignupScreenState {
  SigninSignupScreenError(this._message);

  String? _message;

  // ignore: unnecessary_getters_setters
  String? get message => _message;

  // ignore: unnecessary_getters_setters
  set message(String? message) {
    _message = message;
  }
  @override
  List<Object> get props => [];
}

class CompleteState extends SigninSignupScreenState{}

class SignupScreenEmpty extends SigninSignupScreenState {}
