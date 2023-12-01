

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

import 'package:test_new/mobikul/models/catalog/sorting_data.dart';

import '../models/address/address_form_data.dart';
import '../models/checkout/place_order/billing_data_request.dart';

class MutationsData {

  String homePageData(String websiteId, String storeId, String currencyCode, String width, String customerToken, int  quoteId) {
    return """
      query homePageData {
          homePageData(websiteId:$websiteId,storeId:$storeId, currency:"$currencyCode", width:"$width", customerToken:"$customerToken", , quoteId:$quoteId) {
                    message
                    success
                    storeId
                    otherError
                    defaultCurrency
                    themeType
                    allowedCurrencies {
                        label
                        code
                    }
                    tabCategoryView
                    launcherIconType
                    darkAppButtonColor
                    darkAppThemeColor
                    darkAppThemeTextColor
                    darkButtonTextColor
                    darkAppLogo
                    darkSplashImage
                    darkAppLogoDominantColor
                    appButtonColor
                    appThemeColor
                    appThemeTextColor
                    buttonTextColor
                    splashImage
                    appLogo
                    appLogoDominantColor
                    allowIosDownload
                    iosDownloadLink
                    allowAndroidDownload
                    androidDownloadLink
                    showSwatchOnCollection
                    walkthroughVersion
                    priceFormat {
                        pattern
                        precision
                        requiredPrecision
                        decimalSymbol
                        groupSymbol
                        groupLength
                        integerRequired
                    }
                    themeCode
                    categories {
                        id
                        name
                        banner
                        thumbnail
                        hasChildren
                        bannerDominantColor
                        thumbnailDominantColor
                    }
                    featuredCategories {
                        url
                        dominantColor
                        categoryId
                        categoryName
                    }
                    bannerImages {
                        url
                        dominantColor
                        bannerType
                        id
                        name
                    }
                    carousel {
                        id
                        type
                        label
                        productList {
                            reviewCount
                            isInWishlist
                            wishlistItemId
                            typeId
                            entityId
                            linksPurchasedSeparately
                            rating
                            isAvailable
                            price
                            finalPrice
                            formattedPrice
                            formattedFinalPrice
                            name
                            msrpEnabled
                            hasRequiredOptions
                            msrpDisplayActualPriceType
                            groupedPrice
                            priceView
                            minPrice
                            maxPrice
                            formattedMaxPrice
                            formattedMinPrice
                            isNew
                            isInRange
                            thumbNail
                            dominantColor
                            tierPrice
                            formattedTierPrice
                            minAddToCartQty
                            availability
                            arUrl
                            arType
                            arTextureImages
                        }
                        color
                        image
                        dominantColor
                        banners {
                            url
                            dominantColor
                            bannerType
                            id
                            name
                        }
                    }
                    cmsData {
                        id
                        title
                    }
                    storeData {
                        id
                        name
                    }
                    storeData {
                        id
                        name
                        stores {
                            id
                            code
                            name
                        }
                    }
                    currentCurrency
                    wishlistEnable
                    customerEmail
                    cartCount
                    customerBannerImage
                    bannerDominantColor
                    customerProfileImage
                    customerDominantColor
                    sortOrder {
                        id
                        layoutId
                        label
                        position
                        type
                    }
                    websiteData {
                        id
                        name
                        baseUrl
                    }
                   
              }
           }
    """;
  }

  String categoryPageData(String storeId, int categoryId) {
    return """
      query categoryPageData {
          categoryPageData(storeId:$storeId, categoryId:$categoryId) {
              message
              success
              categories {
                  id
                  name
                  banner
                  thumbnail
                  hasChildren
                  bannerDominantColor
                  thumbnailDominantColor
                  childCategories {
                      id
                      name
                      banner
                      thumbnail
                      hasChildren
                      bannerDominantColor
                      thumbnailDominantColor
                  }
              }
              productList {
                  reviewCount
                  isInWishlist
                  wishlistItemId
                  configurableData {
                      attributes {
                          id
                          code
                          label
                          options {
                              id
                              label
                              products
                          }
                          swatchType
                          updateProductPreviewImage
                      }
                      template
                      optionPrices {
                          oldPrice {
                              amount
                          }
                          basePrice {
                              amount
                          }
                          finalPrice {
                              amount
                          }
                          tierPrices {
                              amount
                          }
                          msrpPrice {
                              amount
                          }
                          product
                      }
                      productId
                      chooseText
                      images
                      index
                      swatchData
                  }
                  typeId
                  entityId
                  linksPurchasedSeparately
                  rating
                  isAvailable
                  price
                  finalPrice
                  formattedPrice
                  formattedFinalPrice
                  name
                  msrpEnabled
                  hasRequiredOptions
                  msrpDisplayActualPriceType
                  groupedPrice
                  priceView
                  minPrice
                  maxPrice
                  formattedMaxPrice
                  formattedMinPrice
                  isNew
                  isInRange
                  thumbNail
                  dominantColor
                  tierPrice
                  formattedTierPrice
                  minAddToCartQty
                  availability
                  arUrl
                  arType
                  arTextureImages
              }
              cartCount
              bannerImage {
                  url
                  dominantColor
              }
              smallBannerImage {
                  url
                  dominantColor
              }
          }
      }
    """;
  }

  String productCollection(String storeId,String currency, String type, String id, List<Map<String, String>> filterData, Map<String, String>? sortData, int pageNumber) {
    return """
      query productCollection {
          productCollection(storeId:$storeId, currency:"$currency", type:"$type", id:"$id", pageNumber:$pageNumber, 
          sortData:$sortData, filterData:$filterData
          ) {
              message
              success
              criteriaData
              childCategories {
                  id
                  name
                  hasChildren
              }
              totalCount
              productList {
                  reviewCount
                  isInWishlist
                  wishlistItemId
                  typeId
                  entityId
                  linksPurchasedSeparately
                  rating
                  isAvailable
                  price
                  finalPrice
                  formattedPrice
                  formattedFinalPrice
                  name
                  msrpEnabled
                  hasRequiredOptions
                  msrpDisplayActualPriceType
                  groupedPrice
                  priceView
                  minPrice
                  maxPrice
                  formattedMaxPrice
                  formattedMinPrice
                  isNew
                  isInRange
                  thumbNail
                  dominantColor
                  tierPrice
                  formattedTierPrice
                  minAddToCartQty
                  availability
                  arUrl
                  arType
                  arTextureImages
              }
              cartCount
              layeredData {
                  code
                  label
                  options {
                      id
                      label
                      count
                  }
              }
              sortingData {
                  code
                  label
              }
              banners {
                  bannerImage
                  dominantColor
              }
            
          }
      }
    """;
  }

