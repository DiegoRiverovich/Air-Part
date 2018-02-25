//
//  FastFilterSearchViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 23.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import MessageUI
//import skpsmtpmessage

class FastFilterSearchViewController: UIViewController, MFMailComposeViewControllerDelegate/*, SKPSMTPMessageDelegate*/ {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var searchItem: UITextField!
    @IBOutlet weak var searcherEmail: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        scrollView.resizeScrollViewContentSize()
        //scrollView.keyboardDismissMode = .interactive
        
        sideMenus()
        customizeNavBar()

    }
    
    @objc private func didTapView(gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction func sendEmail(_ sender: UIButton) {
        /* #Temporary disabled. Enable in new version.
        let mailComposeViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
         
        */
        //sendEmailWithoutClient()
    }
    /*
    func sendEmailWithoutClient() {
        let message = SKPSMTPMessage()
        message.relayHost = "smtp.gmail.com"
        message.login = "
        message.pass = ""
        message.requiresAuth = true
        message.wantsSecure = true
        message.relayPorts = [587]
        message.fromEmail = ""
        message.toEmail = ""
        message.subject = "First subject"//subject
        let messagePart = [kSKPSMTPPartContentTypeKey: "text/plain; charset=UTF-8", kSKPSMTPPartMessageKey: "hello first mail!"]
        message.parts = [messagePart]
        message.delegate = self
        message.send()
    }
    
    func messageSent(_ message: SKPSMTPMessage!) {
        print("Successfully sent email!")
    }
    
    func messageFailed(_ message: SKPSMTPMessage!, error: Error!) {
        print("Sending email failed!")
    }
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ++++++++++++++++++++ Customization funcs
    
    func sideMenus() {
        //if revealViewController() != nil {
        menuButton.target = revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        revealViewController().rearViewRevealWidth = Constants.leftTableWidth
        revealViewController().rightViewRevealWidth = Constants.rightTableWidth
        
        toolButton.target = revealViewController()
        toolButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
        
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        //}
    }
    
    func customizeNavBar() {
        // Icons color
        navigationController?.navigationBar.tintColor = UIColor(red: 255/255, green:
            255/255, blue: 255/255, alpha: 1.0) //UIColor(colorLiteralRed: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        // Background navBar color
        navigationController?.navigationBar.barTintColor = UIColor(red: 0/255, green:
            152/255, blue: 227/255, alpha: 1.0) //UIColor(colorLiteralRed: 0/255, green: 152/255, blue: 227/255, alpha: 1)
        //
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.visibleViewController?.navigationItem.title = "Air-Part"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .title2), NSAttributedStringKey.foregroundColor:UIColor.white ]
        
        // logo
        let image = UIImage(named: "testPNGAirPart+Logo2ph30")
        navigationController?.visibleViewController?.navigationItem.titleView = UIImageView(image: image)
    }
    
    // MARK: ++++++++++++++++++++ Mail config func
    
    func configureMailController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["info@air-part.ru"])
        mailComposerVC.setSubject("Фильтры")
        mailComposerVC.setMessageBody("Фильтры \(searchItem.text ?? "def")", isHTML: false)
        
        return mailComposerVC
    }
    
    // MARK: ++++++++++++++++++++ Error config func
    
    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil)
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        print("FastFilter deinit")
    }

}
