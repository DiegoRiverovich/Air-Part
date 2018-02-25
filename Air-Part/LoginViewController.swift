//
//  LoginViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 29.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var enterRegToggle: UISegmentedControl!
    
    @IBOutlet weak var companyNameTextField: UITextField!
    
    @IBOutlet weak var companyRepresentativeTextField: UITextField!
    
    @IBOutlet weak var representativePositionTextField: UITextField!
    
    @IBOutlet weak var repEmailTextField: UITextField!
    
    @IBOutlet weak var repPassTextField: UITextField!
    
    @IBOutlet weak var enterRegButton: UIButton!
    
    @IBOutlet weak var onlineLabel: UILabel!
    
    @IBOutlet weak var youEnteredLikeLabel: UILabel!
    
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var verticalConstraint: NSLayoutConstraint!
    
    @IBAction func logoutButton(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        
        onlineOfflineLabel()
    }
    
    @IBAction func enterReg(_ sender: UIButton) {
        
        if enterRegToggle.selectedSegmentIndex == 0 {
            handleLogin()
        } else {
            //handleRegister()  //#Temporary disabled. Enable in next versions
        }
 
    }
    
    // MARK: register func
    
    func handleLogin() {
        guard let email = repEmailTextField.text, let password = repPassTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
                return
            }
            DispatchQueue.main.async {
                self.onlineOfflineLabel()
                //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
            }
            
        }
        
    }
    // MARK: login func
    
    func handleRegister() {
        guard let email = repEmailTextField.text, let password = repPassTextField.text, let companyName = companyNameTextField.text, let name = companyRepresentativeTextField.text, let companyRepPosition = representativePositionTextField.text else {
            print("Form is not valid")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print("Error while create user")
                return
            }
            
            guard let uid = user?.uid else {
                return
            }
            
            let usersReference = self.ref.child("users").child(uid)
            let values = ["name" : name, "email" : email, "CompanyName" : companyName, "CompanyRepPosition" : companyRepPosition, "Admin" : "false"] as [String : Any]
            usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if err != nil {
                    print("Err while writing data about user")
                    return
                }
                
                DispatchQueue.main.async {
                    self.onlineOfflineLabel()
                }
                print("Saved user successfully into Firebase Db")
                
            })
            
        }
        onlineOfflineLabel()
    }

    // refference on Firebase DB
    var ref: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        //logoutButton.layer.borderWidth = 1
        //logoutButton.layer.cornerRadius = 2
        logoutButton.titleLabel?.font = UIFont(name: "Helvetica", size: 16)
        //logoutButton.layer.borderColor = UIColor.cyan.cgColor
        
        
        // online of offline user
        onlineOfflineLabel()
        // default selected segment on toggle (registration/enter)
        enterRegToggle.selectedSegmentIndex = 1
        toggleRegButton()
        
        // refference on Firebase DB
        ref = Database.database().reference()
        //ref.updateChildValues(["someValu" : 123123])

        sideMenus()
        customizeNavBar()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addObservers()
    }
    
    // ++++++ #Take up stackview for password
    @objc private func didTapView(gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        /*
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
 */
        //let contentInset = UIEdgeInsets(top: 10, left: 0, bottom: frame.height, right: 0)
        verticalConstraint.constant = -50
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
        //scrollView.contentInset = contentInset
        
    }
    
    @objc fileprivate func keyboardWillHide(notification: Notification) {
        //scrollView.contentInset = UIEdgeInsets.zero
        //scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        verticalConstraint.constant = 0
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    // ------ #Take up stackview for password
    
    // MARK: Toggle settings
    
    func toggleRegButton() {
        enterRegToggle.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
    }
    
    // MARK: Change title on the button
    @objc func handleLoginRegisterChange() {
        //print(enterRegToggle.selectedSegmentIndex)
        let selectedIndex = enterRegToggle.selectedSegmentIndex
        let title = enterRegToggle.titleForSegment(at: enterRegToggle.selectedSegmentIndex)
        enterRegButton.setTitle(title, for: .normal)
        
        if selectedIndex == 0 {
            companyNameTextField.isHidden = true
            companyRepresentativeTextField.isHidden = true
            representativePositionTextField.isHidden = true
        } else if selectedIndex == 1 {
            companyNameTextField.isHidden = false
            companyRepresentativeTextField.isHidden = false
            representativePositionTextField.isHidden = false
        }
        
    }
    
    // MARK: +++++++++++++++++ online/offline check
    
    func onlineOfflineLabel() {
        if Auth.auth().currentUser?.uid == nil {
            onlineLabel.text = "offline"
            youEnteredLikeLabel.text = ""
            logoutButton.setTitle("", for: .normal)
        } else {
            let uid = Auth.auth().currentUser?.uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value , with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : Any] {
                    DispatchQueue.main.async {
                        //self.onlineLabel.text = dictionary["name"] as? String
                        self.youEnteredLikeLabel.text = "Вы вошли как \(String(describing: dictionary["name"]!))"
                        self.logoutButton.setTitle("Выход", for: .normal)
                    }
                }
            }, withCancel: nil)
            //onlineLabel.text = "online"
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    deinit {
        print("LoginViewCont deinit")
    }

}