  String searchSuggestion(String storeId, String searchQuery, String currency) {
    return """
      query searchSuggestion {
          searchSuggestion(storeId:$storeId, searchQuery:"$searchQuery", currency:"$currency") {
              success
              message
              suggestProductArray {
                  products {
                      price
                      thumbnail
                      productId
                      productName
                      specialPrice
                      hasSpecialPrice
                  }
                  tags {
                      label
                      count
                  }
              }
          }
      }
    """;
  }

  String advancedSearchFormData(String storeId) {
    return """
      query advancedSearchFormData {
          advancedSearchFormData(storeId:$storeId) {
            message
            success
            fieldList {
                title
                label
                options {
                    label
                    value
                }
                fieldList
                attributeCode
                maxQueryLength
            }
          }
      }
    """;
  }

  String createAccountFormData(String storeId) {
    return """
      query createAccountFormData {
          createAccountFormData(storeId:$storeId) {
            success
            message
            isPrefixVisible
            isPrefixRequired
            prefixOptions
            prefixHasOptions
            isMiddlenameVisible
            isSuffixVisible
            isSuffixRequired
            suffixOptions
            suffixHasOptions
            isMobileVisible
            isMobileRequired
            isDOBVisible
            isDOBRequired
            isTaxRequired
            isTaxVisible
            isGenderRequired
            isGenderVisible
            dateFormat
          }
      }
    """;
  }

  String createAccount(
      String websiteId,
      String storeId,
      String os,
      String token,
      int quoteId,
      int isSocial,
      String prefix,
      String firstName,
      String middleName,
      String lastName,
      String suffix,
      String dob,
      String taxvat,
      String gender,
      String email,
      String password,
      String mobile
      ) {
    return """
      mutation createAccount {
          createAccount(
            storeId:$storeId, 
            os:"$os",
            token:"$token",
            quoteId:$quoteId,
            isSocial:$isSocial,
            email:"$email",
            dob:"$dob",
            mobile:"$mobile",
            prefix:"$prefix",
            suffix:"$suffix",
            taxvat:"$taxvat",
            gender:"$gender",
            firstName:"$firstName",
            lastName:"$lastName",
            websiteId:$websiteId,
            password:"$password",
            middleName:"$middleName",
            
          ) 
          {
            message
            success
            customerName
            customerEmail
            customerId
            customerToken
            cartCount
            bannerImage
            profileImage
          }
      }
    """;
  }

  String customerLogin(
      String websiteId,
      String storeId,
      String email,
      String password,
      String token,
      int quoteId,
      ) {
    return """
      mutation login {
          login(websiteId:$websiteId, storeId:$storeId, username:"$email", password:"$password", token:"$token" , quoteId:$quoteId) {
            success
            message
            customerEmail
            customerName
            customerId
            customerToken
            cartCount
            profileImage
            bannerImage
          }
      }
    """;
  }

  String logout(
      String storeId,
      String customerToken,
      ) {
    return """
      mutation logout {
          logout(storeId:$storeId, token:"$customerToken") {
            success
            message
          }
      }
    """;
  }

  String forgotPassword(
      String websiteId,
      String storeId,
      String email,
      ) {
    return """
      mutation forgotPassword {
          forgotPassword(websiteId:$websiteId, storeId:$storeId, email:"$email") {
            success
            message
          }
      }
    """;
  }

  String notificationList(String storeId, String width) {
    return """
      query notificationList {
          notificationList(storeId:$storeId, width:"$width") {
            success
            message
            notificationList {
               id
               title
               content
               notificationType
               banner
               dominantColor
               categoryName
               categoryId
               productName
               productType
               productId
            }
          }
      }
    """;
  }

  String getOrdersList(String storeId, String customerToken, int pageNumber, int forDashboard) {
    return """
      query orderList {
          orderList(storeId:$storeId, customerToken:"$customerToken", pageNumber:$pageNumber, forDashboard:$forDashboard) {
            success
            message
            totalCount
            orderList {
                id
                date
                state
                status
                order_id
                item_count
                order_total
                item_image_url
                statusColorCode
                canReorder
            }
          }
      }
    """;
  }

  String reviewList(String storeId, String customerToken, int pageNumber, int forDashboard) {
    return """
      query reviewList {
          reviewList(storeId:$storeId, customerToken:"$customerToken", pageNumber:$pageNumber, forDashboard:$forDashboard) {
            success
            message
            totalCount
            reviewList {
                id
                productId
                productName
                thumbNail
                dominantColor
                customerRating
            }
          }
      }
    """;
  }

  String reviewDetails(String storeId, String customerToken, int reviewId) {
    return """
      query reviewDetails  {
          reviewDetails(storeId:$storeId, customerToken:"$customerToken", reviewId:$reviewId) {
            success
            message
            thumbNail
            productId
            productName
            dominantColor
            ratingData {
                ratingCode
                ratingValue
            }
            reviewDate
            reviewTitle
            reviewDetail
            averageRating
            totalProductReviews
          }
      }
    """;
  }

