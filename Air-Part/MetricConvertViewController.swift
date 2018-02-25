//
//  ConvertViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 23.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class MetricConvertViewController: UIViewController {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var mcs: UITextField!
    @IBOutlet weak var mcm: UITextField!
    @IBOutlet weak var mch: UITextField!
    
    @IBOutlet weak var ls: UITextField!
    @IBOutlet weak var lm: UITextField!
    @IBOutlet weak var lh: UITextField!
    
    let numberFormatter = NumberFormatter()
    
    
    @IBAction func convert(_ sender: UIButton) {
    }
    
    
    @IBAction func mcsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            //numberFormatter.
            mcm.text = String(format: "%.8f", value * 59.988002)//  String(value * 60.0)
            mch.text = String(format: "%.8f", value * 3599.280143)//String(value * 3600.0)
            
            ls.text = String(format: "%.8f", value * 1_000.000000)//String(value * 1_000.0)
            lm.text = String(format: "%.8f", value * 59_988.002399)//String(value * 60_000.0)
            lh.text = String(format: "%.8f", value * 3_599_280.143971)//String(value * 3_600_000.0)
        } else {
            mcm.text = ""
            mch.text = ""
            
            ls.text = ""
            lm.text = ""
            lh.text = ""
        }
        //var b:String = String(format:"%f", a)
    }
    
    @IBAction func mcmEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            mcs.text = String(format: "%.8f", value * 0.016670)// String(value / 60.0)
            //mcm.text = String(value * 60.0)
            mch.text = String(format: "%.8f", value * 60.0)//String(value * 60.0)
            
            ls.text = String(format: "%.8f", value * 16.67)//String(value * 16.67)
            lm.text = String(format: "%.8f", value * 1_000.0)//String(value * 1_000.0)
            lh.text = String(format: "%.8f", value * 60_000.0)//String(value * 60_000.0)
        } else {
            mcs.text = ""
            //mcm.text = String(value * 60.0)
            mch.text = ""
            
            ls.text = ""
            lm.text = ""
            lh.text = ""
        }
    }
    
    @IBAction func mchEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            mcs.text = String(format: "%.8f", value * 0.000277)//String(value / 3600.0)
            mcm.text = String(format: "%.8f", value * 0.016666)//String(value / 60)
            //mch.text = String(value * 60.0)
            
            ls.text = String(format: "%.8f", value * 0.2778)//String(value * 0.2778)
            lm.text = String(format: "%.8f", value * 16.67)//String(value * 16.67)
            lh.text = String(format: "%.8f", value * 1000.0)//String(value * 1000.0)
        } else {
            mcs.text = ""
            mcm.text = ""
            //mch.text = String(value * 60.0)
            
            ls.text = ""
            lm.text = ""
            lh.text = ""
        }
    }
    
    @IBAction func lsEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            mcs.text = String(format: "%.8f", value * 0.001)//String(value * 0.001)
            mcm.text = String(format: "%.8f", value * 0.06)//String(value * 0.06)
            mch.text = String(format: "%.8f", value * 3.6)//String(value * 3.6)
            
            //ls.text = String(value * 0.2778)
            lm.text = String(format: "%.8f", value * 60.0)//String(value * 60.0)
            lh.text = String(format: "%.8f", value * 3_600.0)//String(value * 3_600.0)
        } else {
            mcs.text = ""
            mcm.text = ""
            mch.text = ""
            
            //ls.text = String(value * 0.2778)
            lm.text = ""
            lh.text = ""
        }
    }
    
    @IBAction func lmEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            mcs.text = String(format: "%.8f", value * 0.00001667)//String(value * 0.00001667)
            mcm.text = String(format: "%.8f", value * 0.001)//String(value * 0.001)
            mch.text = String(format: "%.8f", value * 0.06)//String(value * 0.06)
            
            ls.text = String(format: "%.8f", value * 0.01667)//String(value * 0.01667)
            //lm.text = String(value * 60.0)
            lh.text = String(format: "%.8f", value * value * 60.0)//String(value * 60.0)
        } else {
            mcs.text = ""
            mcm.text = ""
            mch.text = ""
            
            ls.text = ""
            //lm.text = String(value * 60.0)
            lh.text = ""
        }
    }
    
    @IBAction func lhEditingChanged(_ sender: UITextField) {
        if let value = (Double(sender.text!)) {
            mcs.text = String(format: "%.8f", value * 0.0000002778) //String(value * 0.0000002778)
            mcm.text = String(format: "%.8f", value * 0.00001667)//String(value * 0.00001667)
            mch.text = String(format: "%.8f", value * 0.001)//String(value * 0.001)
            
            ls.text = String(format: "%.8f", value * 0.0002778)//String(value * 0.0002778)
            lm.text = String(format: "%.8f", value * 0.01667)//String(value * 0.01667)
            //lh.text = String(value * 60.0)
        } else {
            mcs.text = ""
            mcm.text = ""
            mch.text = ""
            
            ls.text = ""
            lm.text = ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // #number formatter
        numberFormatter.numberStyle = .decimal //.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        //mcs.addTarget(self, action: #selector(mcsDidChange(_:)), for: .editingChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView(gesture:)))
        view.addGestureRecognizer(tapGesture)
        
        sideMenus()
        customizeNavBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        addObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func didTapView(gesture: UIGestureRecognizer) {
        view.endEditing(true)
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(MetricConvertViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MetricConvertViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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
        print("MetricConvert deinit")
    }

}
