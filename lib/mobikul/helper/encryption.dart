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

import 'dart:convert';

String generateEncodedApiKey(String input){
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  print(stringToBase64.encode(input));
  return stringToBase64.encode(input);
}
