// This file is "agent.model.dart"
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

// required: associates our `agent.model.dart` with the code generated by Freezed
part 'agent.model.freezed.dart';
// optional: Since our Person class is serializable, we must add this line.
// But if Person was not serializable, we could skip it.
part 'agent.model.g.dart';

@freezed
class AgentModel with _$AgentModel {
  const factory AgentModel({
    required String uid,
    required String name,
    required String description,
    required String imageUrl,
    required Map<int, int> rating,
    required String createdBy,
    required List<String> category,
    required int conversationCount,
    required String systemPrompt,
    required List<String> conversationStarters,
    required List<String> skills,
    required DateTime createdAt,
  }) = _AgentModel;

  factory AgentModel.fromJson(Map<String, Object?> json)
      => _$AgentModelFromJson(json);
}