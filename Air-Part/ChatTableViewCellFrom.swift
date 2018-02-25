//
//  ChatTableViewCell.swift
//  Air-Part
//
//  Created by Андрей Бабий on 05.09.17.
//  Copyright © 2017 Андрей Бабий. All rights reserved.
//

import UIKit

class ChatTableViewCellFrom: UITableViewCell {
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var sendTimeLabel: UILabel!
    
    @IBOutlet weak var cellContentView: UIView!
    
    @IBOutlet weak var sendImageView: UIImageView?
    
    @IBOutlet var cellPicFromConstrain: NSLayoutConstraint!
    
    weak var chatViewController: ChatViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.cellContentView.layer.cornerRadius = 15
        self.cellContentView.layer.masksToBounds = true
        
        sendImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleZoomTap)))
        sendImageView?.isUserInteractionEnabled = true
    }
    
    @objc func handleZoomTap(tapGesture: UITapGestureRecognizer) {
        if let imageView = tapGesture.view as? UIImageView {
            self.chatViewController?.performZoomInForImageView(startingImageView: imageView)
        }
    }

    override func draw(_ rect: CGRect) {
        let trianglePath = UIBezierPath()
        let startPoint = CGPoint(x: 20.0, y: self.bounds.height - 40)
        let tipPoint = CGPoint(x: 0.0, y: self.bounds.height - 30)
        let endPoint = CGPoint(x: 20.0, y: self.bounds.height - 20)
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: tipPoint)
        trianglePath.addLine(to: endPoint)
        trianglePath.close()
        //UIColor.lightGray.setStroke()
        UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).setStroke()
        //UIColor.lightGray.setFill()
        UIColor(red: 214/255, green: 214/255, blue: 214/255, alpha: 1).setFill()
        trianglePath.stroke()
        trianglePath.fill()
    }
    


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
