//
//  MenuTableViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 19.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import Firebase

class MenuTableViewController: UITableViewController {
    
    var menuNameArr: Array = [String]()
    var iconeImage: Array = [UIImage]()
    var userOnlineId: String?
    var userOnlineAdmin: String?
    var loginViewController: LoginViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //NotificationCenter.default.addObserver(self, selector: #selector(loadTable), name: NSNotification.Name(rawValue: "load") , object: nil)
        
        onlineOfflineUser()
        

    }
    
    func loadTable() {
        self.tableView.reloadData()
    }
    
    func userDidLogin() {
        //print(onlineUser)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func viewWillLayoutSubviews() {
//        tableView.reloadData()
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        onlineOfflineUser()
        print("menu view will appear")
//        setUpMenu()
//        tableView.reloadData()
    }
    
    // MARK: Setup left menu
    func setUpMenu() {
        if userOnlineId != nil {  // Online user or not
            if userOnlineAdmin == "true" {  // Admin that online user or not
                menuNameArr = ["Продукция", "Доставка", "Отзывы(переход на сайт)", "Контакты", "О нас"/*, "Вход/Выход"*//*, "Задать вопрос(чат)"*//*, "Админ"*/]
                //menuNameArr = ["dsf", "sdf", "afds", "adsf", "asdf"]
                iconeImage = [ UIImage(named: "products50")!, UIImage(named: "delivery50")!, UIImage(named: "reviews50")!, UIImage(named: "contacts50")!, UIImage(named: "info50")!, UIImage(named: "key50")!/*, UIImage(named: "chat50")!*/, UIImage(named: "login50")! ]
            } else {
                menuNameArr = ["Продукция", "Доставка", "Отзывы(переход на сайт)", "Контакты", "О нас"/*, "Вход/Выход", "Задать вопрос(чат)"*/]
                //menuNameArr = ["dsf", "sdf", "afds", "adsf", "asdf"]
                iconeImage = [ UIImage(named: "products50")!, UIImage(named: "delivery50")!, UIImage(named: "reviews50")!, UIImage(named: "contacts50")!, UIImage(named: "info50")!, UIImage(named: "key50")!, UIImage(named: "chat50")!]
            }
        } else {
            menuNameArr = ["Продукция", "Доставка", "Отзывы(переход на сайт)", "Контакты", "О нас"/*, "Вход/Выход", "Задать вопрос(чат)"*/]
            //menuNameArr = ["dsf", "sdf", "afds", "adsf", "asdf"]
            iconeImage = [ UIImage(named: "products50")!, UIImage(named: "delivery50")!, UIImage(named: "reviews50")!, UIImage(named: "contacts50")!, UIImage(named: "info50")!, UIImage(named: "key50")!, UIImage(named: "chat50")!]
        }
        
//        menuNameArr = ["Продукция", "Доставка", "Отзывы", "Контакты", "О нас", "Вход/Выход", "Задать вопрос(чат)", "Админf"]
//        //menuNameArr = ["dsf", "sdf", "afds", "adsf", "asdf"]
//        iconeImage = [ UIImage(named: "products50")!, UIImage(named: "delivery50")!, UIImage(named: "reviews50")!, UIImage(named: "contacts50")!, UIImage(named: "info50")!, UIImage(named: "login50")!, UIImage(named: "info50")!, UIImage(named: "login50")! ]
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("\(menuNameArr.count)")
        return self.menuNameArr.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: Storyboard.MenuCellIdentifier, for: indexPath) as! MenuTableViewCell
        cell.imageIcon.image = iconeImage[indexPath.row]
        cell.lblMenuName.text = menuNameArr[indexPath.row]
        //cell.lblMenuName.text = "Test"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let revealViewController: SWRevealViewController = self.revealViewController()
        
        let cell: MenuTableViewCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        if cell.lblMenuName.text! == "Продукция" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "MainViewController") as! mainViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "Доставка" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "DeliveryViewController") as! DeliveryViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "Отзывы(переход на сайт)" {
            if let url = URL(string: "http://air-part.ru/reviews/") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                    // Fallback on earlier versions
                }
            }
        }
        if cell.lblMenuName.text! == "Контакты" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "ContactsViewController") as! ContactsViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "О нас" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        if cell.lblMenuName.text! == "Вход/Выход" {
            let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let desController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let newFrontViewController = UINavigationController.init(rootViewController: desController)
            
            revealViewController.pushFrontViewController(newFrontViewController, animated: true)
        }
        
        if userOnlineId != nil {
            
            if cell.lblMenuName.text! == "Задать вопрос(чат)" {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
                let newFrontViewController = UINavigationController.init(rootViewController: desController)
                
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }
            
            if userOnlineAdmin != nil {
                if userOnlineAdmin == "true" {
                    if cell.lblMenuName.text! == "Админ" {
                        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let desController = mainStoryboard.instantiateViewController(withIdentifier: "UsersViewController") as! UsersViewController
                        let newFrontViewController = UINavigationController.init(rootViewController: desController)
                        
                        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
                        //tableView.reloadData()
                    }
                }
            } else {
                
            }
        } else {
            if cell.lblMenuName.text! == "Задать вопрос(чат)" {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let desController = mainStoryboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                let newFrontViewController = UINavigationController.init(rootViewController: desController)
                
                revealViewController.pushFrontViewController(newFrontViewController, animated: true)
            }
        }
        
        
    }
    
    // MARK: +++++++++++++++++ online/offline check
    
    func onlineOfflineUser() {
        if Auth.auth().currentUser?.uid == nil {
            userOnlineId = nil
            setUpMenu()
            tableView.reloadData()
            //userOnline = "non"
        } else {
            let uid = Auth.auth().currentUser?.uid
            userOnlineId = uid
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value , with: { (snapshot) in
                if let dictionary = snapshot.value as? [String : Any] {
                    self.userOnlineAdmin = dictionary["Admin"] as? String
                    DispatchQueue.main.async {
                        self.setUpMenu()
                        self.tableView.reloadData()
                        
                    }
                }
            }, withCancel: nil)
            //onlineLabel.text = "online"
        }
    }
    
    
    struct Storyboard {
        static let MenuCellIdentifier = "MenuCell"
    }
    
    
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        print("\(menuNameArr.count)")
//        return self.menuNameArr.count
//    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
