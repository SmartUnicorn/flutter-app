// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_carausel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Carousel _$CarouselFromJson(Map<String, dynamic> json) => Carousel(
      id: json['id'] as String?,
      type: json['type'] as String?,
      label: json['label'] as String?,
      color: json['color'] as String?,
      image: json['image'] as String?,
      productList: (json['productList'] as List<dynamic>?)
          ?.map((e) => ProductTileData.fromJson(e as Map<String, dynamic>))
          .toList(),
      banners: (json['banners'] as List<dynamic>?)
          ?.map((e) => Banners.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredCategories: (json['featuredCategories'] as List<dynamic>?)
          ?.map((e) => FeaturedCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CarouselToJson(Carousel instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'label': instance.label,
      'color': instance.color,
      'image': instance.image,
      'productList': instance.productList,
      'banners': instance.banners,
      'featuredCategories': instance.featuredCategories,
    };
