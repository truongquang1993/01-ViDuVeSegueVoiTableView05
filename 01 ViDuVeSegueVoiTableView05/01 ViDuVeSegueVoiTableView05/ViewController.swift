//
//  ViewController.swift
//  01 ViDuVeSegueVoiTableView05
//
//  Created by Trương Quang on 6/21/19.
//  Copyright © 2019 Trương Quang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var outletTableView: UITableView!
    
    @IBOutlet weak var outletView: UIView!
    
    @IBOutlet weak var outletNoData: UILabel!
    
    @IBOutlet weak var outletItemAdd: UIBarButtonItem!
    
    @IBOutlet weak var constrainttopView: NSLayoutConstraint!
    var list = [Int](1...30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outletView.isHidden = true
        outletTableView.dataSource = self
        outletTableView.delegate = self
        navigationItem.leftBarButtonItem = editButtonItem
        outletView.layer.borderWidth = 1
        outletView.layer.borderColor = UIColor.gray.cgColor
        outletItemAdd.isEnabled = true
        
    }
    
    func showTableView (){
        if list.count == 0{
            outletNoData.isHidden = false
            outletTableView.isHidden = true
        } else {
            outletNoData.isHidden = true
            outletTableView.isHidden = false
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        outletTableView.isEditing = editing
        outletTableView.allowsMultipleSelectionDuringEditing = true
        if isEditing {
            outletView.isHidden = false
            outletItemAdd.isEnabled = false
        } else {
            outletView.isHidden = true
            outletItemAdd.isEnabled = true
        }
        
    }
    
    @IBAction func actionDeleteOfSelectionCell(_ sender: Any) {
        if let array1 = outletTableView.indexPathsForSelectedRows?.sorted().reversed() {
            for indexPath in array1 {
                print(indexPath.row)
                list.remove(at: indexPath.row)
            }
            outletTableView.deleteRows(at: Array(array1), with: .automatic)


        }
        showTableView()
    }
    
    @IBAction func actionDeleteAll(_ sender: Any) {
        list.removeAll()
        outletTableView.reloadData()
        showTableView()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if isEditing {
            return false
        } else {
            return true
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 500
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTableView()
        outletTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = outletTableView.indexPathForSelectedRow{
            if let VC2 = segue.destination as? ViewController2{
                VC2.value = list[indexPath.row]
            }
        }
    }
    
    @IBAction func unwind( segue: UIStoryboardSegue) {
        if let indexPath = outletTableView.indexPathForSelectedRow{
            if let VC2 = segue.source as? ViewController2{
                if let value = VC2.value{
                    list[indexPath.row] = value
                }
            }
        } else {
            if let VC2 = segue.source as? ViewController2{
                if let value = VC2.value{
                    list.insert(value, at: 0)
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            outletTableView.reloadData()
        }
    }
    
    
    
}

