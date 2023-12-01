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

abstract class ViewInvoiceEvent extends Equatable{
  const ViewInvoiceEvent();

  @override
  List<Object> get props => [];
}

class ViewInvoiceFetchEvent extends ViewInvoiceEvent{
  const ViewInvoiceFetchEvent();
}


class PrintInvoiceViewDataEvent extends ViewInvoiceEvent{
  final String? invoiceId;
  final String? increementId;
  const PrintInvoiceViewDataEvent(this.invoiceId, this.increementId);

  @override
  List<Object> get props => [];
}


class ViewInvoiceDetailFetchEvent extends ViewInvoiceEvent{
  final String viewInvoiceItemsId;
  const ViewInvoiceDetailFetchEvent(this.viewInvoiceItemsId);
}

