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
import 'package:test_new/mobikul/screens/search/simple_search/bloc/search_events.dart';
import 'package:test_new/mobikul/screens/search/simple_search/bloc/search_repository.dart';
import 'package:test_new/mobikul/screens/search/simple_search/bloc/search_state.dart';

class SearchScreenBloc extends Bloc<SearchEvent,SearchState>{
  SearchRepository? repository;

  SearchScreenBloc({this.repository}) : super(SearchInitialState()){
    on<SearchEvent>(mapEventToState);
  }

  @override
  void mapEventToState(
      SearchEvent event, Emitter<SearchState> emit) async {
    if(event is InitialSearchSuggestionEvent){
      emit(SearchInitialState());
      try {
        var model = await repository?.getSearchSuggestion("");
        if (model != null) {
          emit( SearchScreenSuccess(model));
        } else {
          emit(SearchScreenError(''));
        }
      } catch (error, sT) {
        print(sT.toString());
        emit(SearchScreenError(error.toString()));
      }
    }
    else if (event is SearchSuggestionEvent) {
      emit(SearchInitialState());
      try {
        var model = await repository?.getSearchSuggestion(event.searchKey);
        if (model != null) {
          emit( SearchScreenSuccess(model));
        } else {
          emit(SearchScreenError(''));
        }
      } catch (error, sT) {
        print(sT.toString());
        emit(SearchScreenError(error.toString()));
      }
    }
  }
}