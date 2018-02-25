//
//  ViewController.swift
//  Air-Part
//
//  Created by Андрей Бабий on 17.08.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var menuNameArr: Array = [String]()
    var productImage: Array = [UIImage]()
    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    @IBOutlet weak var toolButton: UIBarButtonItem!
    
    @IBOutlet weak var ProductCollectionView: UICollectionView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ProductCollectionView.delegate = self
        self.ProductCollectionView.dataSource = self
        self.ProductCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        
        menuNameArr = ["Компрессоры", "Осушители", "Генераторы газов", "Вакуумные насосы", "Циклонные сепараторы", "Магистральные фильтры и элементы", "Доп оборудование", "Масло", "Гидравлические фильтры и элементы", "Конденсатоотводчики", "Подобрать по габаритам", "Абсорбернт для осушителей", "Фильтрация Parket", "Разделение конденсата", "Турбокомпрессоры", "Дизельные генераторы", "Угольные колонны", "Полезная информация", "Спецтехника", "Сервис 24"]
        productImage = [ UIImage(named: "kompressor")!, UIImage(named: "osushiteli")!, UIImage(named: "generatori-gazov")!, UIImage(named: "vakuumnye-nasosy")!, UIImage(named: "ciklonnye-separatory")!, UIImage(named: "magistralnie-filtri")!, UIImage(named: "oborudovanie")!, UIImage(named: "maslo")!, UIImage(named: "gidravlika")!, UIImage(named: "kondensatootvodchiki")!,UIImage(named: "podobrat-filtr")!, UIImage(named: "adsorbent")!, UIImage(named: "filtracija-parker")!, UIImage(named: "razdelenie_kondensata")!, UIImage(named: "turbokompressory")!, UIImage(named: "dizelnye-generatory")!, UIImage(named: "ugolnye-kolonny")!, UIImage(named: "inform")!, UIImage(named: "spectehnika")!, UIImage(named: "servis")!  ]
        
        sideMenus()
        
        customizeNavBar()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: ++++++++++++++++++++ UICollection delegate functions
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.menuNameArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size: CGSize = CGSize.zero
        if menuNameArr[indexPath.row] == "Спецтехника" {
            size = CGSize(width: 375, height: 151)
        } else {
            size = CGSize(width: 100, height: 141)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Storyboard.ProductCell, for: indexPath) as! ProductCollectionViewCell

        return fillCells(cell: cell, indexPath:  indexPath)
    }
    
    func fillCells(cell: ProductCollectionViewCell, indexPath: IndexPath) ->ProductCollectionViewCell {
        
        if menuNameArr[indexPath.row] == "Спецтехника" {
            //cell.frame = CGRect(x: cell.frame.origin.x, y: cell.frame.origin.y, width: 410, height: 110)
            //cell.productImage.frame = CGRect(x: 0, y: 0, width: 410, height: 110)
            cell.productImage.frame.size.width = 375
            //cell.productImage.frame.size.height = 110
            cell.productImage.image = productImage[indexPath.row]
            //cell.productImage.layer.borderWidth = 2
            //cell.productImage.layer.borderColor = UIColor.black.cgColor
            //cell.productImage.sizeToFit()
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
            //cell.backgroundColor = UIColor.brown
        } else if menuNameArr[indexPath.row] == "Фильтрация Parket" {
            cell.productImage.frame.size.width = 58
            cell.productImage.image = productImage[indexPath.row]
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
        } else if menuNameArr[indexPath.row] == "Угольные колонны" {
            cell.productImage.frame.size.width = 23
            cell.productImage.image = productImage[indexPath.row]
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
        } else if menuNameArr[indexPath.row] == "Подобрать по габаритам" {
            cell.productImage.frame.size.width = 75
            cell.productImage.image = productImage[indexPath.row]
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
        } else if menuNameArr[indexPath.row] == "Разделение конденсата" {
            cell.productImage.frame.size.width = 67
            cell.productImage.image = productImage[indexPath.row]
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
        } else if menuNameArr[indexPath.row] == "Доп оборудование" {
            cell.productImage.frame.size.width = 58
            cell.productImage.image = productImage[indexPath.row]
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
        }
            
            
        else {
            cell.productImage.image = productImage[indexPath.row]
            cell.productLabel.text = menuNameArr[indexPath.row]
            cell.productLabel.textColor = UIColor.gray
            cell.productLabel.font = UIFont.boldSystemFont(ofSize: 12)
            
        }
        
        return cell
    }
    
    // MARK: ++++++++++++++++++++ Customization funcs
    
    func sideMenus() {
        if revealViewController() != nil {
            menuButton.target = revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            revealViewController().rearViewRevealWidth = Constants.leftTableWidth
            revealViewController().rightViewRevealWidth = Constants.rightTableWidth
            
            toolButton.target = revealViewController()
            toolButton.action = #selector(SWRevealViewController.rightRevealToggle(_:))
            
            view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
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
    
    func customizeMenuTableView() {
        
    }
    
    struct Storyboard {
        static let ProductCell = "ProductCell"
    }
    
    deinit {
        print("MainViewCont deinit")
    }
    
}

