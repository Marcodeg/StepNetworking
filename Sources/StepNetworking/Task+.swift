//
//  Task+.swift
//  Networking
//
//  Created by Marco Del Giudice on 10/02/22.
//

import Foundation

extension Task where Failure == Error {
    
    static func retrying(priority: TaskPriority? = nil, maxRetryCount: Int = 3, retryDelay: TimeInterval = 1, operation: @Sendable @escaping () async throws -> Success) -> Task {
        
        Task(priority: priority) {
            for _ in 0..<maxRetryCount {
                do {
                    return try await operation()
                } catch {
                    let oneSecond = TimeInterval(1_000_000_000)
                    let delay = UInt64(oneSecond * retryDelay)
                    try await Task<Never, Never>.sleep(nanoseconds: delay)
                }
            }
            
            try Task<Never, Never>.checkCancellation()
            return try await operation()
        }
    }
}
