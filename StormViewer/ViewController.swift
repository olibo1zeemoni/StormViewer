//
//  ViewController.swift
//  StormViewer
//
//  Created by Olibo moni on 04/02/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [String]()
    var images = [UIImage]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasPrefix("nssl"){
                pictures.append(item)
                images.append(UIImage(named: item)!)
            }
            
        }
        
        print(pictures)
        
        
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return pictures.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Storm", for: indexPath)
        var content = cell.defaultContentConfiguration()
        
        pictures.sort()
        //images.sort()
        cell.accessoryType = .disclosureIndicator
        //cell.accessoryView?.tintColor = .blue
        content.text = pictures[indexPath.row]
        content.textProperties.font = UIFont.boldSystemFont(ofSize: 20)
//cell?.textLabel?.text = pictures[indexPath.row]
        
        content.imageProperties.maximumSize = CGSize(width: 44.0, height: 44.0)
        content.imageProperties.cornerRadius = 5
        content.imageProperties.tintColor = .blue
        content.image = images[indexPath.row]
        
        
        cell.contentConfiguration = content
        
        
        return cell
    }

    @IBSegueAction func showDetail(_ coder: NSCoder, sender: Any?) -> DetailVC? {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let photo = images[indexPath!.row]
        let imageName = "Image \(indexPath!.row + 1) of \(images.count)"
        
        return DetailVC(photo: photo,imageName: imageName, coder: coder)
    }
    
    
    
    
}

//extension UIImage: Comparable {
//    public static func <(lhs: UIImage, rhs: UIImage)-> Bool{
//        return lhs < rhs
//    }
//    static func ==(lhs: UIImage, rhs: UIImage)-> Bool{
//        return rhs == lhs
//    }
//}
