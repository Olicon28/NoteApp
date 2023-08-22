//
//  CreateNoteView.swift
//  Notas
//
//  Created by alvaro.concha on 24-07-23.
//

import Foundation
import UIKit

protocol CreateNoteViewProtocol{
    func didTapSelector()
    func tapAddNote()
    func canEdit(edit: Bool)
    func showAlert()
}

class CreateNoteView: UIView{
    
    var delegate: CreateNoteViewProtocol
    var noteViewModel: Note
    var action: ActionEnum
    
    lazy var title: UITextField = {

        
        let textfield = UITextField(frame: .zero)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.isUserInteractionEnabled = true
        textfield.text = ""
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 8
        textfield.text = ""
        textfield.textColor = UIColor.darkText
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.delegate = self
        textfield.placeholder = "Escriba un titulo aquí"
        
        
        return textfield
    }()
    
    lazy var descriptionNote: UITextField = {
        let textfield = UITextField(frame: .zero)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textfield.frame.height))
        textfield.leftView = paddingView
        textfield.leftViewMode = .always
        textfield.isUserInteractionEnabled = true
        textfield.text = ""
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.font = UIFont.systemFont(ofSize: 16)
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        textfield.layer.cornerRadius = 8
        textfield.textColor = UIColor.darkText
        textfield.backgroundColor = UIColor.white
        textfield.placeholder = "Ingresa tus comentarios..."
        textfield.delegate = self
        return textfield
    }()
    
    lazy var selector: UIButton = {
        let btn = UIButton()
        btn.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        btn.addTarget(self, action: #selector(tapSelector), for: .touchUpInside)
        btn.setTitle("Selector", for: .normal)
        btn.backgroundColor = .systemGray6
        btn.setTitleColor( .lightGray, for: .normal)
        btn.layer.cornerRadius = 8
        btn.contentHorizontalAlignment = .left
        btn.translatesAutoresizingMaskIntoConstraints = false
        
        return btn
    }()
    
    lazy var body: UITextView = {
        let textView = UITextView(frame: .zero)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.isEditable = true
        textView.text = ""
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.text = "Escriba su nota aquí"
        textView.textColor = UIColor.lightGray
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        
        return textView
    }()
    
    lazy var buttonAceptar: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Aceptar", for: .normal)
        btn.addTarget(self, action: #selector(tapAddNote), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var buttonEdit: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitleColor(.systemBlue, for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Editar", for: .normal)
        btn.addTarget(self, action: #selector(canEdit), for: .touchUpInside)
        
        return btn
    }()
    
    lazy var clearButton: UIButton = {
        let btn = UIButton(frame: .zero)
        btn.setTitle("Limpiar", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(tapClear), for: .touchUpInside)
        
        return btn
    }()
    
    init(delegate: CreateNoteViewProtocol, noteViewModel: Note, action: ActionEnum) {
        self.delegate = delegate
        self.noteViewModel = noteViewModel
        self.action = action
        
        super.init(frame: .zero)
        
        self.addSubview(title)
        self.addSubview(descriptionNote)
        self.addSubview(selector)
        self.addSubview(body)
        self.addSubview(buttonEdit)
        self.addSubview(buttonAceptar)
        if self.action == .edit {
            self.buttonAceptar.layer.isHidden = true
            self.buttonEdit.layer.isHidden = false
        }else{
            self.buttonEdit.layer.isHidden = true
            self.buttonAceptar.layer.isHidden = false
        }
        
        
        self.backgroundColor = .white
        setupView(action: self.action)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CreateNoteView: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("LOG_--textFieldDidBeginEditing")
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("LOG_--textFieldShouldBeginEditing")
        guard let text = textField.text else { return false}
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("LOG_--textFieldShouldEndEditing")
        guard let text = textField.text else { return false}
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        print("LOG_--textFieldDidEndEditing")
    }
}

extension CreateNoteView{
    private func setupView(action: ActionEnum){
        
        if action == .edit {
            self.title.isUserInteractionEnabled = false
            self.descriptionNote.isUserInteractionEnabled = false
            self.selector.isUserInteractionEnabled = false
            self.body.isUserInteractionEnabled = false
        }
        
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            self.title.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.title.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.title.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.title.heightAnchor.constraint(equalToConstant: 50),
            
            self.descriptionNote.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 24),
            self.descriptionNote.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.descriptionNote.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.descriptionNote.heightAnchor.constraint(equalToConstant: 60),
            
            self.selector.topAnchor.constraint(equalTo: self.descriptionNote.bottomAnchor, constant: 24),
            self.selector.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.selector.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.selector.heightAnchor.constraint(equalToConstant: 50),
            
            self.body.topAnchor.constraint(equalTo: self.selector.bottomAnchor, constant: 24),
            self.body.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.body.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.body.bottomAnchor.constraint(equalTo: self.buttonEdit.topAnchor),
            //self.body.heightAnchor.constraint(equalToConstant: 300),
            self.buttonEdit.topAnchor.constraint(equalTo: self.body.bottomAnchor, constant: 24),
            self.buttonEdit.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.buttonEdit.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.buttonEdit.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            self.buttonAceptar.topAnchor.constraint(equalTo: self.body.bottomAnchor, constant: 24),
            self.buttonAceptar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.buttonAceptar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.buttonAceptar.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc
    func canEdit(){
        self.buttonEdit.isHidden = true
        self.buttonAceptar.isHidden = false
        
        self.title.isUserInteractionEnabled = true
        self.title.layer.borderColor = UIColor.systemBlue.cgColor
        self.title.textColor = .darkText
        
        
        self.descriptionNote.isUserInteractionEnabled = true
        self.descriptionNote.layer.borderColor = UIColor.systemBlue.cgColor
        self.descriptionNote.textColor = .darkText
        
        self.selector.isUserInteractionEnabled = true
        self.selector.layer.borderColor = UIColor.systemBlue.cgColor
        self.selector.setTitleColor(.darkText, for: .normal)
        self.selector.layer.borderWidth = 1
        
        self.body.isUserInteractionEnabled = true
        self.body.layer.borderColor = UIColor.systemBlue.cgColor
        self.body.textColor = .darkText
        self.body.layer.borderWidth = 1
        
        self.buttonEdit.removeFromSuperview()
        self.addSubview(self.buttonAceptar)
        
    }
    
    @objc
    func tapSelector(){
        self.delegate.didTapSelector()
    }
    @objc
    func tapAddNote(){
        self.delegate.tapAddNote()
    }
    @objc
    func tapClear(){
        self.delegate.tapAddNote()
    }

}

extension CreateNoteView: UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Escriba su nota aquí"
            textView.textColor = UIColor.lightGray
        }
    }
}


