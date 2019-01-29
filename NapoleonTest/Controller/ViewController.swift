//
//  ViewController.swift
//  NapoleonTest
//
//  Created by Роман Тищенко on 15/12/2018.
//  Copyright © 2018 Роман Тищенко. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate,
                      UITableViewDelegate, UITableViewDataSource,
                      UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var topTenButton: UIButton!
    @IBOutlet weak var shopsButton: UIButton!
    @IBOutlet weak var goodsButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private lazy var networkManager = NetworkManager()
    let heightForHeaderInBannerSection: CGFloat = 0.0
    let heightForHeaderInOfferSection: CGFloat = 32.0
    let collectionViewCellHeight: CGFloat = 160.0
    let collectionViewCellWidth: CGFloat = 250.0
    let heightForBannerRowAt: CGFloat = 210.0
    let heightForOfferRowAt: CGFloat = 105.0
    
    var sectionList: [[String: Int]] = [["Banner": 1]]
    var bannerImageList: [UIImage] = []
    var offerImageList: [UIImage] = []
    var hostErrorTemp: HostError?
    var bannerDataList = [Banner]()
    var offerDataList = [Offer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIComponents()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        getBannersData()
        getOffersData()
        getImagesForBanners()
        getImagesForOffers()
        fillSectionList()
    }
    
    @IBAction func topTenButtonPressed(_ sender: UIButton) {
        ButtonStateStyle.Selected(button: sender)
        ButtonStateStyle.NotSelected(button: shopsButton)
        ButtonStateStyle.NotSelected(button: goodsButton)
    }
    
    @IBAction func shopsButtonPressed(_ sender: UIButton) {
        ButtonStateStyle.Selected(button: sender)
        ButtonStateStyle.NotSelected(button: topTenButton)
        ButtonStateStyle.NotSelected(button: goodsButton)
    }
    
    @IBAction func goodsButtonPressed(_ sender: UIButton) {
        ButtonStateStyle.Selected(button: sender)
        ButtonStateStyle.NotSelected(button: shopsButton)
        ButtonStateStyle.NotSelected(button: topTenButton)
    }
    
    @IBAction func infoButtonPressed(_ sender: UIButton) {
        let infoAlert = UIAlertController(title: "Внимание", message: "Когда-нибудь тут будет информация", preferredStyle: .alert)
        infoAlert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(infoAlert, animated: true)
    }
    
    func fillSectionList () {
        var groupNameList: [String] = []
        var rowsInGroupName: [Int] = []
        for offerData in offerDataList {
            if !groupNameList.contains(offerData.groupName){
                groupNameList.append(offerData.groupName)
            }
        }
        
        for groupName in groupNameList {
            var counter = 0
            for offerData in offerDataList {
                if offerData.groupName == groupName { counter += 1 }
            }
            rowsInGroupName.append(counter)
        }
        
        for index in 0...(groupNameList.count - 1) {
            sectionList.append([groupNameList[index]: rowsInGroupName[index]])
        }
        
        print(sectionList)
    }
    
    func setUpUIComponents () {
        ButtonStateStyle.Selected(button: topTenButton)
        topTenButton.layer.cornerRadius = 15
        shopsButton.layer.cornerRadius = 15
        goodsButton.layer.cornerRadius = 15
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
    func showAlertMessage(message: String) {
        let infoAlert = UIAlertController(title: "Упс", message: message, preferredStyle: .alert)
        infoAlert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        self.present(infoAlert, animated: true)
    }
    
    private func getImagesForBanners () {
        let bannerImageDataList = networkManager.getImageData(entityDataList: bannerDataList)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        for bannerImageData in bannerImageDataList {
            if bannerImageData != nil {
                let image = UIImage(data: bannerImageData!)
                bannerImageList.append(image!)
            } else {
                let image = UIImage(named: "no_image.svg")
                bannerImageList.append(image!)
            }
        }
    }
    
    private func getImagesForOffers () {
        let offerImageDataList = networkManager.getImageData(entityDataList: offerDataList)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        for offerImageData in offerImageDataList {
            if offerImageData != nil {
                let image = UIImage(data: offerImageData!)
                offerImageList.append(image!)
            } else {
                let image = UIImage(named: "no_image.svg")
                offerImageList.append(image!)
            }
        }
    }
    
    private func getBannersData() {
        networkManager.getBanners { (result) in
            switch result {
            case .SuccessGetBannersRequest(let banners):
                self.bannerDataList = banners
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .ServerSideFailureRequest(let hostError):
                self.hostErrorTemp = hostError
                DispatchQueue.main.async {
                    self.showAlertMessage(message: hostError.message)
                }
            case .LocalSideFailure(let error):
                DispatchQueue.main.async {
                    self.showAlertMessage(message: error)
                }
            default:
                break
            }
        }
    }
    
    private func getOffersData() {
        networkManager.getOffers { (result) in
            switch result {
            case .SuccessGetOffersRequest(let offers):
                self.offerDataList = offers
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .ServerSideFailureRequest(let hostError):
                self.hostErrorTemp = hostError
                DispatchQueue.main.async {
                    self.showAlertMessage(message: hostError.message)
                }
            case .LocalSideFailure(let error):
                DispatchQueue.main.async {
                    self.showAlertMessage(message: error)
                }
            default:
                break;
            }
        }
    }
    
    //MARK: - Tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (sectionList[section].first?.value)!
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == 0 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return heightForHeaderInBannerSection
        } else {return heightForHeaderInOfferSection}
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.text = ("    " + (sectionList[section].first?.key)!).uppercased()
        header.font = UIFont.systemFont(ofSize: 14)
        header.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9254901961, blue: 0.9529411765, alpha: 1)
        header.textColor = UIColor.darkGray
        header.layer.borderWidth = 1
        header.layer.borderColor = UIColor.lightGray.cgColor
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let bannerTalbeCell = tableView.dequeueReusableCell(withIdentifier: "BannerTableCell_ID") as! BannerTableCell
           
            bannerTalbeCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            let insetX = (bannerTalbeCell.bounds.width - collectionViewCellWidth) / 3.1
            let insetY = (bannerTalbeCell.bounds.height - collectionViewCellHeight) / 2.0
            let flowLayout = bannerTalbeCell.collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
            
            flowLayout.itemSize = CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight)
            bannerTalbeCell.collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
            
            return bannerTalbeCell
        } else {
            let offerTableCell = tableView.dequeueReusableCell(withIdentifier: "OfferTableCell_ID") as! OfferTableCell
            offerTableCell.setUpStyleForCell()
            offerTableCell.updateCell(offer: offerDataList[indexPath.row], offerImage: offerImageList[indexPath.row])
            return offerTableCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0 {
            return heightForBannerRowAt
        } else {return heightForOfferRowAt}
    }
    
    //MARK: - CollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerDataList.count
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView is UICollectionView {
            let bannerCollectionView = scrollView as! UICollectionView
            let layout = bannerCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
            var offset = targetContentOffset.pointee
            let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
            let roundedIndex = round(index)
            offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
            targetContentOffset.pointee = offset
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bannerCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BannerCollectionCell_ID", for: indexPath) as! BannerCollectionCell
        bannerCollectionCell.setUpStyleForCell()
        bannerCollectionCell.updateCell(banner: bannerDataList[indexPath.row], bannerImage: bannerImageList[indexPath.row])

        return bannerCollectionCell
    }
}

