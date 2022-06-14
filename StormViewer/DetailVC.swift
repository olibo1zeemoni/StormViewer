//
//  DetailVC.swift
//  StormViewer
//
//  Created by Olibo moni on 04/02/2022.
//

import UIKit

class DetailVC: UIViewController {
    
    var photo: UIImage
    var imageName: String
    
    init?(photo: UIImage, imageName: String, coder: NSCoder){
        self.photo = photo
        self.imageName = imageName
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var imageViewer = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = imageName
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItem?.tintColor = .white

        imageViewer.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height )
        imageViewer.image = photo
        //imageViewer.contentMode = .scaleAspectFit
        view.addSubview(imageViewer)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    let action = UIAction(title: "share Action", subtitle: nil , image: .checkmark, identifier: nil , discoverabilityTitle: nil, attributes: .disabled, state: .on) { share in
        print("share tapped")
    }
    
    @objc func shareTapped(){
        guard let imageToShare = imageViewer.image?.jpegData(compressionQuality: 0.8) else {
            print("no image found")
            return}
        
        let vc = UIActivityViewController(activityItems: [imageToShare], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
        print("action button tapped")
    }
   

}
