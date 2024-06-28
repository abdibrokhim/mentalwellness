// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'agent.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AgentModelImpl _$$AgentModelImplFromJson(Map<String, dynamic> json) =>
    _$AgentModelImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      rating: (json['rating'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(int.parse(k), (e as num).toInt()),
      ),
      createdBy: json['createdBy'] as String,
      category:
          (json['category'] as List<dynamic>).map((e) => e as String).toList(),
      conversationCount: (json['conversationCount'] as num).toInt(),
      systemPrompt: json['systemPrompt'] as String,
      conversationStarters: (json['conversationStarters'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      skills:
          (json['skills'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$AgentModelImplToJson(_$AgentModelImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'rating': instance.rating.map((k, e) => MapEntry(k.toString(), e)),
      'createdBy': instance.createdBy,
      'category': instance.category,
      'conversationCount': instance.conversationCount,
      'systemPrompt': instance.systemPrompt,
      'conversationStarters': instance.conversationStarters,
      'skills': instance.skills,
      'createdAt': instance.createdAt.toIso8601String(),
    };