  String cartDetails(String storeId, String currency, String customerToken, int quoteId) {
    return """
      query cartDetails {
          cartDetails(storeId:$storeId, currency:"$currency", customerToken:"$customerToken", quoteId:$quoteId) {
            message
            success
            minimumAmount
            minimumFormattedAmount
            showThreshold
            canGuestCheckoutDownloadable
            allowMultipleShipping
            items {
                image
                thresholdQty
                remainingQty
                dominantColor
                name
                canMoveToWishlist
                options {
                    optionId
                    label
                    valueIds
                    value
                }
                id
                sku
                qty
                typeId
                price
                subTotal
                finalPrice
                formattedPrice
                formattedFinalPrice
                isInRange
                groupedProductId
                productId
                message
            }
            totalCount
            couponCode
            isVirtual
            crossSellList {
                reviewCount
                isInWishlist
                wishlistItemId
                configurableData {
                    attributes {
                        id
                        code
                        label
                        options {
                            id
                            label
                            products
                        }
                        swatchType
                        updateProductPreviewImage
                    }
                    template
                    optionPrices {
                        oldPrice {
                            amount
                        }
                        basePrice {
                            amount
                        }
                        finalPrice {
                            amount
                        }
                        tierPrices {
                            amount
                        }
                        msrpPrice {
                            amount
                        }
                        product
                    }
                    productId
                    chooseText
                    images
                    index
                    swatchData
                }
                typeId
                entityId
                linksPurchasedSeparately
                rating
                isAvailable
                price
                finalPrice
                formattedPrice
                formattedFinalPrice
                name
                msrpEnabled
                hasRequiredOptions
                msrpDisplayActualPriceType
                groupedPrice
                priceView
                minPrice
                maxPrice
                formattedMaxPrice
                formattedMinPrice
                isNew
                isInRange
                thumbNail
                dominantColor
                tierPrice
                formattedTierPrice
                minAddToCartQty
                availability
                arUrl
                arType
                arTextureImages
            }
            isAllowedGuestCheckout
            cartCount
            totalsData {
                title
                value
                formattedValue
                unformattedValue
            }
            descriptionMessage
            isCheckoutAllowed
            unformattedCartTotal
            cartTotal
            
          }
      }
    """;
  }

  String emptyCart(String storeId, String customerToken, int quoteId,) {
    return """
      mutation emptyCart {
          emptyCart(storeId:$storeId, customerToken:"$customerToken", quoteId:$quoteId) {
            success
            message
          }
      }
    """;
  }

  String removeCartItem(String storeId, String customerToken, int quoteId, String itemId,) {
    return """
      mutation removeCartItem {
          removeCartItem(storeId:$storeId, customerToken:"$customerToken", quoteId:$quoteId, itemId:$itemId) {
            message
            success
            subtotal {
                title
                value
                unformattedValue
            }
            discount {
                title
                value
                unformattedValue
            }
            shipping {
                title
                value
                unformattedValue
            }
            tax {
                title
                value
                unformattedValue
            }
            grandtotal {
                title
                value
                unformattedValue
            }
            cartCount
          }
      }
    """;
  }

  String wishlistToCart(String storeId, String customerToken, String itemId, String productId,String qty,) {
    return """
      mutation wishlistToCart {
          wishlistToCart(storeId:$storeId, customerToken:"$customerToken", itemId:$itemId, productId:$productId, qty:$qty) {
             success
             message
             cartCount
          }
      }
    """;
  }

  String wishlistFromCart(String storeId, String customerToken, String itemId, String productId,String qty,) {
    return """
      mutation wishlistFromCart {
          wishlistFromCart(storeId:$storeId, customerToken:"$customerToken", itemId:$itemId) {
             success
             message
             cartCount
          }
      }
    """;
  }


  String wishList(
      int storeId,
      String customerToken,
      String currencyCode,
      int pageNumber) {
    return """
      query wishlist {
            wishlist(storeId: $storeId, customerToken: "$customerToken", currency:"$currencyCode", pageNumber: $pageNumber) {
                  success
                  message
                  totalCount
                  wishList {
                  id
                  sku
                  name
                  qty
                  price
                  description
                  productId
                  options {
                      label
                      value
                  }
                  reviewCount
                  isInWishlist
                  wishlistItemId
                  typeId
                  entityId
                  linksPurchasedSeparately
                  rating
                  isAvailable
                  price
                  finalPrice
                  formattedPrice
                  formattedFinalPrice
                  name
                  msrpEnabled
                  hasRequiredOptions
                  msrpDisplayActualPriceType
                  groupedPrice
                  priceView
                  minPrice
                  maxPrice
                  formattedMaxPrice
                  formattedMinPrice
                  isNew
                  isInRange
                  thumbNail
                  dominantColor
                  tierPrice
                  formattedTierPrice
                  minAddToCartQty
                  availability
                  arUrl
                  arType
                  arTextureImages
              }
        }
      }
      """;
  }

  /// Wishlist Sharing
  String shareWishlist(int storeId, int websiteId, String token, String emailid, String message) {
    return """
       mutation{
    shareWishlist(storeId:$storeId, websiteId: $websiteId, customerToken: "$token", emails: "$emailid", message: "$message") {
        success
        message
        sentTo
    }
}
      """;
  }

  /// Wishlist MoveToCart
  String moveToCart(int storeId, String token, int itemid, int productid,int qty) {
    return """
          mutation{
    wishlistToCart(storeId: $storeId, itemId: $itemid, customerToken:"$token", productId:$productid, qty: $qty) {
        success
        message
        cartCount
    }
}
      """;
  }

  /// Wishlist AddAllToCart
  String allToCart(int storeId, int websiteId, String customerToken, List<Map<String, String>> itemdata) {
    return """
          mutation{
        allToCart(storeId:$storeId, websiteId:$websiteId, customerToken:"$customerToken", itemData:$itemdata) {
         success
         message
         warning
         cartCount
        }
      }
      """;
  }

  /// Wishlist AddAllToCart
  String removeFromWishlist(int storeId, int websiteId, String token, String itemId) {
    return """
          mutation{
           removeFromWishlist(customerToken:"$token", storeId:$storeId, itemId:$itemId) {
              success
              message
              alreadyDeleted
            }
        }
      """;
  }

  /// Add To Wishlist
  String addToWishlist(int storeId, String customerToken, String productId) {
    return """
          mutation{
             addToWishlist(storeId:$storeId, customerToken:"$customerToken", productId:$productId) {
                message
                success
                itemId
             }
          }
      """;
  }

  /// Address List
  String addressBookData(
      int storeId,
      String customerToken,
      int forDashboard) {
    return """
      query addressBookData {
    addressBookData(storeId:$storeId, customerToken: "$customerToken", forDashboard: $forDashboard) {
        success
        message
        otherError
        shippingAddress {
            value
            id
            addressTitle
        }
        billingAddress {
            value
            id
            addressTitle
        }
        additionalAddress {
            value
            id
            addressTitle
        }
        addressCount
    }
}
      """;
  }


