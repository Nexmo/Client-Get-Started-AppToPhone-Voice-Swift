//
//  ViewController.swift
//  GetStartedAppToPhone
//
//  Created by Paul Ardeleanu on 06/02/2019.
//  Copyright © 2019 Nexmo. All rights reserved.
//

import UIKit
import NexmoClient


class ViewController: UIViewController {

    var client: NXMClient?
    var call: NXMCall?
    var callStatus: CallStatus = .unknown
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var callButton: UIButton!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateInterface()
        setupNexmoClient()
    }
    
    
    //MARK: - Setup Nexmo Client
    
    func setupNexmoClient() {
        client = NXMClient(token: Constant.userToken)
        client?.setDelegate(self)
        client?.login()
    }
    
    
    @IBAction func callNumber(_ sender: Any) {
        // call initiated but not yet active
        if callStatus == .initiated && call == nil {
            callStatus = .unknown
            self.call = nil
            updateInterface()
            return
        }
        // start a new call (check if a call already exists)
        guard let call = call else {
            startCall()
            return
        }
        end(call: call)
    }
    
    private func startCall() {
        callStatus = .initiated
        client?.call(["CALLEE_PHONE_NUMBER"], callHandler: .server, delegate: self) { [weak self] (error, call) in
            guard let self = self else { return }
            // Handle create call failure
            guard let call = call else {
                if let error = error {
                    // Handle create call failure
                    print("❌❌❌ call not created: \(error.localizedDescription)")
                } else {
                    // Handle unexpected create call failure
                    print("❌❌❌ call not created: unknown error")
                }
                self.callStatus = .error
                self.call = nil
                self.updateInterface()
                return
            }
            
            // Handle call created successfully.
            // callDelegate's  statusChanged: will be invoked with needed updates.
            call.setDelegate(self)
            self.call = call
            self.updateInterface()
        }
        updateInterface()
    }
    
    private func end(call: NXMCall) {
        call.myCallMember.hangup()
    }
    
}


//MARK:- Client Delegate

extension ViewController: NXMClientDelegate {
    
    func connectionStatusChanged(_ status: NXMConnectionStatus, reason: NXMConnectionStatusReason) {
        print("👁👁👁 connectionStatusChanged - status: \(status.description()) - reason: \(reason.description())")
        updateInterface()
    }
    
}


//MARK:- Call Delegate

extension ViewController: NXMCallDelegate {
    
    func statusChanged(_ member: NXMCallMember) {
        //print("🤙🤙🤙 Call Status changed | member: \(String(describing: member.user.name))")
        print("🤙🤙🤙 Call Status changed | member status: \(String(describing: member.status.description()))")
        
        guard let call = call else {
            // this should never happen
            self.callStatus = .unknown
            self.updateInterface()
            return
        }
        
        // call ended before it could be answered
        if member == call.myCallMember, member.status == .answered, let otherMember = call.otherCallMembers.firstObject as? NXMCallMember, [NXMCallMemberStatus.completed, NXMCallMemberStatus.cancelled].contains(otherMember.status)  {
            self.callStatus = .completed
            self.call?.myCallMember.hangup()
            self.call = nil
        }
        
        // call rejected
        if call.otherCallMembers.contains(member), member.status == .cancelled {
            self.callStatus = .rejected
            self.call?.myCallMember.hangup()
            self.call = nil
        }
        
        // call ended
        if call.otherCallMembers.contains(member), member.status == .completed {
            self.callStatus = .completed
            self.call?.myCallMember.hangup()
            self.call = nil
        }
        
        updateInterface()
    }
    
}


