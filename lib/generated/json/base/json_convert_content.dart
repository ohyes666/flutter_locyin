// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes

// This file is automatically generated. DO NOT EDIT, all your changes would be lost.
import 'package:flutter_locyin/data/model/user_entity.dart';
import 'package:flutter_locyin/generated/json/user_entity_helper.dart';
import 'package:flutter_locyin/data/model/dynamic_list_entity.dart';
import 'package:flutter_locyin/generated/json/dynamic_list_entity_helper.dart';
import 'package:flutter_locyin/data/model/dynamic_detail_entity.dart';
import 'package:flutter_locyin/generated/json/dynamic_detail_entity_helper.dart';

class JsonConvert<T> {
	T fromJson(Map<String, dynamic> json) {
		return _getFromJson<T>(runtimeType, this, json);
	}

  Map<String, dynamic> toJson() {
		return _getToJson<T>(runtimeType, this);
  }

  static _getFromJson<T>(Type type, data, json) {
		switch (type) {
			case UserEntity:
				return userEntityFromJson(data as UserEntity, json) as T;
			case UserData:
				return userDataFromJson(data as UserData, json) as T;
			case DynamicListEntity:
				return dynamicListEntityFromJson(data as DynamicListEntity, json) as T;
			case DynamicListData:
				return dynamicListDataFromJson(data as DynamicListData, json) as T;
			case DynamicListDataUser:
				return dynamicListDataUserFromJson(data as DynamicListDataUser, json) as T;
			case DynamicListDataImages:
				return dynamicListDataImagesFromJson(data as DynamicListDataImages, json) as T;
			case DynamicListLinks:
				return dynamicListLinksFromJson(data as DynamicListLinks, json) as T;
			case DynamicListMeta:
				return dynamicListMetaFromJson(data as DynamicListMeta, json) as T;
			case DynamicListMetaLinks:
				return dynamicListMetaLinksFromJson(data as DynamicListMetaLinks, json) as T;
			case DynamicDetailEntity:
				return dynamicDetailEntityFromJson(data as DynamicDetailEntity, json) as T;
			case DynamicDetailData:
				return dynamicDetailDataFromJson(data as DynamicDetailData, json) as T;
			case DynamicDetailDataUser:
				return dynamicDetailDataUserFromJson(data as DynamicDetailDataUser, json) as T;
			case DynamicDetailDataImages:
				return dynamicDetailDataImagesFromJson(data as DynamicDetailDataImages, json) as T;    }
		return data as T;
	}