  /// Checkout AddressForm Data
  String checkoutAddressFormData(
      int storeId,
      String customerToken,
      String addressId) {
    return """
      query checkoutAddressFormData {
    checkoutAddressFormData(storeId:$storeId, customerToken:"$customerToken", addressId:$addressId) {
        message
        success
        lastName
        firstName
        addressData {
            isDefaultBilling
            isDefualtShipping
            entity_id
            increment_id
            parent_id
            created_at
            updated_at
            is_active
            city
            company
            fax
            country_id
            firstname
            lastname
            middlename
            postcode
            prifix
            region
            region_id
            street
            suffix
            telephone
            vat_id
            vat_is_valid
            vat_request_date
            vat_request_id
            var_request_success
        }
        isGuest
        address {
            id
            value
        }
        countryData {
            name
            country_id
            isStateRequired
            isZipOptional
            states {
                code
                name
                region_id
            }
        }
        defaultCountry
        streetLineCount
        isCompanyVisible
        isCompanyRequired
        isTelephoneVisible
        isTelephoneRequired
        isFaxVisible
        isFaxRequired
        isPrefixVisible
        isPrefixRequired
        isMiddlenameVisible
        isSuffixVisible
        isSuffixRequired
        isDOBVisible
        isDOBRequired
        isTaxVisible
        isTaxRequired
        isGenderVisible
        isGenderRequired
        isAddressTitleVisible
        isAddressTitleRequired
        prefixValue
        prefixOptions
        prefixHasOptions
        middleName
        suffixValue
        suffixOptions
        suffixHasOptions

    }
}
      """;
  }


  /// Delete Address
  String deleteAddress(String addressId, String token) {
    return """
          mutation{
    deleteAddress(addressId:$addressId, customerToken: "$token") {
        success
        message
        
    }
}
      """;
  }

  /// Save Address
  String saveAddress(
      int storeId,
      String addressId,
      String token,
      String? firstName,
      String? lastName,
      String? city,
      String? region,
      String? telephone,
      String? postcode,
      String? regionId,
      String? countryId,
      String? streetOne,
      String? streetTwo,
      String? streetThree,
      int? defaultBilling,
      int? defaultShipping,
      String? company) {
    return """
      mutation{
        saveAddress(
            customerToken:"$token",
            storeId:$storeId,
            addressId:$addressId,
            addressData:{
                fax: "",
                region: "$region",
                prefix: "",
                suffix: "",
                company: "$company",
                firstName:"$firstName",
                lastName:"$lastName",
                middleName: "",
                address_title: ""
                city:"$city",
                telephone:"$telephone",
                postcode:"$postcode",
                region_id:"$regionId",
                country_id:"$countryId",
                street:[
                "${streetOne??""}"
                "${streetTwo??""}"
                "${streetThree??""}"
                ],
                default_billing:"$defaultBilling",
                default_shipping:"$defaultShipping"
            }
        ) {
            success
            message
          }
      }
    """;
  }

  /// Order Details
  String orderDetails(
      int storeId,
      String customerToken,
      String incrementId) {
    return """
      query orderDetails {
    orderDetails(customerToken:"$customerToken", storeId:$storeId, incrementId:"$incrementId") {
        success
        message
        hasShipments
        hasInvoices
        hasCreditmemo
        customerName
        customerEmail
        state
        orderDate
        incrementId
        statusLabel
        statusColorCode
        canReorder
        orderData {
            itemList {
                name
                productId
                sku
                options {
                    label
                    value
                }
                price
                qty {
                    Ordered
                    Shipped
                    Canceled
                    Refunded
                }
                subTotal
                image
            }
            totals {
                code
                label
                value
                formattedValue
            }
        }
        invoiceList {
            id
            incrementId
            items {
                name
                options {
                    label
                    value
                }
            }
            sku
            price
            qty
            subTotal
            totals {
                code
                label
                value
                formattedValue
            }
        }
        shipmentList {
            id
            incrementId
            items {
                name
                option {
                    label
                    value
                }
                sku
                qty
            }
        }
        creditmemoList {
            incrementId
            items {
                name
                option {
                    label
                    value
                }
                sku
                price
                qty
                subTotal
                discountAmount
                rowTotal
            }
            totals {
                code
                label
                value
                formattedValue
            }
        }
        shippingAddress
        shippingMethod
        billingAddress
        paymentMethod
    }
}
      """;
  }


  /// Order Details
  String invoiceView(
      int storeId,
      String customerToken,
      String invoiceId) {
    return """
      query invoiceView {
    invoiceView(customerToken:"$customerToken", storeId: $storeId, invoiceId: $invoiceId) {
        success
        message
        orderId
        shippingAddress {
            firstname
            lastname
            city
            region
            street
            country
            pincode
        }
        billingAddress {
            firstname
            lastname
            city
            region
            street
            country
            pincode
        }
        shippingMethod {
            title
        }
        paymentMethod {
            title
        }
        itemList {
            id
            name
            productId
            sku
            option {
                label
                value
            }
            qty
            taxAmount
            discountAmount
            price
            subTotal
            rowTotal
        }
        totals {
            title
            label
            value
            formattedValue
        }
    }
}
      """;
  }

  /// Shipment View
  String shipmentView(
      int storeId,
      String customerToken,
      String shipmentId) {
    return """
      query shipmentView {
    shipmentView(customerToken:"$customerToken", storeId:$storeId, shipmentId: $shipmentId) {
        success
        message
        orderId
        itemList {
            id
            name
            sku
            qty
            productId
            option {
                label
                value
            }
        }
        trackingData {
            id
            title
            number
            carrier
        }
    }
}
      """;
  }



