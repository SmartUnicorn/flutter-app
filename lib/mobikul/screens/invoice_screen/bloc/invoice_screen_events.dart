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

abstract class InvoiceScreenEvent extends Equatable{
  const InvoiceScreenEvent();

  @override
  List<Object> get props => [];
}

class InvoiceScreenDataFetchEvent extends InvoiceScreenEvent{
  final String page;
  const InvoiceScreenDataFetchEvent(this.page);
}

class InvoiceDetailsFetchEvent extends InvoiceScreenEvent{
  final String invoiceId;
  const InvoiceDetailsFetchEvent(this.invoiceId);
}

class PrintInvoiceDataEvent extends InvoiceScreenEvent{
  final String? invoiceId;
  final String? increementId;
  const PrintInvoiceDataEvent(this.invoiceId, this.increementId);

  @override
  List<Object> get props => [];
}

