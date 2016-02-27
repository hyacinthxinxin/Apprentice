//
//  AddItemTableViewController.swift
//  Checklist
//
//  Created by fanxin on 16/2/11.
//  Copyright © 2016年 fanxin. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemTableViewControllerDidCancel(controller: AddItemTableViewController)
    func addItemTableViewController(controller: AddItemTableViewController, didFinishAddingItem item: ChecklistItem)
}

class AddItemTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    var itemToEdit: ChecklistItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    @IBAction func done(sender: AnyObject) {
        print("Contents of the text field: \(textField.text!)")
        let item = ChecklistItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemTableViewController(self, didFinishAddingItem: item)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        delegate?.addItemTableViewControllerDidCancel(self)
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
}

extension AddItemTableViewController: UITextFieldDelegate {
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let oldText: NSString = textField.text!
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range, withString: string)
        doneBarButton.enabled = (newText.length > 0)
        return true
    }
}
