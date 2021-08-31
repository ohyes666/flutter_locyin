import 'package:flutter_locyin/data/model/message_list_entity.dart';

messageListEntityFromJson(MessageListEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = (json['data'] as List).map((v) => MessageListData().fromJson(v)).toList();
	}
	return data;
}

Map<String, dynamic> messageListEntityToJson(MessageListEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['data'] =  entity.data.map((v) => v.toJson()).toList();
	return data;
}

messageListDataFromJson(MessageListData data, Map<String, dynamic> json) {
	if (json['stranger'] != null) {
		data.stranger = MessageListDataStranger().fromJson(json['stranger']);
	}
	if (json['type'] != null) {
		data.type = json['type'].toString();
	}
	if (json['excerpt'] != null) {
		data.excerpt = json['excerpt'].toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at'].toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at'].toString();
	}
	return data;
}

Map<String, dynamic> messageListDataToJson(MessageListData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['stranger'] = entity.stranger.toJson();
	data['type'] = entity.type;
	data['excerpt'] = entity.excerpt;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	return data;
}

messageListDataStrangerFromJson(MessageListDataStranger data, Map<String, dynamic> json) {
	if (json['id'] != null) {
		data.id = json['id'] is String
				? int.tryParse(json['id'])
				: json['id'].toInt();
	}
	if (json['username'] != null) {
		data.username = json['username'].toString();
	}
	if (json['nickname'] != null) {
		data.nickname = json['nickname'].toString();
	}
	if (json['avatar'] != null) {
		data.avatar = json['avatar'].toString();
	}
	if (json['email'] != null) {
		data.email = json['email'].toString();
	}
	if (json['introduction'] != null) {
		data.introduction = json['introduction'].toString();
	}
	if (json['notification_count'] != null) {
		data.notificationCount = json['notification_count'] is String
				? int.tryParse(json['notification_count'])
				: json['notification_count'].toInt();
	}
	if (json['status'] != null) {
		data.status = json['status'].toString();
	}
	if (json['created_at'] != null) {
		data.createdAt = json['created_at'].toString();
	}
	if (json['updated_at'] != null) {
		data.updatedAt = json['updated_at'].toString();
	}
	return data;
}

Map<String, dynamic> messageListDataStrangerToJson(MessageListDataStranger entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['id'] = entity.id;
	data['username'] = entity.username;
	data['nickname'] = entity.nickname;
	data['avatar'] = entity.avatar;
	data['email'] = entity.email;
	data['introduction'] = entity.introduction;
	data['notification_count'] = entity.notificationCount;
	data['status'] = entity.status;
	data['created_at'] = entity.createdAt;
	data['updated_at'] = entity.updatedAt;
	return data;
}