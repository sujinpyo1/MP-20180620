//
//  AddNoteViewController.swift
//  W13
//
//  Created by SWUCOMPUTER on 2018. 6. 19..
//  Copyright © 2018년 SWUCOMPUTER. All rights reserved.
//

import UIKit
import CoreData

class AddNoteViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var textDay: UITextField!
    @IBOutlet var textTime: UITextField!
    @IBOutlet var textLocation: UITextField!
    @IBOutlet var textTitle: UITextField!
    @IBOutlet var content: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }

    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "TravelNote", in: context)
        // TravelInformation record를 새로 생성함
        let object = NSManagedObject(entity: entity!, insertInto: context)
        object.setValue(textTitle.text, forKey: "title")
        object.setValue(textDay.text, forKey: "date")
        object.setValue(textTime.text, forKey: "time")
        object.setValue(content.text, forKey: "content")
        object.setValue(textLocation.text, forKey: "location")
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        // 현재의 View를 없애고 이전 화면으로 복귀
        self.navigationController?.popViewController(animated: true)
    }
    
}
