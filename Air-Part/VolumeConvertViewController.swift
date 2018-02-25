//
//  VolumeConvertViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 23.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class VolumeConvertViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var ltrs: UITextField!
    @IBOutlet weak var gtLtrs: UITextField!
    @IBOutlet weak var dkLtrs: UITextField!
    @IBOutlet weak var mlLtrs: UITextField!
    
    @IBOutlet weak var kbMtrs: UITextField!
    @IBOutlet weak var kbStmrs: UITextField!
    @IBOutlet weak var kbYrds: UITextField!
    @IBOutlet weak var kbFt: UITextField!
    
    @IBOutlet weak var kbDm: UITextField!
    @IBOutlet weak var glns: UITextField!
    
    var keyboardOnScreen: Bool = false
    
    @IBAction func ltrsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            //ltrs.text = String(value * 0.9869)
            gtLtrs.text = String(format: "%.5f", value * 0.01)//String(value * 0.01)
            dkLtrs.text = String(format: "%.5f", value * 0.1)//String(value * 0.1)
            mlLtrs.text = String(format: "%.5f", value * 1_000.0)//String(value * 1_000.0)
            
            kbMtrs.text = String(format: "%.5f", value * 0.001)//String(value * 0.001)
            kbStmrs.text = String(format: "%.5f", value * 1_000)//String(value * 1_000)
            kbYrds.text = String(format: "%.5f", value * 0.00131)//String(value * 0.00131)
            kbFt.text = String(format: "%.5f", value * 0.03531)//String(value * 0.03531)
            
            kbDm.text = String(format: "%.5f", value * 61.024)//String(value * 61.024)
            glns.text = String(format: "%.5f", value * 0.2642)//String(value * 0.2642)
        } else {
            //ltrs.text = String(value * 0.9869)
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func gtLtrsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 100)//String(value * 100)
            //gtLtrs.text = String(value * 0.01)
            dkLtrs.text = String(format: "%.5f", value * 10)//String(value * 10)
            mlLtrs.text = String(format: "%.5f", value * 100_000)//String(value * 100_000)
            
            kbMtrs.text = String(format: "%.5f", value * 0.1)//String(value * 0.1)
            kbStmrs.text = String(format: "%.5f", value * 100_000)//String(value * 100_000)
            kbYrds.text = String(format: "%.5f", value * 0.13072)//String(value * 0.13072)
            kbFt.text = String(format: "%.5f", value * 3.531)//String(value * 3.531)
            
            kbDm.text = String(format: "%.5f", value * 6102.4)//String(value * 6102.4)
            glns.text = String(format: "%.5f", value * 26.4200)//String(value * 26.4200)
        } else {
            ltrs.text = ""
            //gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func dkLtrsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 10)//String(value * 10)
            gtLtrs.text = String(format: "%.5f", value * 0.1)//String(value * 0.1)
            //dkLtrs.text = String(value * 10)
            mlLtrs.text = String(format: "%.5f", value * 10_000)//String(value * 10_000)
            
            kbMtrs.text = String(format: "%.5f", value * 0.01)//String(value * 0.01)
            kbStmrs.text = String(format: "%.5f", value * 10_000)//String(value * 10_000)
            kbYrds.text = String(format: "%.5f", value * 0.01307)//String(value * 0.01307)
            kbFt.text = String(format: "%.5f", value * 0.3531)//String(value * 0.3531)
            
            kbDm.text = String(format: "%.5f", value * 610.24)//String(value * 610.24)
            glns.text = String(format: "%.5f", value * 2.642)//String(value * 2.642)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            //dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func mlLtrsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 0.001)//String(value * 0.001)
            gtLtrs.text = String(format: "%.5f", value * 0.00001)//String(value * 0.00001)
            dkLtrs.text = String(format: "%.5f", value * 0.0001)//String(value * 0.0001)
            //mlLtrs.text = String(value * 10_000)
            
            kbMtrs.text = String(format: "%.5f", value * 0.00000)//String(value * 0.00000)
            kbStmrs.text = String(format: "%.5f", value * 1)//String(value * 1)
            kbYrds.text = String(format: "%.5f", value * 0.00000)//String(value * 0.00000)
            kbFt.text = String(format: "%.5f", value * 0.00004)//String(value * 0.00004)
            
            kbDm.text = String(format: "%.5f", value * 0.06102)//String(value * 0.06102)
            glns.text = String(format: "%.5f", value * 0.00026)//String(value * 0.00026)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            //mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func kbMrtsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 1_000)//String(value * 1_000)
            gtLtrs.text = String(format: "%.5f", value * 10)//String(value * 10)
            dkLtrs.text = String(format: "%.5f", value * 100)//String(value * 100)
            mlLtrs.text = String(format: "%.5f", value * 1_000_000)//String(value * 1_000_000)
            
            //kbMtrs.text = String(value * 0.00000)
            kbStmrs.text = String(format: "%.5f", value * 1_000_000)//String(value * 1_000_000)
            kbYrds.text = String(format: "%.5f", value * 1.3072)//String(value * 1.3072)
            kbFt.text = String(format: "%.5f", value * 35.31)//String(value * 35.31)
            
            kbDm.text = String(format: "%.5f", value * 61024)//String(value * 61024)
            glns.text = String(format: "%.5f", value * 264.2)//String(value * 264.2)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            //kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    @IBAction func kbStmrs(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(value * 0.001)
            gtLtrs.text = String(format: "%.6f", value * 0.00001)//String(value * 0.00001)
            dkLtrs.text = String(format: "%.6f", value * 0.0001)//String(value * 0.0001)
            mlLtrs.text = String(format: "%.6f", value * 1)//String(value * 1)
            
            kbMtrs.text = String(format: "%.6f", value * 0.000001)//String(value * 0.00000)
            //kbStmrs.text = String(value * 1_000_000)
            kbYrds.text = String(format: "%.6f", value * 0.000001308)//String(value * 0.00000)
            kbFt.text = String(format: "%.6f", value * 0.00004)//String(value * 0.00004)
            
            kbDm.text = String(format: "%.6f", value * 0.06102)//String(value * 0.06102)
            glns.text = String(format: "%.6f", value * 0.00026)//String(value * 0.00026)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            //kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func kbYrds(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 764.994)//String(value * 764.994)
            gtLtrs.text = String(format: "%.5f", value * 7.64994)//String(value * 7.64994)
            dkLtrs.text = String(format: "%.5f", value * 76.4994)//String(value * 76.4994)
            mlLtrs.text = String(format: "%.5f", value * 764994)//String(value * 764994)
            
            kbMtrs.text = String(format: "%.5f", value * 0.76499)//String(value * 0.76499)
            kbStmrs.text = String(format: "%.5f", value * 764994)//String(value * 764994)
            //kbYrds.text = String(value * 0.00000)
            kbFt.text = String(format: "%.5f", value * 27.0119)//String(value * 27.0119)
            
            kbDm.text = String(format: "%.5f", value * 46683.0)//String(value * 46683.0)
            glns.text = String(format: "%.5f", value * 202.111)//String(value * 202.111)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            //kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func kbFt(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 28.3206)//String(value * 28.3206)
            gtLtrs.text = String(format: "%.5f", value * 0.28321)//String(value * 0.28321)
            dkLtrs.text = String(format: "%.5f", value * 2.83206)//String(value * 2.83206)
            mlLtrs.text = String(format: "%.5f", value * 28320.6)//String(value * 28320.6)
            
            kbMtrs.text = String(format: "%.5f", value * 0.02832)//String(value * 0.02832)
            kbStmrs.text = String(format: "%.5f", value * 28320.6)//String(value * 28320.6)
            kbYrds.text = String(format: "%.5f", value * 0.03702)//String(value * 0.03702)
            //kbFt.text = String(value * 27.0119)
            
            kbDm.text = String(format: "%.5f", value * 1728.24)//String(value * 1728.24)
            glns.text = String(format: "%.5f", value * 7.48230)//String(value * 7.48230)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            //kbFt.text = ""
            
            kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func kbDm(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 0.01639)//String(value * 0.01639)
            gtLtrs.text = String(format: "%.5f", value * 0.00016)//String(value * 0.00016)
            dkLtrs.text = String(format: "%.5f", value * 0.00164)//String(value * 0.00164)
            mlLtrs.text = String(format: "%.5f", value * 16.3870)//String(value * 16.3870)
            
            kbMtrs.text = String(format: "%.5f", value * 0.00002)//String(value * 0.00002)
            kbStmrs.text = String(format: "%.5f", value * 16.3870)//String(value * 16.3870)
            kbYrds.text = String(format: "%.5f", value * 0.00002)//String(value * 0.00002)
            kbFt.text = String(format: "%.5f", value * 0.00058)//String(value * 0.00058)
            
            //kbDm.text = String(value * 1728.24)
            glns.text = String(format: "%.5f", value * 0.00433)//String(value * 0.00433)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            //kbDm.text = ""
            glns.text = ""
        }
    }
    
    @IBAction func glnsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            ltrs.text = String(format: "%.5f", value * 3.78501)//String(value * 3.78501)
            gtLtrs.text = String(format: "%.5f", value * 0.03785)//String(value * 0.03785)
            dkLtrs.text = String(format: "%.5f", value * 0.37850)//String(value * 0.37850)
            mlLtrs.text = String(format: "%.5f", value * 3785.01)//String(value * 3785.01)
            
            kbMtrs.text = String(format: "%.5f", value * 0.00379)//String(value * 0.00379)
            kbStmrs.text = String(format: "%.5f", value * 3785.01)//String(value * 3785.01)
            kbYrds.text = String(format: "%.5f", value * 0.00495)//String(value * 0.00495)
            kbFt.text = String(format: "%.5f", value * 0.13365)//String(value * 0.13365)
            
            kbDm.text = String(format: "%.5f", value * 230.977)//String(value * 230.977)
            //glns.text = String(value * 0.00433)
        } else {
            ltrs.text = ""
            gtLtrs.text = ""
            dkLtrs.text = ""
            mlLtrs.text = ""
            
            kbMtrs.text = ""
            kbStmrs.text = ""
            kbYrds.text = ""
            kbFt.text = ""
            
            kbDm.text = ""
            //glns.text = ""
        }
    }
    
    @objc func clearFields() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "clearIcon1"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(5), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.clearFields), for: .touchUpInside)
        ltrs.rightView = button
        ltrs.rightViewMode = .always
    */
        /*
        ltrs.rightViewMode = UITextFieldViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "clearIcon1")
        imageView.image = image
        ltrs.rightView = imageView
        */
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        
        
        /*
        NotificationCenter.default.addObserver(self, selector: #selector(MetricConvertViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MetricConvertViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        */
        //scrollView.resizeScrollViewContentSize()
        
        sideMenus()
        customizeNavBar()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addObservers()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func didTapView(gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(VolumeConvertViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(VolumeConvertViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let userInfo = notification.userInfo, let frame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInset = UIEdgeInsets(top: 10, left: 0, bottom: frame.height, right: 0)
        
            scrollView.contentInset = contentInset
        
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        //scrollView.contentInset = UIEdgeInsets.zero
        scrollView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    /*
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //scrollView.setContentOffset(CGPoint(x: 0, y: 250) , animated: true)
        if (textField == kbDm || textField == glns || textField == kbFt || textField ==  kbYrds) {
            //scrollView.setContentOffset(CGPoint(x: 0, y: 250) , animated: true)
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 230
                scrollView.setContentOffset(CGPoint(x: 0, y: 250) , animated: true)
            }
        } else {
            //scrollView.setContentOffset(CGPoint(x: 0, y: 0) , animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (textField == kbDm || textField == glns || textField == kbFt || textField ==  kbYrds) {
            //scrollView.setContentOffset(CGPoint(x: 0, y: 0) , animated: true)
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += 230
                scrollView.setContentOffset(CGPoint(x: 0, y: 0) , animated: true)
            }
        } else {
            //scrollView.setContentOffset(CGPoint(x: 0, y: 0) , animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    */

    /*
    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
        keyboardOnScreen = true
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y != 0 {
//                self.view.frame.origin.y += keyboardSize.height
//            }
//        }
        keyboardOnScreen = false
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    deinit {
        print("VolumeConvert deinit")
    }

}
