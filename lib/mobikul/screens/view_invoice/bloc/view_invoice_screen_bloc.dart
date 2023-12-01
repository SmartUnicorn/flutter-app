
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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_event.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_screen_repository.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_screen_state.dart';


class ViewInvoiceBloc extends Bloc<ViewInvoiceEvent, ViewInvoiceState> {
  ViewInvoiceScreenRepositoryImp? repository;

  ViewInvoiceBloc({this.repository}) : super(ViewInvoiceInitial()) {
    on<ViewInvoiceEvent>(mapEventToState);
  }

  void mapEventToState(
      ViewInvoiceEvent event, Emitter<ViewInvoiceState> emit) async {
    if (event is ViewInvoiceDetailFetchEvent) {
      emit(ViewInvoiceInitial());
      try {
        var model = await repository?.getInvoiceView(event.viewInvoiceItemsId);
        if (model != null) {
          emit(ViewInvoiceSuccess(model));
        } else {
          emit(const ViewInvoiceError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ViewInvoiceError(error.toString()));
      }
    }

    if (event is PrintInvoiceViewDataEvent) {
      emit(ViewInvoiceInitial());
      try {
        var model = await repository?.printInvoice(event.invoiceId, event.increementId);
        if (model != null) {
          emit(PrintInvoiceSuccess(model));
        } else {
          emit(const ViewInvoiceError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(ViewInvoiceError(error.toString()));
      }
    }


  }
}
