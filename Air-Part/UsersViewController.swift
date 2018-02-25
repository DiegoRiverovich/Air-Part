//
//  UsersViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 30.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit
import Firebase

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        sideMenus()
        customizeNavBar()
        
        tableView.register(UserCell.self, forCellReuseIdentifier: UserConstants.cellId)
        
        fetchUser()

        // Do any additional setup after loading the view.
    }
    
    func fetchUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { [ weak self ] (snapshot) in
            if let dictionary = snapshot.value as? [String : Any] {
                var user: User? = User()
                user?.id = snapshot.key
                user?.setValuesForKeys(dictionary)
                //print(user.name!, user.email!, user.Admin!)
                self?.users.append(user!)
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
                user = nil
            }
            //print(snapshot)
            
            
        }, withCancel: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: UserConstants.cellId)
        let cell = tableView.dequeueReusableCell(withIdentifier: UserConstants.cellId, for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let  chatViewController = ChatViewController()
//        present(chatViewController, animated: true, completion: nil)
        
        
//        let revealViewController: SWRevealViewController = self.revealViewController()
//        
//        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let desController = mainStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//        let newFrontViewController = UINavigationController.init(rootViewController: desController)
//        
//        revealViewController.pushFrontViewController(newFrontViewController, animated: true)
//        desController.userNameLabel.text = "yo"
        
//        let  chatViewController = ChatViewController()
//        let navController = UINavigationController(rootViewController: chatViewController)
//        present(navController, animated: true, completion: nil)
        
        let chatUser = users[indexPath.row]
        performSegue(withIdentifier: UserConstants.sequeId, sender: chatUser)
        //users.removeAll()
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case UserConstants.sequeId:
                if let vc = segue.destination as? ChatViewController {
                    vc.chatUser = sender as? User
                    //sender = nil
                }
            default: break
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
    
    // MARK: +++++++++++++++++ online/offline check
    
    func onlineOfflineLabel() {
        if Auth.auth().currentUser?.uid == nil {
            //onlineLabel.text = "offline"
        } else {
            //onlineLabel.text = "online"
        }
    }
    
    struct UserConstants {
        static let cellId = "cellId"
        static let sequeId = "show messages of the user"
    }
    
    deinit {
        print("UserViewCont deinit")
    }

}


//class UserCell: UITableViewCell {
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