  /// Checkout Address
  String checkoutAddress(int storeId, String customerToken, int quoteId) {
    return """
      query checkoutAddress {
          checkoutAddress(storeId:$storeId, customerToken:"$customerToken", quoteId:$quoteId) {
            message
            success
            address {
                value
                id
            }
            firstName
            lastName
            middleName
            prefixValue
            suffixValue
            cartCount
            isVirtual
            streetLineCount
            defaultCountry
            isPrefixVisible
            isPrefixRequired
            prefixHasOptions
            prefixOptions
            isMiddlenameVisible
            isSuffixVisible
            isSuffixRequired
            SuffixHasOptions
            SuffixOptions
            allowToChooseState
          }
      }
    """;
  }

  /// Shipping method
  String shippingMethods(int storeId, String currency, String customerToken, int quoteId, String addressId, String sameAsShipping, AddressDataModel addressDataModel) {
    return """
      query shippingMethods {
          shippingMethods(storeId:$storeId, currency:"$currency", customerToken:"$customerToken", quoteId:$quoteId,
          shippingData: {
            addressId:"$addressId",
            newAddress: {
                saveInAddressBook: "${addressDataModel.saveAddress ?? "0"}",,
                fax: "${addressDataModel.fax ?? ""}",
                city: "${addressDataModel.city ?? ""}",
                region: "${addressDataModel.region ?? ""}",
                prefix: "${addressDataModel.prifix ?? ""}",
                suffix: "${addressDataModel.suffix ?? ""}",
                street: "${addressDataModel.street ?? ""}",
                company: "${addressDataModel.company ?? ""}",
                lastName: "${addressDataModel.lastname ?? ""}",
                postcode: "${addressDataModel.postcode ?? ""}",
                region_id: "${addressDataModel.region_id ?? ""}",
                firstName: "${addressDataModel.firstname ?? ""}",
                telephone: "${addressDataModel.telephone ?? ""}",
                middleName: "${addressDataModel.middlename ?? ""}",
                country_id: "${addressDataModel.country_id ?? ""}",
                address_title: ""
           
            },
            sameAsShipping:"$sameAsShipping"
          }
          ) {
            success
            message
            cartCount
            cartTotal
            shippingMethods {
                isSelected
                title
                method {
                    code
                    label
                    price
                    isSelected
                }
            }
          }
      }
    """;
  }

  /// Review and payment
  String reviewAndPayment(int storeId, String currency, String customerToken, int quoteId, String shippingMethod) {
    return """
      query reviewAndPayment {
          reviewAndPayment(storeId:$storeId, currency:"$currency", customerToken:"$customerToken", quoteId:$quoteId, shippingMethod:"$shippingMethod") {
            success
            message
            cartCount
            billingAddress
            shippingAddress
            shippingMethod
            cartTotal
            paymentMethods {
                code
                title
                extraInformation
                link
                imageUrl
            }
            couponCode
            currencyCode
            orderReviewData {
                items {
                    productName
                    qty
                    unformattedOriginalPrice
                    originalPrice
                    price
                    subTotal
                    thumbnail
                    dominantColor
                    unformattedPrice
                }
                cartTotal
                totals {
                    title
                    value
                    formattedValue
                    unformattedValue
                }
            }
          }
      }
    """;
  }

  /// Place order
  String placeOrder(String storeId, String currency, String customerToken, int quoteId, String paymentMethod, String checkoutMethod, String purchasePoint, BillingDataRequest billingData, AddressDataModel addressDataModel, String token,) {
    return """
      mutation placeOrder {
          placeOrder(storeId:$storeId, currency:"$currency", customerToken:"$customerToken", quoteId:$quoteId, paymentMethod:"$paymentMethod", checkoutMethod:"$checkoutMethod", 
          purchasePoint:"$purchasePoint", 
          billingData:{
            addressId:"${billingData.addressId}",
            newAddress: {
                saveInAddressBook: "${addressDataModel.saveAddress ?? "0"}",
                fax: "${addressDataModel.fax ?? ""}",
                city: "${addressDataModel.city ?? ""}",
                region: "${addressDataModel.region ?? ""}",
                prefix: "${addressDataModel.prifix ?? ""}",
                suffix: "${addressDataModel.suffix ?? ""}",
                street: "${addressDataModel.street ?? ""}",
                company: "${addressDataModel.company ?? ""}",
                lastName: "${addressDataModel.lastname ?? ""}",
                postcode: "${addressDataModel.postcode ?? ""}",
                region_id: "${addressDataModel.region_id ?? ""}",
                firstName: "${addressDataModel.firstname ?? ""}",
                telephone: "${addressDataModel.telephone ?? ""}",
                middleName: "${addressDataModel.middlename ?? ""}",
                country_id: "${addressDataModel.country_id ?? ""}",
                email: "${addressDataModel.email ?? ""}",
                address_title: ""
           
            },
            sameAsShipping:"${billingData.sameAsShipping}"
          }
          token:"$token") 
          {
            message
            success
            cartCount
            showCreateAccountLink
            canReorder
            email
            orderId
            incrementId
            customerDetails {
                guestCustomer
                groupId
                firstname
                middlename
                lastname
                email
            }
          }
      }
    """;
  }