  static _getToJson<T>(Type type, data) {
		switch (type) {
			case UserEntity:
				return userEntityToJson(data as UserEntity);
			case UserData:
				return userDataToJson(data as UserData);
			case DynamicListEntity:
				return dynamicListEntityToJson(data as DynamicListEntity);
			case DynamicListData:
				return dynamicListDataToJson(data as DynamicListData);
			case DynamicListDataUser:
				return dynamicListDataUserToJson(data as DynamicListDataUser);
			case DynamicListDataImages:
				return dynamicListDataImagesToJson(data as DynamicListDataImages);
			case DynamicListLinks:
				return dynamicListLinksToJson(data as DynamicListLinks);
			case DynamicListMeta:
				return dynamicListMetaToJson(data as DynamicListMeta);
			case DynamicListMetaLinks:
				return dynamicListMetaLinksToJson(data as DynamicListMetaLinks);
			case DynamicDetailEntity:
				return dynamicDetailEntityToJson(data as DynamicDetailEntity);
			case DynamicDetailData:
				return dynamicDetailDataToJson(data as DynamicDetailData);
			case DynamicDetailDataUser:
				return dynamicDetailDataUserToJson(data as DynamicDetailDataUser);
			case DynamicDetailDataImages:
				return dynamicDetailDataImagesToJson(data as DynamicDetailDataImages);
			}
			return data as T;
		}
  //Go back to a single instance by type
	static _fromJsonSingle<M>( json) {
		String type = M.toString();
		if(type == (UserEntity).toString()){
			return UserEntity().fromJson(json);
		}
		if(type == (UserData).toString()){
			return UserData().fromJson(json);
		}
		if(type == (DynamicListEntity).toString()){
			return DynamicListEntity().fromJson(json);
		}
		if(type == (DynamicListData).toString()){
			return DynamicListData().fromJson(json);
		}
		if(type == (DynamicListDataUser).toString()){
			return DynamicListDataUser().fromJson(json);
		}
		if(type == (DynamicListDataImages).toString()){
			return DynamicListDataImages().fromJson(json);
		}
		if(type == (DynamicListLinks).toString()){
			return DynamicListLinks().fromJson(json);
		}
		if(type == (DynamicListMeta).toString()){
			return DynamicListMeta().fromJson(json);
		}
		if(type == (DynamicListMetaLinks).toString()){
			return DynamicListMetaLinks().fromJson(json);
		}
		if(type == (DynamicDetailEntity).toString()){
			return DynamicDetailEntity().fromJson(json);
		}
		if(type == (DynamicDetailData).toString()){
			return DynamicDetailData().fromJson(json);
		}
		if(type == (DynamicDetailDataUser).toString()){
			return DynamicDetailDataUser().fromJson(json);
		}
		if(type == (DynamicDetailDataImages).toString()){
			return DynamicDetailDataImages().fromJson(json);
		}

		return null;
	}

  //list is returned by type
	static M _getListChildType<M>(List data) {
		if(<UserEntity>[] is M){
			return data.map<UserEntity>((e) => UserEntity().fromJson(e)).toList() as M;
		}
		if(<UserData>[] is M){
			return data.map<UserData>((e) => UserData().fromJson(e)).toList() as M;
		}
		if(<DynamicListEntity>[] is M){
			return data.map<DynamicListEntity>((e) => DynamicListEntity().fromJson(e)).toList() as M;
		}
		if(<DynamicListData>[] is M){
			return data.map<DynamicListData>((e) => DynamicListData().fromJson(e)).toList() as M;
		}
		if(<DynamicListDataUser>[] is M){
			return data.map<DynamicListDataUser>((e) => DynamicListDataUser().fromJson(e)).toList() as M;
		}
		if(<DynamicListDataImages>[] is M){
			return data.map<DynamicListDataImages>((e) => DynamicListDataImages().fromJson(e)).toList() as M;
		}
		if(<DynamicListLinks>[] is M){
			return data.map<DynamicListLinks>((e) => DynamicListLinks().fromJson(e)).toList() as M;
		}
		if(<DynamicListMeta>[] is M){
			return data.map<DynamicListMeta>((e) => DynamicListMeta().fromJson(e)).toList() as M;
		}
		if(<DynamicListMetaLinks>[] is M){
			return data.map<DynamicListMetaLinks>((e) => DynamicListMetaLinks().fromJson(e)).toList() as M;
		}
		if(<DynamicDetailEntity>[] is M){
			return data.map<DynamicDetailEntity>((e) => DynamicDetailEntity().fromJson(e)).toList() as M;
		}
		if(<DynamicDetailData>[] is M){
			return data.map<DynamicDetailData>((e) => DynamicDetailData().fromJson(e)).toList() as M;
		}
		if(<DynamicDetailDataUser>[] is M){
			return data.map<DynamicDetailDataUser>((e) => DynamicDetailDataUser().fromJson(e)).toList() as M;
		}
		if(<DynamicDetailDataImages>[] is M){
			return data.map<DynamicDetailDataImages>((e) => DynamicDetailDataImages().fromJson(e)).toList() as M;
		}

		throw Exception("not found");
	}

  static M fromJsonAsT<M>(json) {
		if (json is List) {
			return _getListChildType<M>(json);
		} else {
			return _fromJsonSingle<M>(json) as M;
		}
	}
}