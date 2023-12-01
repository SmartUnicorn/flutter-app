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

abstract class SigninSignupScreenEvent extends Equatable {
  const SigninSignupScreenEvent();

  @override
  List<Object> get props => [];
}

class LoadingEvent extends SigninSignupScreenEvent {
  const LoadingEvent();
}

class SignupScreenFormDataEvent extends SigninSignupScreenEvent {
  const SignupScreenFormDataEvent();

  @override
  List<Object> get props => [];
}

class ForgotPasswordEvent extends SigninSignupScreenEvent {
  const ForgotPasswordEvent(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class LoginEvent extends SigninSignupScreenEvent {
  const LoginEvent(this.email, this.password);

  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}

class SignUpEvent extends SigninSignupScreenEvent {
  const SignUpEvent(
      this.prefix,
      this.firstName,
      this.middleName,
      this.lastName,
      this.suffix,
      this.dob,
      this.taxvat,
      this.gender,
      this.email,
      this.password,
      this.mobile);

  final String prefix;
  final String firstName;
  final String middleName;
  final String lastName;
  final String suffix;
  final String dob;
  final String taxvat;
  final String gender;
  final String email;
  final String password;
  final String mobile;


  @override
  List<Object> get props => [email, password];
}

class SocialLoginEvent extends SigninSignupScreenEvent {
  const SocialLoginEvent(this.request);

  final SocialLoginModel request;

  @override
  List<Object> get props => [request];
}
