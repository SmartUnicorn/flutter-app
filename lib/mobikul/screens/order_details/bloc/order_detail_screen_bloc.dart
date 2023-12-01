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
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../models/base_model.dart';
import '../../../models/order_details/order_detail_model.dart';
import 'order_detail_screen_repository.dart';

part 'order_detail_event.dart';
part 'order_detail_screen_state.dart';

class OrderDetailsBloc extends Bloc<OrderDetailEvent, OrderDetailState> {
  OrderDetailRepositoryImp? repository;

  OrderDetailsBloc({this.repository}) : super(OrderDetailInitial()) {
    on<OrderDetailEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      OrderDetailEvent event, Emitter<OrderDetailState> emit) async {
    if (event is OrderDetailFetchEvent) {
      try {
        var model = await repository?.getOrderDetails(event.orderId);
        if (model != null) {
          emit(OrderDetailSuccess(model));
        } else {
          emit(OrderDetailError(''));
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderDetailError(error.toString()));
      }
    }
    else if(event is ReorderEvent) {
      try {
        emit(OrderDetailInitial());
        var model = await repository?.reorder(event.incrementId);
        if (model != null) {
          if (model.success == true) {
            emit(ReorderSuccessState(model));
          } else {
            emit(OrderDetailError(''));
          }
        }
      } catch (error, _) {
        print(error.toString());
        emit(OrderDetailError(error.toString()));
      }
    }
  }
}
