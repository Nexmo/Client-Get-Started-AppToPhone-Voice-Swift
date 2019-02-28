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
        
    }
    
    
    @IBAction func callNumber(_ sender: Any) {
        
    }
    
    private func startCall() {
        
    }
    
    private func end(call: NXMCall) {
        
    }
    
}


//MARK:- Client Delegate



//MARK:- Call Delegate


