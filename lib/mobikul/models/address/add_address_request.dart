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

class AddAddressRequest {
  String? prefix;
  String? firstName;
  String? middleName;
  String? lastName;
  String? suffix;
  String? email;
  String? telephone;
  String? company;
  String? fax;
  List<String>? street;
  String? city;
  String? postcode;
  String? region_id;
  String? regionName;
  String? country_id;
  String? countryName;
  int? default_billing;
  int? default_shipping;
  int? save_address;


  AddAddressRequest(
      {this.prefix,
        this.firstName,
        this.middleName,
        this.lastName,
        this.suffix,
        this.email,
        this.telephone,
        this.company,
        this.fax,
        this.street,
        this.city,
        this.postcode,
        this.region_id,
        this.regionName,
        this.country_id,
        this.countryName,
        this.default_billing,
        this.default_shipping,
        this.save_address
      });
}