  /// Product Details
  String productPageData(int storeId, String currency, int productId, String customerToken, int quoteId) {
    return """
      query productPageData {
          productPageData(storeId:$storeId, currency:"$currency", productId:$productId, customerToken:"$customerToken", quoteId:$quoteId) {
            message
            success
            arUrl
            arType
            arTextureImages
            reviewCount
            ratingArray
            priceFormat {
                pattern
                precision
                requiredPrecision
                decimalSymbol
                groupSymbol
                groupLength
                integerRequired
            }
            id
            name
            typeId
            productUrl
            guestCanReview
            showPriceDropAlert
            showBackInStockAlert
            isAllowedGuestCheckout
            minPrice
            maxPrice
            formattedMinPrice
            formattedMaxPrice
            price
            finalPrice
            specialPrice
            formattedPrice
            formattedFinalPrice
            formattedSpecialPrice
            msrp
            msrpEnabled
            description
            formattedMsrp
            shortDescription
            msrpDisplayActualPriceType
            availability
            imageGallery {
                isVideo
                videoUrl
                smallImage
                largeImage
                dominantColor
            }
            thumbNail
            dominantColor
            additionalInformation {
                label
                value
            }
            ratingFormData {
                id
                name
                values
            }
            ratingData {
                ratingCode
                ratingValue
            }
            reviewList {
                title
                details
                avgRatings
                ratings {
                    label
                    value
                }
                reviewBy
                reviewOn
            }
            rating
            customOptions {
                option_id
                product_id
                type
                is_require
                sku
                max_characters
                file_extension
                image_size_x
                image_size_y
                sort_order
                default_title
                store_title
                title
                default_price
                default_price_type
                store_price
                store_price_type
                price
                price_type
                decorated_is_first
                decorated_is_odd
                decorated_is_last
                unformatted_default_price
                formatted_default_price
                unformatted_price
                formatted_price
                optionValues {
                    option_type_id
                    option_id
                    sku
                    sort_order
                    default_title
                    store_title
                    title
                    default_price
                    default_price_type
                    store_price
                    store_price_type
                    price
                    price_type
                    formatted_price
                    formatted_default_price
                }
            }
            links {
                title
                linksPurchasedSeparately
                linkData {
                    id
                    price
                    linkTitle
                    formattedPrice
                    url
                    mimeType
                    fileName
                    haveLinkSample
                    linkSampleTitle
                }
            }
            samples {
                hasSample
                title
                linkSampleData {
                    sampleTitle
                    url
                    mimeType
                    fileName
                }
            }
            groupedData {
                name
                id
                isAvailable
                isInRange
                defaultQty
                specialPrice
                foramtedPrice
                thumbNail
                dominantColor
            }
            groupedPrice
            bundleOptions {
                option_id
                parent_id
                required
                position
                type
                default_title
                title
                optionValues {
                    title
                    price
                    isSingle
                    isDefault
                    defaultQty
                    optionValueId
                    foramtedPrice
                    isQtyUserDefined
                }
            }
            priceView
            is_new
            tierPrices
            configurableData {
                attributes {
                    id
                    code
                    label
                    options {
                        id
                        label
                        products
                    }
                    swatchType
                    updateProductPreviewImage
                }
                template
                optionPrices {
                    oldPrice {
                        amount
                    }
                    basePrice {
                        amount
                    }
                    finalPrice {
                        amount
                    }
                    tierPrices {
                        amount
                    }
                    msrpPrice {
                        amount
                    }
                    product
                }
                productId
                chooseText
                images
                index
                swatchData
            }
            cartCount
            isInWishlist
            wishlistItemId
            canGuestCheckoutDownloadable
            isCheckoutAllowed
            isThresholdVisible
            thresholdQtyLeft
            minAddToCartQty
          }
      }
    """;
  }

  /// Product Configurable
  String productConfigurableData(int storeId, String currency, int productId,
      String customerToken, int quoteId) {
    return """
      query productPageData {
          productPageData(storeId:$storeId, currency:"$currency", productId:"$productId", customerToken:"$customerToken", quoteId:"$quoteId") {
            message
            success
            customOptions {
                option_id
                product_id
                type
                is_require
                sku
                max_characters
                file_extension
                image_size_x
                image_size_y
                sort_order
                default_title
                store_title
                title
                default_price
                default_price_type
                store_price
                store_price_type
                price
                price_type
                decorated_is_first
                decorated_is_odd
                decorated_is_last
                unformatted_default_price
                formatted_default_price
                unformatted_price
                formatted_price
                optionValues {
                    option_type_id
                    option_id
                    sku
                    sort_order
                    default_title
                    store_title
                    title
                    default_price
                    default_price_type
                    store_price
                    store_price_type
                    price
                    price_type
                    formatted_price
                    formatted_default_price
                }
            }
            configurableData {
                attributes {
                    id
                    code
                    label
                    options {
                        id
                        label
                        products
                    }
                    swatchType
                    updateProductPreviewImage
                }
                template
                optionPrices {
                    oldPrice {
                        amount
                    }
                    basePrice {
                        amount
                    }
                    finalPrice {
                        amount
                    }
                    tierPrices {
                        amount
                    }
                    msrpPrice {
                        amount
                    }
                    product
                }
                productId
                chooseText
                images
                index
                swatchData
            }
          
            cartCount
         
          }
      }
    """;
  }

  /// Product Updated Data
  String getProductUpdatedData(int storeId, String currency, int productId,
      String customerToken, int quoteId) {
    return """
      query productPageData {
          productPageData(storeId:$storeId, currency:"$currency", productId:"$productId", customerToken:"$customerToken", quoteId:"$quoteId") {
            message
            success
            cartCount
            isInWishlist
            wishlistItemId
            relatedProductList {
                reviewCount
                isInWishlist
                wishlistItemId
                typeId
                entityId
                linksPurchasedSeparately
                rating
                isAvailable
                price
                finalPrice
                formattedPrice
                formattedFinalPrice
                name
                msrpEnabled
                hasRequiredOptions
                msrpDisplayActualPriceType
                groupedPrice
                priceView
                minPrice
                maxPrice
                formattedMaxPrice
                formattedMinPrice
                isNew
                isInRange
                thumbNail
                dominantColor
                tierPrice
                formattedTierPrice
                minAddToCartQty
                availability
                arUrl
                arType
                arTextureImages
            }
            upsellProductList {
                reviewCount
                isInWishlist
                wishlistItemId
                typeId
                entityId
                linksPurchasedSeparately
                rating
                isAvailable
                price
                finalPrice
                formattedPrice
                formattedFinalPrice
                name
                msrpEnabled
                hasRequiredOptions
                msrpDisplayActualPriceType
                groupedPrice
                priceView
                minPrice
                maxPrice
                formattedMaxPrice
                formattedMinPrice
                isNew
                isInRange
                thumbNail
                dominantColor
                tierPrice
                formattedTierPrice
                minAddToCartQty
                availability
                arUrl
                arType
                arTextureImages
            }
          }
      }
    """;
  }

  /// Account Info
  String accountInfoData(int storeId, String customerToken) {
    return """
      query accountInfoData {
          accountInfoData(storeId:$storeId, customerToken:"$customerToken") {
            success
            message
            email
            lastName
            firstName
            isPrefixVisible
            isPrefixRequired
            prefixValue
            prefixHasOptions
            prefixOptions
            middleName
            isMiddlenameVisible
            isSuffixVisible
            isSuffixRequired
            suffixValue        
            suffixHasOptions
            suffixOptions
            isMobileVisible
            isMobileRequired
            isDOBVisible
            isDOBRequired
            DOBValue        
            isTaxVisible
            isTaxRequired
            taxValue        
            isGenderVisible
            isGenderRequired
            genderValue        
            isFaxVisible
            isFaxRequired
            isTelephoneVisible
            isTelephoneRequired
            dateFormat   
         }
      }
    """;
  }

