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

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:test_new/mobikul/screens/login_signup/bloc/signin_signup_screen_repository.dart';

import '../../../models/base_model.dart';
import '../../../models/login_signup/login_response_model.dart';
import '../../../models/login_signup/sign_up_screen_model.dart';
import '../../../models/login_signup/signup_response_model.dart';
import '../../../models/login_signup/social_login_model.dart';

part 'signin_signup_screen_event.dart';

part 'signin_signup_screen_state.dart';

class SigninSignupScreenBloc
    extends Bloc<SigninSignupScreenEvent, SigninSignupScreenState> {
  SigninSignupScreenRepository? repository;

  SigninSignupScreenBloc({this.repository}) : super(SignupScreenInitial()) {
    on<SigninSignupScreenEvent>(mapEventToState);
  }

  void mapEventToState(
      SigninSignupScreenEvent event,
      Emitter<SigninSignupScreenState> emit,
      ) async {
    if (event is SignUpEvent) {
      try {
        var model =
        await repository?.signUp(
            event.prefix,
            event.firstName,
            event.middleName,
            event.lastName,
            event.suffix,
            event.dob,
            event.taxvat,
            event.gender,
            event.email,
            event.password,
            event.mobile
        );
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is SignupScreenFormDataEvent) {
      try {
        var model = await repository?.signUpFormData();
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormDataState(model));
          } else {
            emit(SigninSignupScreenError(model?.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is LoginEvent) {
      try {
        var model = await repository?.login(event.email, event.password);
        if (model != null) {
          if (model.success ?? false) {
            emit(LoginState(model));
          } else {
            emit(SigninSignupScreenError(model?.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is ForgotPasswordEvent) {
      try {
        var model = await repository?.forgotPassword(event.email);
        if (model != null) {
          if (model.success ?? false) {
            emit(ForgotPasswordState(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    } else if (event is SocialLoginEvent) {
      // emit(LoadingState());
      print("TEST_LOG==> SocialLoginEvent ==> ${event.request.email}");
      try {
        var model = await repository?.socialLogin(event.request);
        if (model != null) {
          if (model.success ?? false) {
            emit(SignupScreenFormSuccess(model));
          } else {
            emit(SigninSignupScreenError(model.message));
          }
        } else {
          emit(SigninSignupScreenError(""));
        }
      } catch (error, _) {
        emit(SigninSignupScreenError(error.toString()));
      }
      await Future.delayed(const Duration(seconds: 3), () {
        emit(CompleteState());
      });
    }
  }
}
