//
//  PipesDiameterViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 23.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import Darwin.C.math

class PipesDiameterViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var kmm: UITextField!
    @IBOutlet weak var kms: UITextField!
    @IBOutlet weak var pipeLenght: UITextField!
    @IBOutlet weak var allowDownPressure: UITextField!
    @IBOutlet weak var shutDownPressure: UITextField!
    
    @IBOutlet weak var pipem: UITextField!
    @IBOutlet weak var pipemm: UITextField!
    
    @IBAction func kmmEditingChanged(_ sender: UITextField) {
        guard let value1 = (Double(sender.text!))
        else {
            pipem.text = ""
            pipemm.text = ""
            kms.text = ""
            return
        }
        kms.text = String(value1 * 0.016666)
        
        if let value = (Double(sender.text!)), let kmsLocal = Double(kms.text!), let pipeLenghtLocal = Double(pipeLenght.text!), let allowDownPressureLocal = Double(allowDownPressure.text!), let shutDownPressureLocal = Double(shutDownPressure.text!) {
            
            kms.text = String(value * 0.016666)
            pipem.text = String(value * 1)
            pipemm.text = String(value * 1_000)
            
            //let kmsLocal = Double(kms.text!)!
            //let pipeLenghtLocal = Double(pipeLenght.text!)!
            let up = 1.6 * pow(10, 3) * pow(kmsLocal, 1.85) * pipeLenghtLocal
            
            //let allowDownPressureLocal = Double(allowDownPressure.text!)!
            //let shutDownPressureLocal = Double(shutDownPressure.text!)!
            let down = pow(10, 10) * allowDownPressureLocal * shutDownPressureLocal
            //pow(base, (1/n))
            pipem.text = String(pow(up/down, (1/5)))
            pipemm.text = String(pow(up/down, (1/5)) * 1_000)
        } else {
            pipem.text = ""
            pipemm.text = ""
        }
    }
    
    @IBAction func pipeLenghtEditingChanged(_ sender: UITextField) {
        
        if let pipeLenghtLocal = (Double(sender.text!)), let kmsLocal = Double(kms.text!), /*let pipeLenghtLocal = Double(pipeLenght.text!),*/ let allowDownPressureLocal = Double(allowDownPressure.text!), let shutDownPressureLocal = Double(shutDownPressure.text!) {
            
            let up = 1.6 * pow(10, 3) * pow(kmsLocal, 1.85) * pipeLenghtLocal
            
            let down = pow(10, 10) * allowDownPressureLocal * shutDownPressureLocal
            //pow(base, (1/n))
            pipem.text = String(pow(up/down, (1/5)))
            pipemm.text = String(pow(up/down, (1/5)) * 1_000)
        } else {
            pipem.text = ""
            pipemm.text = ""
        }
 
    }
    
    @IBAction func allowDownPressureEditingChanged(_ sender: UITextField) {
        if let allowDownPressureLocal = (Double(sender.text!)), let kmsLocal = Double(kms.text!), let pipeLenghtLocal = Double(pipeLenght.text!), /*let allowDownPressureLocal = Double(allowDownPressure.text!),*/ let shutDownPressureLocal = Double(shutDownPressure.text!) {
            
            let up = 1.6 * pow(10, 3) * pow(kmsLocal, 1.85) * pipeLenghtLocal
            
            let down = pow(10, 10) * allowDownPressureLocal * shutDownPressureLocal
            //pow(base, (1/n))
            pipem.text = String(pow(up/down, (1/5)))
            pipemm.text = String(pow(up/down, (1/5)) * 1_000)
        } else {
            pipem.text = ""
            pipemm.text = ""
        }
    }
    
    @IBAction func shutDownPressureEditingChanged(_ sender: UITextField) {
        if let shutDownPressureLocal = (Double(sender.text!)), let kmsLocal = Double(kms.text!), let pipeLenghtLocal = Double(pipeLenght.text!), let allowDownPressureLocal = Double(allowDownPressure.text!)/*, let shutDownPressureLocal = Double(shutDownPressure.text!)*/ {
            
            let up = 1.6 * pow(10, 3) * pow(kmsLocal, 1.85) * pipeLenghtLocal
            
            let down = pow(10, 10) * allowDownPressureLocal * shutDownPressureLocal
            //pow(base, (1/n))
            pipem.text = String(pow(up/down, (1/5)))
            pipemm.text = String(pow(up/down, (1/5)) * 1_000)
        } else {
            pipem.text = ""
            pipemm.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)

        //scrollView.resizeScrollViewContentSize()
        
        sideMenus()
        customizeNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func didTapView(gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(PipesDiameterViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PipesDiameterViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        scrollView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //self.view.endEditing(true)
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
        print("PipesDiameter deinit")
    }

}
