//
//  ViewController.swift
//  L2AssignmentProject
//
//  Created by Luan Nguyen on 2019-09-23.
//  Copyright © 2019 Luan Nguyen. All rights reserved.
//

import UIKit


class ViewController: UIViewController{
    
    var groceryLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Grocery List:"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    var quantityLabel: UILabel  = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quantity:"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    var buttonToAddItems: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Item", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.addTarget(self, action: #selector(addItemToTextView), for: .touchUpInside)
        return button
    }()
    
    var groceryTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.backgroundColor = .lightGray
        txt.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        txt.adjustsFontSizeToFitWidth = true
        txt.textAlignment = .center
        txt.layer.opacity =  0.8
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        txt.keyboardAppearance = .dark
        txt.textColor = .white
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        txt.attributedPlaceholder = NSAttributedString(string: "What items?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle:centeredParagraphStyle])
        txt.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return txt
    }()
    var quantityTextField: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.backgroundColor = .lightGray
        txt.textColor = .white
        txt.textAlignment = .center
        txt.layer.opacity =  0.8
        txt.clipsToBounds = true
        txt.keyboardType = .numberPad
        txt.keyboardAppearance = .dark
        txt.layer.cornerRadius = 10
        txt.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        txt.adjustsFontSizeToFitWidth = true
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        txt.attributedPlaceholder = NSAttributedString(string: "How many?", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.paragraphStyle: centeredParagraphStyle])
        txt.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return txt
    }()
    
    var textViewForItems: UITextView = {
        let txt = UITextView()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.backgroundColor = .black
        txt.textColor = .white
        txt.font = UIFont.boldSystemFont(ofSize: 12)
        txt.clipsToBounds = true
        txt.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        txt.layer.cornerRadius = 10
        txt.isEditable = false
        return txt
    }()
    
    var removeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Remove", for: .normal)
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.addTarget(self, action: #selector(removeItemFromList), for: .touchUpInside)
        return button
    }()
    
    var sortButtonAlphabetically: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sort", for: .normal)
        button.backgroundColor = .green
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        button.addTarget(self, action: #selector(sortItems), for: .touchUpInside)
        return button
    }()
    
    var arrayOfItemsAdded: [GroceryItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Shopping List"
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .black
        addToViews()
        setupConstraints()
        quantityTextField.delegate = self
        groceryTextField.delegate = self
    }
    
    @objc func addItemToTextView() {
        textViewForItems.text = "Buy: \n"
        var groceryItemWritten: String?
        var quantityWritten: String?
        groceryItemWritten = groceryTextField.text
        quantityWritten = quantityTextField.text
        
        if let item = groceryItemWritten, let item2 = quantityWritten  {
            let newGroceryItem = GroceryItem(name: item, quantity: item2)
            arrayOfItemsAdded.append(newGroceryItem)
            printItemsInArray()
        }
        
    }
    
    func printItemsInArray() {
        
        for (_, element) in arrayOfItemsAdded.enumerated() {
            
            let  addedString = "- \(element.quantity) \(element.name)\n"
            textViewForItems.text += addedString
        }
        
    }
    
    @objc func removeItemFromList() {
        if arrayOfItemsAdded.count > 0 {
            arrayOfItemsAdded.removeLast()
        }
        textViewForItems.text = " Buy: \n"
        printItemsInArray()
        
    }
    @objc func sortItems () {
        arrayOfItemsAdded.sort {
               $0.name < $1.name
           }
        textViewForItems.text = " Buy: \n"
        printItemsInArray()
    }
    
    @objc func textFieldDidChange() {
        buttonToAddItems.isEnabled = false
        
        guard let first = groceryTextField.text, first != "" else {
            print("Grocery textfield is empty")
            return
        }
        guard let second = quantityTextField.text, second != "" else {
            print("Quantity textfield is empty")
            return
        }
        guard let _ = Int(quantityTextField.text!) else {
            print("Failed convert")
            return
        }
        buttonToAddItems.isEnabled = true
    }

}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

extension ViewController {
    
    func addToViews() {
        view.addSubview(groceryLabel)
        view.addSubview(quantityLabel)
        view.addSubview(buttonToAddItems)
        view.addSubview(groceryTextField)
        view.addSubview(quantityTextField)
        view.addSubview(textViewForItems)
        view.addSubview(removeButton)
        view.addSubview(sortButtonAlphabetically)
        
        
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            groceryLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            groceryLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            groceryLabel.heightAnchor.constraint(equalToConstant: 30),
            groceryLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            groceryTextField.leadingAnchor.constraint(equalTo: groceryLabel.trailingAnchor, constant: 20),
            groceryTextField.heightAnchor.constraint(equalToConstant: 30),
            groceryTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            groceryTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            quantityLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            quantityLabel.topAnchor.constraint(equalTo: groceryLabel.bottomAnchor, constant: 20),
            quantityLabel.heightAnchor.constraint(equalToConstant: 30),
            quantityLabel.widthAnchor.constraint(equalToConstant: 150)
            //                   quantityLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -650)
        ])
        NSLayoutConstraint.activate([
            quantityTextField.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 20),
            quantityTextField.heightAnchor.constraint(equalToConstant: 30),
            quantityTextField.topAnchor.constraint(equalTo: groceryTextField.bottomAnchor, constant: 20),
            quantityTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        NSLayoutConstraint.activate([
            
            buttonToAddItems.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonToAddItems.topAnchor.constraint(equalTo: quantityLabel.bottomAnchor, constant: 50),
            buttonToAddItems.widthAnchor.constraint(equalToConstant: 120),
            buttonToAddItems.heightAnchor.constraint(equalToConstant:  30)
        ])
        
        NSLayoutConstraint.activate([
            textViewForItems.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textViewForItems.topAnchor.constraint(equalTo: buttonToAddItems.bottomAnchor, constant: 50),
            textViewForItems.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textViewForItems.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textViewForItems.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
        
        NSLayoutConstraint.activate([
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            removeButton.topAnchor.constraint(equalTo: textViewForItems.bottomAnchor, constant: 40),
            removeButton.widthAnchor.constraint(equalToConstant: 120),
            removeButton.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        NSLayoutConstraint.activate([
            sortButtonAlphabetically.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            sortButtonAlphabetically.topAnchor.constraint(equalTo: textViewForItems.bottomAnchor, constant: 40),
            sortButtonAlphabetically.widthAnchor.constraint(equalToConstant: 120),
            sortButtonAlphabetically.heightAnchor.constraint(equalToConstant: 30)
            
        ])
        
    }
}

