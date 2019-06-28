//
//  ViewController+Interface.swift
//  GetStartedAppToPhone
//
//  Created by Paul Ardeleanu on 12/02/2019.
//  Copyright © 2019 Nexmo. All rights reserved.
//

import Foundation
import NexmoClient


enum CallStatus {
    case unknown
    case initiated
    case inProgress
    case error
    case rejected
    case completed
}


enum InterfaceState {
    case notAuthenticated
    case connecting
    case disconnected
    case loggedIn
    case callInitiated
    case callError
    case inCall
    case callRejected
    case callEnded
}


extension ViewController {
    
    var interfaceState: InterfaceState {
        // not authenticated if no client present
        guard let client = client else {
            return .notAuthenticated
        }
        // Disconnected or currently Connecting
        switch client.connectionStatus {
        case .disconnected:
            return .disconnected
        case .connecting:
            return .connecting
        case .connected: break
        }
        
        // Edge case - connected but user not present
        guard client.user != nil else {
            return .disconnected
        }
        
        guard let call = call else {
            switch callStatus {
            case .unknown:
                return .loggedIn
            case .initiated:
                return .callInitiated
            case .inProgress:
                // this should never happen
                return .loggedIn
            case .error:
                return .callError
            case .rejected:
                return .callRejected
            case .completed:
                return .callEnded
            }
        }
        switch call.myCallMember.status  {
        case .dialling:
            fallthrough
        case .calling:
            fallthrough
        case .started:
            fallthrough
        case .answered:
            return .inCall
        case .completed:
            fallthrough
        case .cancelled:
            return .callEnded
        }
    }
    
    
    func updateInterface() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            self.activityIndicator.stopAnimating()
            self.statusLabel.text = "Ready."
            self.callButton.alpha = 0
            
            switch self.interfaceState {
                
            case .notAuthenticated:
                self.call = nil
                self.statusLabel.text = "Not Authenticated."
                
            case .connecting:
                self.activityIndicator.startAnimating()
                self.statusLabel.text = "Connecting..."
                
            case .disconnected:
                self.statusLabel.text = "Disconnected"
                
            case .loggedIn:
                self.statusLabel.text = "Connected"
                self.callButton.alpha = 1
                self.callButton.setTitle("Call", for: .normal)
                
            case .callInitiated:
                self.statusLabel.text = "Calling..."
                self.callButton.alpha = 1
                self.callButton.setTitle("End Call", for: .normal)
                
            case .inCall:
                self.statusLabel.text = "Speaking..."
                self.callButton.alpha = 1
                self.callButton.setTitle("End call", for: .normal)
                
            case .callError:
                self.statusLabel.text = "Could not call"
                self.callButton.alpha = 1
                self.callButton.setTitle("Call", for: .normal)
                
            case .callRejected:
                self.statusLabel.text = "Call rejected"
                self.callButton.alpha = 1
                self.callButton.setTitle("Call", for: .normal)
                
            case .callEnded:
                self.statusLabel.text = "Call ended."
                self.callButton.alpha = 1
                self.callButton.setTitle("Call", for: .normal)
                
            }
            
            
            //            var message = ""
            //
            //            // Authenticated
            //            switch(client.connectionStatus, client.user) {
            //            case (.disconnected, _):
            //                self.statusLabel.text = "Disconnected"
            //                self.logoutButton.alpha = 1
            //                return
            //            case (.connecting, _):
            //                self.activityIndicator.startAnimating()
            //                self.statusLabel.text = "Connecting"
            //                self.logoutButton.alpha = 1
            //                return
            //            case (.connected, let user):
            //
            //            case (_, _):
            //                self.statusLabel.text = "Unknown state"
            //                self.logoutButton.alpha = 1
            //                return
            //            }
            //
            //            // Not in a call
            //            guard let call = self.call else {
            //                self.callButton.setTitle("Call \(self.user.callee)", for: .normal)
            //                message.append("\nReady...")
            //                self.statusLabel.text = message
            //                return
            //            }
            //
            //            let names: [String] = call.otherCallMembers?.compactMap({ participant -> String? in
            //                return (participant as? NXMCallMember)?.user.name
            //            }) ?? []
            //            self.activityIndicator.startAnimating()
            //            self.statusLabel.text = "Calling \(names.joined(separator: ", "))"
            //            self.callButton.setTitle("End call", for: .normal)
            //            self.logoutButton.alpha = 0
            
        }
    }
    
}
