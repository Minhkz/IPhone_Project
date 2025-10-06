package com.devpro.models;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ChatMessage {
    private String sender;
    private String content;
    private MessageType type;
    private String recipient;
    private String senderRole;
    public enum MessageType {
        CHAT, JOIN, LEAVE, PRIVATE
    }
}
