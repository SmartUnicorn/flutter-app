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
import 'package:test_new/mobikul/models/order_details/order_detail_model.dart';

import '../../../models/printInvoiceView/print_invoice_model.dart';

abstract class InvoiceScreenState extends Equatable {
  const InvoiceScreenState();

  @override
  List<Object> get props => [];
}

class InvoiceScreenInitial extends InvoiceScreenState{}

class InvoiceScreenSuccess extends InvoiceScreenState{
  final InvoiceListData invoiceListData;
  const InvoiceScreenSuccess(this.invoiceListData);
}

class PrintInvoiceSuccess extends InvoiceScreenState{
  final PrintInvoiceModel printInvoiceModel;
  const PrintInvoiceSuccess(this.printInvoiceModel);
}

class InvoiceScreenError extends InvoiceScreenState{
  final String message;
  const InvoiceScreenError(this.message);
}

class InvoiceScreenEmptyState extends InvoiceScreenState{}


