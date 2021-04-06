//
//  ViewController.swift
//  TestConekta
//
//  Created by David Guia on 05/04/21.
//

import UIKit
import RxCocoa
import RxSwift

final class LoginViewController: UIViewController {
    
    @IBOutlet private weak var lblValidationMessage: UILabel! {
        didSet {
            lblValidationMessage.isHidden = true
            lblValidationMessage.textColor = UIColor.red
        }
    }
    
    @IBOutlet private weak var txtUser: UITextField! {
        didSet {
            txtUser.placeholder = "Ingresar usuario o correo"
            txtUser.textAlignment = NSTextAlignment.center
        }
    }
    @IBOutlet private weak var txtPasword: UITextField! {
        didSet {
            txtPasword.placeholder = "Ingresar password"
            txtPasword.textAlignment = NSTextAlignment.center
            txtPasword.isSecureTextEntry = true
        }
    }
    @IBOutlet private weak var continueButton: UIButton! {
        didSet {
            continueButton.setTitleColor(UIColor.white, for: .normal)
            continueButton.backgroundColor = UIColor.blue
            continueButton.layer.cornerRadius = 5
            continueButton.setTitle("Continuar", for: .normal)
        }
    }
    
    private let disposeBag: DisposeBag = DisposeBag()
    private let testModel = TestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        view.backgroundColor = UIColor(red: 244.0 / 255.0, green: 243.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblValidationMessage.isHidden = true
        txtUser.text = ""
        txtPasword.text = ""
    }
}

extension LoginViewController {
    
    func bind() {
        continueButton.rx.tap
            .throttle(.milliseconds(350), scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                guard let self = self else { return }
                self.continueNextScreen()
            }.disposed(by: disposeBag)
    }
    
    func continueNextScreen() {
        
        if txtUser.text?.count == 0 || txtPasword.text?.count == 0 {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Por favor ingresar todos los datos"
            return
        }
        if testModel.isValidEmail(emailID: txtUser.text ?? "") == false {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "Por favor ingresar un e-mail valido"
            return
        }
        if txtUser.text != testModel.validateUser() {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "El usuario o correo es incorrecto"
            return
        }
        if txtPasword.text != testModel.validatePassword() {
            lblValidationMessage.isHidden = false
            lblValidationMessage.text = "La contraseña es incorrecta"
            return
        }
        lblValidationMessage.isHidden = true
        performSegue(withIdentifier: "goToInfoData", sender: self)
    }
}
