//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet var yelpTable: UITableView!

    var businesses: [Business]!
    var filteredData: [Business]!
    var searchMode: Bool! = false
    var searchBar: UISearchBar!
    var isMoreDataLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        yelpTable.delegate = self
        yelpTable.dataSource = self
        yelpTable.rowHeight = UITableViewAutomaticDimension
        yelpTable.estimatedRowHeight = 120
        
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        
        navigationItem.titleView = searchBar
        
        searchData()
        
/* Example of Yelp search with more search options specified
        Business.searchWithTerm("Restaurants", sort: .Distance, categories: ["asianfusion", "burgers"], deals: true) { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        }
*/
        filteredData = businesses
    }
    
//    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = searchText.isEmpty ? businesses : businesses.filter({ (dataString: Business) -> Bool in
//            return dataString.name!.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
//        })
//    }
    
    func searchData() {
        Business.searchWithTerm("Coffee", completion: { (businesses: [Business]!, error: NSError!) -> Void in
            self.businesses = businesses
            self.filteredData = self.businesses
            
            self.yelpTable.reloadData()
            
            for business in businesses {
                print(business.name!)
                print(business.address!)
            }
        })
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredData = businesses
            searchMode = false
        } else {
            
            searchMode = true
            
            // The user has entered text into the search box
            // Use the filter method to iterate over all items in the data array
            filteredData = businesses.filter({$0.name?.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil})
        }
        yelpTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filteredData != nil {
            return filteredData.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = yelpTable.dequeueReusableCellWithIdentifier("BusinessCell", forIndexPath: indexPath) as! BusinessCell
        
        cell.business = filteredData[indexPath.row]
        
        
        return cell
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if !isMoreDataLoading {
            isMoreDataLoading = true
            
            let scrollViewContentHeight = yelpTable.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - yelpTable.bounds.size.height
            
            if scrollView.contentOffset.y > scrollOffsetThreshold && yelpTable.dragging {
                searchData()
            }
        }
    }
}