  /// Orders And Returns
  String ordersAndReturnsData(int storeId, String incrementId, String email, String lastName, String zipCode, String type) {
    return """
      query guestView {
          guestView(storeId:$storeId, incrementId:"$incrementId", email:"$email", lastName:"$lastName", zipCode:"$zipCode", type:"$type") {
            success
            message
            orderData {
              itemList {
                name
                sku
                price
                qty
                subTotal
              }
              totals {
                code
                label
                value
                formattedValue
              }
              orderInfo {
                shippingAddress
                shippingMethod
                billingAddress
                paymentMethod
              }
           }  
         }
      }
    """;
  }

  ///Add to Cart
  String addToCart(
      String storeId,
      String customerToken,
      int quoteId,
      String productId,
      int qty,
      Map<String, dynamic>  productParamsJSON,
      List<dynamic> relatedProducts
      ) {
    return """
      mutation addToCart{
          addToCart(storeId:$storeId, customerToken:"$customerToken", 
          quoteId:$quoteId, productId:$productId, qty:$qty, 
          params:${productParamsJSON},
          relatedProducts:${relatedProducts}
          
          ) {
            message
            success
            minimumAmount
            minimumFormattedAmount
            cartCount
            isCheckoutAllowed
            descriptionMessage
            canGuestCheckoutDownloadable
            isAllowedGuestCheckout
            cartTotal
            cartTotalFormattedAmount
            isVirtual
            quoteId
          }
      }
    """;
  }

  ///Reorder
  String reorder(String storeId, String customerToken, String incrementId,) {
    return """
      mutation reOrder {
          reOrder(storeId:$storeId, customerToken:"$customerToken", incrementId:"$incrementId") {
            success
            message
            cartCount
          }
      }
    """;
  }

  /// Cms Page
  String cmsPage(int id) {
    return """
      query cmsData {
          cmsData(id:$id) {
            success
            message
            title
            content
         }
      }
    """;
  }

  ///My Downloadable Products
  String myDownloadsList(int storeId, int pageNumber, String customerToken) {
    return """
      query myDownloadsList {
          myDownloadsList(storeId:$storeId,pageNumber:$pageNumber,customerToken:"$customerToken",) {
            success
            message
            totalCount
            downloadsList {
                incrementId
                isOrderExist
                message
                hash
                date
                state
                status
                statusColorCode
                proName
                remainingDownloads
                canReorder
            }
          }
      }
    """;
  }

  /// Download Product
  String downloadProduct(String hash, String customerToken) {
    return """
      query downloadProduct {
          downloadProduct(hash:"$hash",customerToken:"$customerToken",) {
            success
            message
            mimeType
            url
            fileName
         }
      }
    """;
  }

  String applyCoupon(String storeId, String customerToken, int quoteId, int remove, String couponCode,) {
    return """
      mutation applyCoupon {
          applyCoupon(storeId:$storeId, customerToken:"$customerToken", quoteId:$quoteId, removeCoupon:$remove, couponCode:"$couponCode") {
            message
            success
          }
      }
    """;
  }


  String updateCart(String storeId, String customerToken, int quoteId, List<Map<String, String>> itemIds,) {
    return """
      mutation updateCart {
          updateCart(storeId:$storeId, customerToken:"$customerToken", quoteId:$quoteId, itemData:$itemIds) {
            message
            success
            cartCount
          }
      }
    """;
  }


  String saveAccountInfo(
      String websiteId,
      String storeId,
      String customerToken,
      String prefix,
      String firstName,
      String middleName,
      String lastName,
      String suffix,
      String dob,
      String taxvat,
      int gender,
      String email,
      String mobile,
      String newPassword,
      String currentPassword,
      String confirmPassword,
      int doChangeEmail,
      int doChangePassword,
      ) {
    return """
      mutation saveAccountInfo {
          saveAccountInfo(
            storeId:$storeId, 
            customerToken:"$customerToken", 
            email:"$email",
            dob:"$dob",
            mobile:"$mobile",
            prefix:"$prefix",
            suffix:"$suffix",
            taxvat:"$taxvat",
            gender:$gender,
            firstName:"$firstName",
            lastName:"$lastName",
            middleName:"$middleName",
            newPassword:"$newPassword",
            currentPassword:"$currentPassword",
            confirmPassword:"$confirmPassword",
            doChangeEmail:$doChangeEmail,
            doChangePassword:$doChangePassword,
            
          ) 
          {
            message
            success
            customerName
          
          }
      }
    """;
  }

  /// getWalkThroughData
  String getWalkThroughData(
      int storeId,
      String width) {
    return """
      query walkthrough {
          walkthrough(width:"$width",) {
            message
            success
            walkthroughVersion
            walkthroughData {
                title
                content
                image
                imageDominantColor
                colorCode
            }
         }
      }
    """;
  }


  /// customerCompareList
  String customerCompareList(
      int storeId,
      String currency,
      String customerToken,
      int quoteId
      ) {
    return """
      query customerCompareList {
          customerCompareList(storeId:$storeId, currency:"$currency", customerToken:"$customerToken") {
            message
            success
            productList {
                reviewCount
                isInWishlist
                wishlistItemId
                configurableData {
                    attributes {
                        id
                        code
                        label
                        options {
                            id
                            label
                            products
                        }
                        swatchType
                        updateProductPreviewImage
                    }
                    template
                    optionPrices {
                        oldPrice {
                            amount
                        }
                        basePrice {
                            amount
                        }
                        finalPrice {
                            amount
                        }
                        tierPrices {
                            amount
                        }
                        msrpPrice {
                            amount
                        }
                        product
                    }
                    productId
                    chooseText
                    images
                    index
                    swatchData
                }
                typeId
                entityId
                linksPurchasedSeparately
                rating
                isAvailable
                price
                finalPrice
                formattedPrice
                formattedFinalPrice
                name
                msrpEnabled
                hasRequiredOptions
                msrpDisplayActualPriceType
                groupedPrice
                priceView
                minPrice
                maxPrice
                formattedMaxPrice
                formattedMinPrice
                isNew
                isInRange
                thumbNail
                dominantColor
                tierPrice
                formattedTierPrice
                minAddToCartQty
                availability
                arUrl
                arType
                arTextureImages
            }
            attributeValueList {
                attributeName
                value
            }
      
         }
      }
    """;
  }

