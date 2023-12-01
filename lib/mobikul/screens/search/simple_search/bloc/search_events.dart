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

abstract class SearchEvent extends Equatable{
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchSuggestionEvent extends SearchEvent{
  final String searchKey;
  const SearchSuggestionEvent(this.searchKey);

}
class InitialSearchSuggestionEvent extends SearchEvent{}

