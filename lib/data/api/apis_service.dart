import 'package:dio/dio.dart';
import 'package:flutter_locyin/data/api/apis.dart';
import 'package:flutter_locyin/data/model/chat_message_entity.dart';
import 'package:flutter_locyin/data/model/dynamic_comment_entity.dart';
import 'package:flutter_locyin/data/model/dynamic_detail_entity.dart';
import 'package:flutter_locyin/data/model/dynamic_list_entity.dart';
import 'package:flutter_locyin/data/model/message_list_entity.dart';
import 'package:flutter_locyin/data/model/user_entity.dart';
import 'package:flutter_locyin/utils/dio_manager.dart';
import 'dart:io';
import 'dart:convert';

ApiService _apiService = new ApiService();

ApiService get apiService => _apiService;

class ApiService {

  /// 手机号登录发送短信验证码
  Future<void> sendCodes(Function callback, Function errorCallback,
      String _phone) async {
    FormData formData = new FormData.fromMap({
      "phone": _phone,
    });
    Map params = {
      "phone": _phone,
    };
    BaseNetWork.instance.dio.post(Apis.LOGIN_CODES, data: params).then((
        response) {
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }

  /// 手机号登录
  Future<void> loginBycodes(Function callback, Function errorCallback,
      String _verification_key, String _verification_code) async {
    FormData formData = new FormData.fromMap({
      "verification_key": _verification_key,
      "verification_code": _verification_code,
    });
    BaseNetWork.instance.dio.post(Apis.LOGIN_PHONE, data: formData).then((
        response) {
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 退出登录
  Future<void> logout(Function callback, Function errorCallback) async {
    BaseNetWork.instance.dio.get(Apis.USER_LOGOUT).then((response) {
      callback(response.data);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 获取用户个人信息
  Future<void> getUserInfo(Function callback, Function errorCallback) async {
    await BaseNetWork.instance.dio.get(Apis.USER_INFO).then((response) {
      print(response);
      callback(UserEntity().fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }

  /// 获取广场列表数据
  Future<void> getDynamicList(Function callback, Function errorCallback , int page)async {
    BaseNetWork.instance.dio.get(Apis.DYNAMIC+ "?page="+page.toString()).then((response) {
      callback(
          DynamicListEntity().fromJson(response.data)
      );
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 点赞游记
  Future<void> thumbDynamic(Function callback, Function errorCallback,int _id) async {
    FormData formData = new FormData.fromMap({
      "id": _id,
    });
    /*Map params  ={
      "id": _id,
    };*/
    BaseNetWork.instance.dio.post(Apis.THUMB_DYNAMIC,data: formData).then((response) {
      callback();
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 收藏游记
  Future<void> collectDynamic(Function callback, Function errorCallback,int _id) async {
    FormData formData = new FormData.fromMap({
      "id": _id,
    });
    BaseNetWork.instance.dio.post(Apis.COLLECT_DYNAMIC,data: formData).then((response) {
      callback();
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 获取游记详情
  Future<void> getDynamicDetail(Function callback, Function errorCallback,int _id) async {
    FormData formData = new FormData.fromMap({
      "id": _id,
    });
    BaseNetWork.instance.dio.post(Apis.DYNAMIC, data: formData).then((response) {
      callback(DynamicDetailEntity().fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 获取游记评论列表数据
  Future<void> getDynamicCommentList(Function callback, Function errorCallback , int id,int page)async {
    Map<String,dynamic> formData = {
      "dynamic_id": id,
      "page":page,
    };
    BaseNetWork.instance.dio.get(Apis.DYNAMIC_COMMENT,queryParameters: formData).then((response) {
      callback(
          DynamicCommentEntity().fromJson(response.data)
      );
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 发布评论
  Future<void> publishComment(Function callback, Function errorCallback,String _content ,int _dynamic_id,int _receiver_id,String _receiver_nickname) async {
    FormData formData = new FormData.fromMap({
      "content": _content,
      "dynamic_id": _dynamic_id,
      "receiver_id": _receiver_id,
      "receiver_nickname": _receiver_nickname,
    });
    Map params  ={
      "content": _content,
      "dynamic_id": _dynamic_id,
    };
    BaseNetWork.instance.dio.post(Apis.COMMENT, data: formData).then((response) async {
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 上传图片
  Future<void> uploadImage(Function callback, Function errorCallback , Future<File?>_file,) async {
    File? file = await _file;
    String path = file!.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formdata = FormData.fromMap({
      "file": await MultipartFile.fromFile(path, filename:name)
    });
    await BaseNetWork.instance.dio.post(Apis.UPLOAD_IMAGE,data: formdata).then((response){
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 发布游记
  Future<void> publishDynamic(Function callback, Function errorCallback , String _content,String? _location,String? _latitude,String? _longitude,List<Map<String,String>> _assets,) async {
    Map  map={
      "content": _content.toString(),
      "location": _location.toString(),
      "latitude": _latitude.toString(),
      "longitude": _longitude.toString(),
      "assets": json.encode(_assets),
    };
    await BaseNetWork.instance.dio.post(Apis.PUBLISH_DYNAMIC,data: map).then((response){
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 上传文件
  Future<void> uploadFile(Function callback, Function errorCallback , File _file,) async {
    FormData formdata = FormData.fromMap({
      "file": _file
    });
    await BaseNetWork.instance.dio.post(Apis.UPLOAD_FILE,data: formdata).then((response){
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 初始化聊天室
  Future<void> initMessage(Function callback, Function errorCallback , String _client_id) async {
    FormData formdata = FormData.fromMap({
      "client_id": _client_id.toString(),
    });
    await BaseNetWork.instance.dio.post(Apis.INIT_MESSAGE,data: formdata).then((response){
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 聊天列表
  Future<void> messageList(Function callback, Function errorCallback) async {
    await BaseNetWork.instance.dio.post(Apis.MESSAGE_LIST).then((response){
      callback(MessageListEntity().fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 发消息
  Future<void> sendMessage(Function callback, Function errorCallback ,int _to_id , String _content) async {
    FormData formdata = FormData.fromMap({
      "to_id": _to_id,
      "content": _content.toString(),
    });
    await BaseNetWork.instance.dio.post(Apis.SEND_MESSAGE,data: formdata).then((response){
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 查看聊天记录
  Future<void> messageRecord(Function callback, Function errorCallback , int _id) async {
    FormData formdata = FormData.fromMap({
      "id": _id,
    });
    await BaseNetWork.instance.dio.post(Apis.MESSAGE_RECORD,data: formdata).then((response){
      callback(ChatMessageEntity().fromJson(response.data));
    }).catchError((e) {
      errorCallback(e);
    });
  }
  /// 发消息
  Future<void> updateMessageStatus(Function callback, Function errorCallback , int _status) async {
    FormData formdata = FormData.fromMap({
      "status": _status,
    });
    await BaseNetWork.instance.dio.post(Apis.MESSAGE_STATUS,data: formdata).then((response){
      callback(response);
    }).catchError((e) {
      errorCallback(e);
    });
  }
}