  /// addToCompare
  String addToCompare(int storeId, int websiteId, String token, String productId) {
    return """
          mutation{
           addToCompare(customerToken:"$token", storeId:$storeId, productId:$productId)
           {
              success
              message
            }
        }
      """;
  }

  /// removeFromCompare
  String removeFromCompare(int storeId, int websiteId, String token, String productId) {
    return """
          mutation{
           removeFromCompare(customerToken:"$token", storeId:$storeId, productId:$productId)
           {
              success
              message
            }
        }
      """;
  }

  /// deleteAccount
  String deleteAccount(String storeId, String websiteId, String customerToken,
      String email, String password) {
    return """
      mutation deleteAccount {
          deleteAccount(storeId:$storeId, websiteId:$websiteId, customerToken:"$customerToken", password:"$password", confirmPassword:"$password") {
            message
            success
            otherError
          }
      }
    """;
  }

  String saveReview(String storeId, String customerToken, String productId, String nickname, String detail, String title, List<Map<String, String>> ratingData) {
    return """
      mutation saveReview {
          saveReview(storeId:$storeId, customerToken:"$customerToken", productId:$productId, 
          nickname:"$nickname", detail:"$detail", title:"$title", ratings:$ratingData) {
            success
            message
          }
      }
    """;
  }

  String uploadProfilePic(String customerToken, String image, String width, String mFactor) {
    return """
    mutation{
        uploadProfilePic(
        width:"$width",
        mFactor:"$mFactor",
        customerToken:"$customerToken",
        imageName:"profile.png",
        imageEncoded:"data:image/png;base64,$image"
        ){
              success
              message
              url
          }
        }
    """;
  }

  String uploadBannerPic(String customerToken, String image, String width, String mFactor) {
    return """
    mutation{
        uploadBannerPic(
        width:"$width",
        mFactor:"$mFactor",
        customerToken:"$customerToken",
        imageName:"banner.png",
        imageEncoded:"data:image/png;base64,$image"
        ){
              success
              message
              url
          }
        }
    """;
  }

  /// getRatingFormData
  String getRatingFormData(
      int storeId) {
    return """
      query ratingFormData {
          ratingFormData(storeId:$storeId) {
            message
            success
            ratingFormData {
                id
                name
                values
            }
         }
      }
    """;
  }

  /// creditView
  String getCreditView(
      int storeId,
      String customerToken,
      String creditMemoId) {
    return """
      query creditView {
        creditView(customerToken:"$customerToken", storeId: $storeId, creditMemoId: "$creditMemoId") {
            success
            message
            orderId
            shippingAddress {
                firstname
                lastname
                city
                region
                street
                country
                pincode
            }
            billingAddress {
                firstname
                lastname
                city
                region
                street
                country
                pincode
            }
            shippingMethod {
                title
            }
            paymentMethod {
                title
            }
            itemList {
                id
                name
                productId
                sku
                option {
                    label
                    value
                }
                qty
                taxAmount
                discountAmount
                price
                subTotal
                rowTotal
            }
            totals {
                title
                label
                value
                formattedValue
            }
        }
      }
      """;
  }

  ///contact
  String contact(String storeId, String name, String email, String telephone, String comment) {
    return """
      mutation contact {
          contact(storeId:$storeId, name:"$name", email:"$email", 
          comment:"$comment", telephone:"$telephone") {
            success
            message
          }
      }
    """;
  }

  String getCartCount(String websiteId, String storeId, String currencyCode, String width, String customerToken, int  quoteId) {
    return """
      query homePageData {
          homePageData(websiteId:$websiteId,storeId:$storeId, currency:"$currencyCode", width:"$width", customerToken:"$customerToken", , quoteId:$quoteId) {
                    message
                    success
                    cartCount
              }
           }
    """;
  }

  String printInvoice(String storeId,String customerToken, String? invoiceId, String? increementId) {
    return """
      query printInvoice {
          printInvoice(
            storeId:$storeId,
            customerToken:"$customerToken",
            invoiceId: $invoiceId,
            incrementId: "$increementId",
            )
            {
                    success
                    message
                    url
            }
}
    """;
  }


// Delivery Boy Details

  /// Order Details
  String getDeliveryBoyDetails(
      String storeId,
      String incrementId) {
    return """
    query {
    GetOrderInfo(
        storeId: $storeId
        incrementId: "$incrementId"
    ){
        success
        message
        assignedDeliveryBoyDetails{
            name
            email
            status
            mobileNumber
            address
            deliveryBoyLat
            deliveryBoyLong
            vehicleType
            onlineStatus
            vehicleNumber
            picked
            products
            isEligibleForDeliveryBoy
            customerId
            rating
            avatar
            id
            otp
            sellerId
        }
        adminAddress
    }
}

    """;
  }

  /// Order Details
  String getDeliveryBoyLocationDetails(
      String storeId,
      int? deliveryboyId) {
    return """
    query  {
    GetLocation(
    storeId:$storeId
    deliveryboyId: $deliveryboyId
    ){
    success
    message
    latitude
    longitude
    }
    }
    """;
  }

  // DeliveryBoy AddReview
  String saveDeliveryBoyAddReview(String? storeId, String? title, int? rating, int? customerId,String? comment,int? deliveryboyId,String? orderId,String? nickName) {
    return """
      mutation AddReview {
              AddReview(
                  title: "$title",
                  storeId: $storeId,
                  rating: $rating,
                  customerId: $customerId,
                  comment: "$comment",
                  deliveryboyId: $deliveryboyId,
                  orderId: "$orderId"
              ){
                  success
                  message
              }
      }
    """;
  }


}

