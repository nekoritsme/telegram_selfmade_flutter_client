# telegram_selfmade_flutter_client

Selfmade flutter client pet-project

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Notes (might update with time):

The TDLib wrapper I'm using is from ivk1800/tdlib-dart, which is deprecated. To receive messages properly, I modified the fromJson method in both message.dart and chat_permissions.dart. (I should note that I don't have a complete understanding of the changes I just adjusted what was necessary to make it work.)

message.dart

```
static Message? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Message(
      id: json['id'] as int? ?? 0,
      senderId: MessageSender.fromJson(json['sender_id'] as Map<String, dynamic>?)!,
      chatId: json['chat_id'] as int? ?? 0,
      sendingState: MessageSendingState.fromJson(json['sending_state'] as Map<String, dynamic>?),
      schedulingState: MessageSchedulingState.fromJson(json['scheduling_state'] as Map<String, dynamic>?),
      isOutgoing: json['is_outgoing'] as bool? ?? false,
      isPinned: json['is_pinned'] as bool? ?? false,
      isFromOffline: json['is_from_offline'] as bool? ?? false,
      canBeSaved: json['can_be_saved'] as bool? ?? false,
      hasTimestampedMedia: json['has_timestamped_media'] as bool? ?? false,
      isChannelPost: json['is_channel_post'] as bool? ?? false,
      isTopicMessage: json['is_topic_message'] as bool? ?? false,
      containsUnreadMention: json['contains_unread_mention'] as bool? ?? false,
      date: json['date'] as int? ?? 0,
      editDate: json['edit_date'] as int? ?? 0,
      forwardInfo: MessageForwardInfo.fromJson(json['forward_info'] as Map<String, dynamic>?),
      importInfo: MessageImportInfo.fromJson(json['import_info'] as Map<String, dynamic>?),
      interactionInfo: MessageInteractionInfo.fromJson(json['interaction_info'] as Map<String, dynamic>?),
      unreadReactions: List<UnreadReaction>.from(
          ((json['unread_reactions'] as List<dynamic>?) ?? []).map((item) => UnreadReaction.fromJson(item))
      ),
      factCheck: FactCheck.fromJson(json['fact_check'] as Map<String, dynamic>?),
      replyTo: MessageReplyTo.fromJson(json['reply_to'] as Map<String, dynamic>?),
      messageThreadId: json['message_thread_id'] as int? ?? 0,
      savedMessagesTopicId: json['saved_messages_topic_id'] as int? ?? 0,
      selfDestructType: MessageSelfDestructType.fromJson(json['self_destruct_type'] as Map<String, dynamic>?),
      selfDestructIn: (json['self_destruct_in'] as num?)?.toDouble() ?? 0.0,
      autoDeleteIn: (json['auto_delete_in'] as num?)?.toDouble() ?? 0.0,
      viaBotUserId: json['via_bot_user_id'] as int? ?? 0,
      senderBusinessBotUserId: json['sender_business_bot_user_id'] as int? ?? 0,
      senderBoostCount: json['sender_boost_count'] as int? ?? 0,
      authorSignature: json['author_signature'] as String?,
      mediaAlbumId: int.tryParse(json['media_album_id']?.toString() ?? '') ?? 0,
      effectId: int.tryParse(json['effect_id']?.toString() ?? '') ?? 0,
      hasSensitiveContent: json['has_sensitive_content'] as bool? ?? false,
      restrictionReason: json['restriction_reason'] as String? ?? '',
      content: MessageContent.fromJson(json['content'] as Map<String, dynamic>?)!,
      replyMarkup: ReplyMarkup.fromJson(json['reply_markup'] as Map<String, dynamic>?),
    );
  }
```

char_permissions.dart
```
static ChatPermissions? fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return null;
    }

    return ChatPermissions(
      canSendBasicMessages: (json['can_send_basic_messages'] as bool?) ?? false,
      canSendAudios: (json['can_send_audios'] as bool?) ?? false,
      canSendDocuments: (json['can_send_documents'] as bool?) ?? false,
      canSendPhotos: (json['can_send_photos'] as bool?) ?? false,
      canSendVideos: (json['can_send_videos'] as bool?) ?? false,
      canSendVideoNotes: (json['can_send_video_notes'] as bool?) ?? false,
      canSendVoiceNotes: (json['can_send_voice_notes'] as bool?) ?? false,
      canSendPolls: (json['can_send_polls'] as bool?) ?? false,
      canSendOtherMessages: (json['can_send_other_messages'] as bool?) ?? false,
      canAddLinkPreviews: (json['can_add_link_previews'] as bool?) ?? false,
      canChangeInfo: (json['can_change_info'] as bool?) ?? false,
      canInviteUsers: (json['can_invite_users'] as bool?) ?? false,
      canPinMessages: (json['can_pin_messages'] as bool?) ?? false,
      canCreateTopics: (json['can_create_topics'] as bool?) ?? false,
    );
  }
```
