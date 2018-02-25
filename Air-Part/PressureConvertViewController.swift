//
//  PressureConvertViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 23.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class PressureConvertViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var atm: UITextField!
    @IBOutlet weak var kpa: UITextField!
    @IBOutlet weak var mpa: UITextField!
    @IBOutlet weak var psi: UITextField!
    @IBOutlet weak var kgfcm: UITextField!
    @IBOutlet weak var bar: UITextField!
    
    @IBAction func atmEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            //atm.text = String(value / 60.0)
            kpa.text = String(format: "%.5f", value * 101.3)//String(value * 101.3)
            mpa.text = String(format: "%.8f", value * 0.1013)//String(value * 0.1013)
            
            psi.text = String(format: "%.5f", value * 14.7)//String(value * 14.7)
            kgfcm.text = String(format: "%.5f", value * 1.033)//String(value * 1.033)
            bar.text = String(format: "%.5f", value * 1.013)//String(value * 1.013)
        } else {
            kpa.text = ""
            mpa.text = ""
            
            psi.text = ""
            kgfcm.text = ""
            bar.text = ""
        }
    }
    
    @IBAction func kpaEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            atm.text = String(format: "%.5f", value * 0.009869)//String(value * 0.009869)
            //kpa.text = String(value * 101.3)
            mpa.text = String(format: "%.5f", value * 0.001)//String(value * 0.001)
            
            psi.text = String(format: "%.5f", value * 0.145)//String(value * 0.145)
            kgfcm.text = String(format: "%.5f", value * 0.0102)//String(value * 0.0102)
            bar.text = String(format: "%.5f", value * 0.01)//String(value * 0.01)
        } else {
            atm.text = ""
            //kpa.text = ""
            mpa.text = ""
            
            psi.text = ""
            kgfcm.text = ""
            bar.text = ""
        }
    }
    
    @IBAction func mpaEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            atm.text = String(format: "%.5f", value * 9.869)//String(value * 9.869)
            kpa.text = String(format: "%.5f", value * 1_000.0)//String(value * 1_000.0)
            //mpa.text = String(value * 0.001)
            
            psi.text = String(format: "%.5f", value * 145.0)//String(value * 145.0)
            kgfcm.text = String(format: "%.5f", value * 10.2)//String(value * 10.2)
            bar.text = String(format: "%.5f", value * 10.0)//String(value * 10.0)
        } else {
            atm.text = ""
            kpa.text = ""
            //mpa.text = ""
            
            psi.text = ""
            kgfcm.text = ""
            bar.text = ""
        }
    }
    
    @IBAction func psiEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            atm.text = String(format: "%.5f", value * 0.06805)//String(value * 0.06805)
            kpa.text = String(format: "%.5f", value * 6.89473)//String(value * 6.895)
            mpa.text = String(format: "%.5f", value * 0.006895)//String(value * 0.006895)
            
            //psi.text = String(value * 145)
            kgfcm.text = String(format: "%.5f", value * 0.07031)//String(value * 0.07031)
            bar.text = String(format: "%.5f", value * 0.06895)//String(value * 0.06895)
        } else {
            atm.text = ""
            kpa.text = ""
            mpa.text = ""
            
            //psi.text = ""
            kgfcm.text = ""
            bar.text = ""
        }
    }
    
    @IBAction func kgfcmEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            atm.text = String(format: "%.5f", value * 0.96785)//String(value * 0.9678)
            kpa.text = String(format: "%.5f", value * 98.0672)//String(value * 98.07)
            mpa.text = String(format: "%.5f", value * 0.09807)//String(value * 0.09807)
            
            psi.text = String(format: "%.5f", value * 14.2235)//String(value * 14.22)
            //kgfcm.text = String(value * 0.07031)
            bar.text = String(format: "%.5f", value * 0.98067)//String(value * 0.9807)
        } else {
            atm.text = ""
            kpa.text = ""
            mpa.text = ""
            
            psi.text = ""
            //kgfcm.text = ""
            bar.text = ""
        }
    }
    
    @IBAction func barEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            atm.text = String(format: "%.5f", value * 0.98692)//String(value * 0.9869)
            kpa.text = String(format: "%.5f", value * 100.0)//String(value * 100.0)
            mpa.text = String(format: "%.5f", value * 0.1)//String(value * 0.1)
            
            psi.text = String(format: "%.5f", value * 14.5038)//String(value * 14.5)
            kgfcm.text = String(format: "%.5f", value * 1.01971)//String(value * 1.02)
            //bar.text = String(value * 0.9807)
        } else {
            atm.text = ""
            kpa.text = ""
            mpa.text = ""
            
            psi.text = ""
            kgfcm.text = ""
            //bar.text = ""
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
        NotificationCenter.default.addObserver(self, selector: #selector(PressureConvertViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(PressureConvertViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        print("PressureConvert deinit")
    }

}
