//
//  Notification.swift
//  store
//
//  Created by Полина Рыфтина on 28.05.2024.
//

import Foundation

struct Notification {
    let id: Int64
    let sender: String
    let reciever: User
    let isRead: Bool
    let type: NotificationType
    let mesagge: String
    let createdDate: Date
    
}

enum NotificationType {
    case remote
    case local
}
