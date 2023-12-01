import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:test_new/mobikul/app_widgets/app_alert_message.dart';
import 'package:test_new/mobikul/app_widgets/app_bar.dart';
import 'package:test_new/mobikul/app_widgets/dialog_helper.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/generic_methods.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  PaymentWebView(
    this.initialUrl,
    this.callBack, {
    this.success,
    this.failure,
    this.cancel,
  });

  List<String>? success;
  List<String>? cancel;
  List<String>? failure;
  Function(bool, String?, {String? successUrl}) callBack;
  String initialUrl;

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  AppLocalizations? _localizations;

  var loadData = 0.0;

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DialogHelper.confirmationDialog(
          AppStringConstant.cancelPayment,
          context,
          _localizations,
          onConfirm: () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoutes.cart, (Route<dynamic> route) => false);
          },
        );
        return false;
      },
      child: Scaffold(
        appBar: commonAppBar(
          GenericMethods.getStringValue(
              context, AppStringConstant.paymentMethods),
          context,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextButton(
                onPressed: () {
                  DialogHelper.confirmationDialog(
                    GenericMethods.getStringValue(
                        context, AppStringConstant.cancelPayment),
                    context,
                    _localizations,
                    onConfirm: () {
                      SchedulerBinding.instance?.addPostFrameCallback((_) {
                        dispose();
                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.cart, (Route<dynamic> route) => false);
                      });
                    },
                  );
                },
                child: Text(
                  _localizations?.translate(AppStringConstant.cancel) ?? '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: [
              WebView(
                initialUrl: widget.initialUrl,
                javascriptMode: JavascriptMode.unrestricted,
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.contains(widget.success?[0] ?? '')) {
                    var uri = Uri.dataFromString(request.url);
                    widget.callBack(
                        true, uri.queryParameters['confirm_message'],
                        successUrl: request.url);
                  } else if (request.url.contains(widget.failure?[0] ?? '') ||
                      request.url.contains(widget.failure?[1] ?? '')) {
                    var uri = Uri.dataFromString(request.url);
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.cart,
                        (Route<dynamic> route) => false);
                    AlertMessage.showError(
                        GenericMethods.getStringValue(
                                context, AppStringConstant.cancelPayment) ??
                            '',
                        context);
                    // widget.callBack(
                    //     false, uri.queryParameters['error_message']);
                  } else if (request.url.contains(widget.cancel?[0] ?? '') ||
                      request.url.contains(widget.cancel?[1] ?? '')) {
                    var uri = Uri.dataFromString(request.url);
                    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.cart,
                        (Route<dynamic> route) => false);
                    AlertMessage.showError(
                        GenericMethods.getStringValue(
                                context, AppStringConstant.cancelPayment) ??
                            '',
                        context);
                    // widget.callBack(
                    //     false,
                    //     (uri.queryParameters.containsKey('error_message'))
                    //         ? uri.queryParameters['error_message']
                    //         : AppStringConstant.orderCanceled);
                  }

                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                },
                onProgress: (value) {
                  setState(() {
                    loadData = value / 100;
                  });
                },
                gestureNavigationEnabled: true,
              ),
              Positioned(
                  width: MediaQuery.of(context).size.width / 1,
                  top: 0,
                  child: Visibility(
                      visible: loadData < 1,
                      child: const LinearProgressIndicator(
                        // value: loadData,
                        color: Colors.grey,
                        backgroundColor: Colors.red,
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
