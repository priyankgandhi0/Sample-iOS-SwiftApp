//
//  ViewController.swift
//  SampleiOSSwiftApp
//
//  Created by iMac on 09/07/24.
//

import UIKit
import SwiftyJSON
import UIScrollView_InfiniteScroll

class HomeVc: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    //MARK: VARIABLES
    
    var arrProductList = [JSON]()
    var refresher:UIRefreshControl?
    var pageLimit = 0
    var lblNoDataFound = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Products"
    }
    
    //MARK: SET UI
    
    func setupUI(){
        setupPullToRefresh()
        
        //Setup tableview
        setupTableView()
        
        //Get Product List API
        self.getProductListAPI(true)
        
        //Set Product List API Pagination
        self.tblView.addInfiniteScroll { tbl in
            self.getProductListAPI(false)
        }
    }
    
    @objc private func didPullToRefresh(_ sender: Any) {
        self.pageLimit = 1
        self.getProductListAPI(false)
    }
    
    func setupPullToRefresh(){
        //Registered pull to refresh control into the tableview control
        self.refresher = UIRefreshControl()
        self.refresher?.tintColor = Colors.APP_GRAY
        self.refresher?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        self.tblView.addSubview(refresher ?? UIRefreshControl())
    }
    
    //MARK: Setup TableView
    func setupTableView(){
        //Registered tableview cell
        tblView.register(ProductCell.nib, forCellReuseIdentifier: AICellNames.PRODUCT_CELL)
        tblView.separatorStyle = .none
        
        //Registered Tableview Deletgate and Datasource
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    //MARK: API METHODS
    
    func getProductListAPI(_ isShow : Bool){
        //isShow is managed Loader hide / show
        let url = "\(URL_PRODUCTS_LIST)?skip=\(self.pageLimit)&limit=10"
        
        ServiceManager.callAPI(url: url, parameter: [:],isShowLoader: isShow, httpMethod: .get) { response in
            if let dictData = JSON(response).dictionary
            {
                print(dictData)
                self.tblView.finishInfiniteScroll()
                self.refresher?.endRefreshing()
                if let obj = dictData["products"]?.arrayValue
                {
                    //If object available store array
                    if self.pageLimit <= 0{
                        self.arrProductList.removeAll()
                    }
                    self.pageLimit += 10
                    self.arrProductList += JSON(obj).arrayValue
                    self.tblView.reloadData()
                }else{
                    //If object not-available store array
                    if self.pageLimit <= 0{
                        self.arrProductList.removeAll()
                    }
                    self.pageLimit += 10
                    self.arrProductList += JSON(response).arrayValue
                    self.tblView.reloadData()
                }
            }
        } failure: { error in
            displayAlertWithMessage(error)
        } connectionFailed: { error in
            displayAlertWithMessage(error)
        }
        
    }
}

//MARK: - TABLEVIEW DELEGATE DATASOURCE METHODS

extension HomeVc:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.arrProductList.count == 0{
            lblNoDataFound.isHidden = false
            lblNoDataFound.text = AICommonText.NO_PRODUCTS
            lblNoDataFound.textAlignment = NSTextAlignment.center
            lblNoDataFound.textColor = Colors.APP_HEADER_TEXT_COLOR
            lblNoDataFound.font = UIFont.systemFont(ofSize: 16.0)
            lblNoDataFound.center = self.tblView.center
            self.tblView.backgroundView = lblNoDataFound
            return 0
        }
        lblNoDataFound.isHidden = true
        return self.arrProductList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductCell = tableView.dequeueReusableCell(withIdentifier: AICellNames.PRODUCT_CELL) as! ProductCell
        let model = arrProductList[indexPath.row]
        cell.setProductData(model)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
