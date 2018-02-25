//
//  ChatViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 30.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var messageTextField: UITextField!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    
    var userOnline: String?
    var userOnlineAdmin: String?
    var userOnlineId: String?
    var chatUser: User?
    //var onlineUser: User?
    var messages = [Message]()
    var myMessages = [Message]()
    var timer: Timer?
    
    @IBAction func sendMessage(_ sender: UIButton) {
        //print(messageTextField.text ?? " ")
        sendMessage()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
        tableView.delegate = self
        tableView.dataSource = self
        messageTextField.delegate = self
        

        
        onlineOfflineUser()
        
        sideMenus()
        customizeNavBar()
        
        updateUI()
        //observeMessages()
        //observerUserMessages()
        
        scrollByTimer()
        
        setupKeyboardObservers()
        
        tableView.keyboardDismissMode = .interactive
        
        uploadImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleUploadTap)))
        uploadImageView.isUserInteractionEnabled = true
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    deinit {
        print("ChatviewContdeinit")
    }
    
    // MARK: Upload image tap gesture
    
    @objc func handleUploadTap() {
        //print("upload image")
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info["UIImagePickerControllerDitedImage"] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker {
            uploadToFirebaseStorageUsingImage(image: selectedImage)
        }
        
        dismiss(animated: true, completion: nil)
        
        print("image selected")
    }
    
    func uploadToFirebaseStorageUsingImage(image: UIImage) {
        let imageName = NSUUID().uuidString
        let ref = Storage.storage().reference().child("message_image").child(imageName)
        
        if let uploadData = UIImageJPEGRepresentation(image, 0.2) {
            ref.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil {
                    print("Failed upload image:", error!)
                    return
                }
                
                if let imageUrl = metadata?.downloadURL()?.absoluteString {
                    self.sendMessageWithImageUrl(imageUrl: imageUrl)
                }
            })
        }
    }
    
    private func sendMessageWithImageUrl(imageUrl: String) {
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toUserId = chatUser?.id ?? "air-part"
        var fromUserId = ""
        if userOnlineAdmin == "false" {
            fromUserId = userOnlineId!
        } else {
            fromUserId = "air-part"
        }
        let userOnlineName = userOnline!
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let values = ["imageUrl" : imageUrl, "to" : "air-part", "fromId" : fromUserId , "toId" : toUserId, "fromName" : userOnlineName, "timestamp" : timestamp ] as [String : Any]
        //childRef.updateChildValues(values)
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            
            let userMessagesRef = Database.database().reference().child("user-messages").child(fromUserId)
            let messageId = childRef.key
            userMessagesRef.updateChildValues([messageId : 1])
            
            let recipientUserMessageRef = Database.database().reference().child("user-messages").child(toUserId)
            recipientUserMessageRef.updateChildValues([messageId : 1])
        }
        
        messageTextField.text = nil
        scrollByTimer()
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: Setup keyboard observers
    
    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil )
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // Observers functions
    @objc func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardHeight = keyboardFrame.height
        
        // define duration for animation
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        for constraint in view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "textStackViewBottomConstrain" {
                constraint.constant = keyboardHeight
                //print("set appear new height")
                
                // appear keyboard animated
                UIView.animate(withDuration: keyboardDuration!, animations: { 
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    // Observers functions
    @objc func keyboardWillHide(notification: NSNotification) {
        
        // define duration for animation
        let keyboardDuration = (notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
        
        for constraint in view.constraints as [NSLayoutConstraint] {
            if constraint.identifier == "textStackViewBottomConstrain" {
                constraint.constant = 3
                //print("set hide new height")
                
                // appear keyboard animated
                UIView.animate(withDuration: keyboardDuration!, animations: {
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    
    // MARK: Scroll to bottom func by timer
    func scrollByTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(scrollToBottom2), userInfo: nil, repeats: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Invalidate timer(Timer)
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func updateUI() {
        userNameLabel.text = chatUser?.name ?? " "
    }
    
    // observe user-messages
    
    func observerUserMessages() {
        if userOnlineId != nil {
            
            if userOnlineAdmin == "false" {
                
                let ref = Database.database().reference().child("user-messages").child(userOnlineId!)
                ref.observe(.childAdded, with: { [weak self] (snapshot) in
                    
                    let messageId = snapshot.key
                    let messagesRefference = Database.database().reference().child("messages").child(messageId)
                    
                    messagesRefference.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                        
                        self?.sortObservedMessagesForUser(snapshot: snapshot)
                        print(snapshot)
                        
                        }, withCancel: nil)
                    
                    //print(snapshot)
                    
                }, withCancel: { (error) in
                    print(error)
                })
            }
            if userOnlineAdmin == "true" {
                //let ref = Database.database().reference().child("user-messages").child("air-part")
                let ref = Database.database().reference().child("user-messages").child((chatUser?.id)!)
                ref.observe(.childAdded, with: { [weak self] (snapshot) in
                    
                    let messageId = snapshot.key
                    let messagesRefference = Database.database().reference().child("messages").child(messageId)
                    
                    messagesRefference.observeSingleEvent(of: .value, with: { [weak self] (snapshot) in
                        
                        self?.sortObservedMessagesForUser(snapshot: snapshot)
                        print(snapshot)
                        
                        }, withCancel: nil)
                    
                    //print(snapshot)
                    
                }, withCancel: { (error) in
                    print(error)
                })
            }
        }

    }
    
    func sortObservedMessagesForUser(snapshot: DataSnapshot) {
        
        if let dictionary = snapshot.value as? [String : Any] {
            var message: Message? = Message()
            message?.setValuesForKeys(dictionary)
            //self.messages.append(message!)
            
            self.myMessages.append(message!)
            self.tableView.reloadData()
            message = nil
            
//            DispatchQueue.main.async {
//                // Add from massages to myMassages if online user matches toId massage Of fromId
//                if self.chatUser == nil {
//                    
//                    if let toId = message?.toId, let fromId = message?.fromId {
//                        if toId == self.userOnlineId || fromId == self.userOnlineId {
//                            self.myMessages.append(message!)
//                            self.messages.sort(by: { (message1 , message2) -> Bool in
//                                return message1.timestamp!.intValue > message2.timestamp!.intValue
//                            })
//                            self.tableView.reloadData()
//                            message = nil
//                        }
//                    }
//                    // IF ChatUser non nill then Add from massages to myMassages from online user to chat person
//                } else if self.chatUser != nil {
//                    
//                    if let toId = message?.toId, let fromId = message?.fromId, let chatUser = self.chatUser?.id {
//                        if toId == "air-part" /*self.userOnlineId!*/ && fromId == chatUser || toId == chatUser && fromId ==  self.userOnlineId! {
//                            self.myMessages.append(message!)
//                            self.messages.sort(by: { (message1 , message2) -> Bool in
//                                return message1.timestamp!.intValue > message2.timestamp!.intValue
//                            })
//                            self.tableView.reloadData()
//                            message = nil
//                        }
//                    }
//                }
//            }
        }
        
    }
    
    //var message: Message?
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { [weak self] (snapshot) in
            
            if let dictionary = snapshot.value as? [String : Any] {
                var message: Message? = Message()
                message?.setValuesForKeys(dictionary)
                self?.messages.append(message!)
                
                DispatchQueue.main.async {
                    // Add from massages to myMassages if online user matches toId massage Of fromId
                    if self?.chatUser == nil {
                        
                        if let toId = message?.toId, let fromId = message?.fromId {
                            if toId == self?.userOnlineId || fromId == self?.userOnlineId {
                                self?.myMessages.append(message!)
                                self?.messages.sort(by: { (message1 , message2) -> Bool in
                                    return message1.timestamp!.intValue > message2.timestamp!.intValue
                                })
                                self?.tableView.reloadData()
                                message = nil
                            }
                        }
                        // IF ChatUser non nill then Add from massages to myMassages from online user to chat person
                    } else if self?.chatUser != nil {
                        
                        if let toId = message?.toId, let fromId = message?.fromId, let chatUser = self?.chatUser?.id {
                            if toId == "air-part" /*self.userOnlineId!*/ && fromId == chatUser || toId == chatUser && fromId == self?.userOnlineId! {
                                self?.myMessages.append(message!)
                                self?.messages.sort(by: { (message1 , message2) -> Bool in
                                    return message1.timestamp!.intValue > message2.timestamp!.intValue
                                })
                                self?.tableView.reloadData()
                                message = nil
                            }
                        }
                    }
                }
            }
            
        }, withCancel: nil)
        
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myMessages.count //messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cells = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        
        //let message = myMessages[indexPath.row]
        let message = myMessages[indexPath.row]
        
        if self.chatUser == nil {   // Admin reads messages
            
            if userOnlineId == message.fromId { // decide which cell to use To or From
                let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableConstants.chatCellIdTo, for: indexPath) as! ChatTableViewCellTo
                cell.sendImageView?.image = nil
                cell.cellPicToConstrain.isActive = false
                
                cell.chatViewController = self
                
                formatAndSetDate(message: message, cellToFrom: cell)
                
                cell.messageLabel.text = message.text
                
                downloadAndPasteImage(message: message, cellToFrom: cell)
                
                return cell
            } else if userOnlineId == message.toId { // decide which cell to use To or From
                let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableConstants.chatCellIdFrom , for: indexPath) as! ChatTableViewCellFrom
                cell.sendImageView?.image = nil
                cell.cellPicFromConstrain.isActive = false
                
                cell.chatViewController = self
                
                formatAndSetDate(message: message, cellToFrom: cell)
                
                cell.messageLabel.text = message.text
                downloadAndPasteImage(message: message, cellToFrom: cell)
                
                return cell
            } else {
                return cells
            }
        } else {     // User read messages
            if let toId = message.toId, let fromId = message.fromId, let chatUser = self.chatUser?.id {
                //if toId == self.userOnlineId! && fromId == chatUser /*|| toId == chatUser && fromId == self.userOnlineId! */ {
                if toId == "air-part" && fromId == chatUser /*|| toId == chatUser && fromId == self.userOnlineId! */ {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableConstants.chatCellIdFrom , for: indexPath) as! ChatTableViewCellFrom
                    cell.sendImageView?.image = nil
                    cell.cellPicFromConstrain.isActive = false
                    
                    cell.chatViewController = self

                    formatAndSetDate(message: message, cellToFrom: cell)
                    
                    cell.messageLabel.text = message.text
                    
                    downloadAndPasteImage(message: message, cellToFrom: cell)
                    
                    return cell
                } else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableConstants.chatCellIdTo, for: indexPath) as! ChatTableViewCellTo
                    cell.sendImageView?.image = nil
                    cell.cellPicToConstrain.isActive = false
                    
                    cell.chatViewController = self

                    formatAndSetDate(message: message, cellToFrom: cell)
                    
                    cell.messageLabel.text = message.text
                    
                    downloadAndPasteImage(message: message, cellToFrom: cell)
                    
                    
                    return cell
                }
            }
            return cells
        }
    }
    
    // MARK: Formate and set date
    
    func formatAndSetDate(message: Message, cellToFrom: UITableViewCell) {
        
        if let seconds = message.timestamp?.doubleValue {
            let timestampDate = NSDate(timeIntervalSince1970: seconds)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            if let cell = cellToFrom as? ChatTableViewCellTo {
                cell.sendTimeLabel.font = UIFont.systemFont(ofSize: 12)
                cell.sendTimeLabel.text = dateFormatter.string(from: timestampDate as Date)
            }
            if let cell = cellToFrom as? ChatTableViewCellFrom {
                cell.sendTimeLabel.font = UIFont.systemFont(ofSize: 12)
                cell.sendTimeLabel.text = dateFormatter.string(from: timestampDate as Date)
            }
        }
        
    }
    
    
    // MARK: Download and set image
    
    func downloadAndPasteImage(message: Message, cellToFrom: UITableViewCell) {
        
        if message.imageUrl != nil {
            if let url = NSURL(string: message.imageUrl!) {
                if let data = NSData(contentsOf: url as URL) {
                    if let cell = cellToFrom as? ChatTableViewCellTo {
                        cell.cellPicToConstrain.isActive = true
                        cell.sendImageView?.image = UIImage(data: data as Data)
                    }
                    if let cell = cellToFrom as? ChatTableViewCellFrom {
                        cell.cellPicFromConstrain.isActive = true
                        cell.sendImageView?.image = UIImage(data: data as Data)
                    }
                }
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: +++++++++++++++++ online/offline check
    
    func onlineOfflineUser() {
        if Auth.auth().currentUser?.uid == nil {
            userOnline = "non"
        } else {
            let uid = Auth.auth().currentUser?.uid
            userOnlineId = uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value , with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : Any] {
                    DispatchQueue.main.async {
                        self.userOnline = dictionary["name"] as? String
                        self.userOnlineAdmin = dictionary["Admin"] as? String
                        //self.onlineUser?.setValuesForKeys(dictionary)
                        self.tableView.reloadData()
                        self.observerUserMessages()
                    }
                }
            }, withCancel: nil)
            //onlineLabel.text = "online"
        }
    }
    
    // MARK: ++++++++++++++++++++ Send messages
    
    func sendMessage() {
        let ref = Database.database().reference().child("messages")
        let childRef = ref.childByAutoId()
        let toUserId = chatUser?.id ?? "air-part"
        var fromUserId = ""
        if userOnlineAdmin == "false" {
            fromUserId = userOnlineId!
        } else {
            fromUserId = "air-part"
        }
        let userOnlineName = userOnline!
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let values = ["text" : messageTextField.text!, "to" : "air-part", "fromId" : fromUserId , "toId" : toUserId, "fromName" : userOnlineName, "timestamp" : timestamp ] as [String : Any]
        //childRef.updateChildValues(values)
        
        childRef.updateChildValues(values) { (error, ref) in
            if error != nil {
                print(error!)
                return
            }
            
            let userMessagesRef = Database.database().reference().child("user-messages").child(fromUserId)
            let messageId = childRef.key
            userMessagesRef.updateChildValues([messageId : 1])
            
            let recipientUserMessageRef = Database.database().reference().child("user-messages").child(toUserId)
            recipientUserMessageRef.updateChildValues([messageId : 1])
        }
        
        messageTextField.text = nil
        scrollByTimer()
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
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendMessage()
        return true
    }
    
    struct ChatTableConstants {
        static var chatCellIdFrom = "chatCellFrom"
        static var chatCellIdTo = "chatCellTo"
    }

    @objc func scrollToBottom2() {
        let sections = self.tableView.numberOfSections
        if sections > 0 {
            let rows = tableView.numberOfRows(inSection: sections - 1)
            if rows > 0 {
                let last = IndexPath(row: rows - 1, section: sections - 1)
                self.tableView.scrollToRow(at: last, at: .bottom, animated: false)
            }
            
        }
    }
    
    var zoomingScrollView: UIScrollView?
    var zoomingImageView: UIImageView?
    var startingFrame: CGRect?
    var blackBackgroundView: UIView?
    
    func performZoomInForImageView(startingImageView: UIImageView) {
        startingFrame = startingImageView.superview?.convert(startingImageView.frame, from: startingImageView)

        zoomingScrollView = UIScrollView(frame: startingFrame!)
        zoomingScrollView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomOut(tapGesture:))))
        
        zoomingScrollView?.delegate = self
        zoomingScrollView?.minimumZoomScale = 1
        zoomingScrollView?.maximumZoomScale = 5.0
        
        //zoomingScrollView?.contentSize = startingImageView.bounds.size
        zoomingScrollView?.contentSize = CGSize(width: 500, height: 500)

        
        zoomingImageView = UIImageView(frame: (zoomingScrollView?.frame)!)
        zoomingScrollView?.addSubview(zoomingImageView!)
        zoomingScrollView?.backgroundColor = UIColor.clear
        zoomingImageView?.image = startingImageView.image
        
        
        if let keyWindow = UIApplication.shared.keyWindow {
            
            blackBackgroundView = UIView(frame: keyWindow.frame)
            blackBackgroundView?.backgroundColor = UIColor.black
            blackBackgroundView?.alpha = 0
            keyWindow.addSubview(blackBackgroundView!)
            
            keyWindow.addSubview(zoomingScrollView!)
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
                
                self.blackBackgroundView?.alpha = 1
                
                //self.zoomingScrollView?.frame = CGRect(x: 0, y: 0, width: (startingFrame?.width)!, height: (startingFrame?.height)!)
                let height = (self.startingFrame?.height)! / (self.startingFrame?.width)! * keyWindow.frame.width
                
                self.zoomingScrollView?.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                self.zoomingImageView?.frame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
                self.zoomingScrollView?.contentSize = CGSize(width: keyWindow.frame.width, height: height)
                //self.zoomingScrollView?.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
                //self.zoomingImageView?.frame = CGRect(x: 0, y: 0, width: 500, height: 500)
                
                self.zoomingScrollView?.center = self.view.center
                //zoomingImageView.center = zoomingScrollView.center
                //zoomingScrollView.contentSize = CGSize(width: 500, height: 500)
                
            }, completion: nil)
            
        }
    }
    
    @objc func handleZoomOut(tapGesture: UITapGestureRecognizer) {
        print("zoomint out")
        if let zoomOutImageView = tapGesture.view {
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: { 
                zoomOutImageView.frame = self.startingFrame!
                self.blackBackgroundView?.alpha = 0
                zoomOutImageView.alpha = 0
            }, completion: { (complited) in
                zoomOutImageView.removeFromSuperview()
            })
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return zoomingImageView
    }
}


//extension UITableView {
//    func scrollToBottom(animated: Bool) {
//        let y = contentSize.height - frame.size.height
//        setContentOffset(CGPoint(x: 0, y: (y<0) ? 0 : y) , animated: animated)
//    }
//}














