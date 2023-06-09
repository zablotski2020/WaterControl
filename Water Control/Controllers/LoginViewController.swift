import UIKit
import Firebase
//import CLTypingLabel

class LoginViewController: UIViewController {
    
    @IBOutlet weak var WarningLabel: UILabel!
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
//    @IBOutlet weak var HydrateTitle: CLTypingLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        HydrateTitle.text = "Water Control"
        
        EmailTextField.delegate = self
        PasswordTextField.delegate = self
        
        WarningLabel.text = ""
        
        let color = UIColor.darkGray
        let emailPlaceholder = EmailTextField.placeholder ?? ""
        EmailTextField.attributedPlaceholder = NSAttributedString(string: emailPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        let passwordPlaceholder = PasswordTextField.placeholder ?? ""
        PasswordTextField.attributedPlaceholder = NSAttributedString(string: passwordPlaceholder, attributes: [NSAttributedString.Key.foregroundColor : color])
        
        
        // завершение ввода при нажатии на область экрана вне клавиатуры
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        WarningLabel.text = ""
    }
    
    @IBAction func LoginPressed(_ sender: UIButton) {
        // функция провеки ввода электронной почты
        if let email = EmailTextField.text, let password = PasswordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    if e.localizedDescription == "The password is invalid or the user does not have a password." {
                        DispatchQueue.main.async {
                            self.WarningLabel.text = "Incorrect password"
                            self.WarningLabel.textColor = UIColor.red
                        }
                    } else if e.localizedDescription == "There is no user record corresponding to this identifier. The user may have been deleted."{
                        DispatchQueue.main.async {
                            self.WarningLabel.text = "User does not exist"
                            self.WarningLabel.textColor = UIColor.yellow
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.WarningLabel.text = e.localizedDescription
                            self.WarningLabel.textColor = UIColor.yellow
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "LoginSegue", sender: self)
                    }
                }
            }
        }
    }
}


// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
