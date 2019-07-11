//
//  LoginViewController.swift
//  PLE
//
//  Created by Lukman Hakim Japri on 05/07/2019.
//  Copyright © 2019 Lukman Hakim Japri. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var request: Webservice?
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPwd: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var errorMsg = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("viewDidLoad LoginViewController")
        
        txtEmail.text = "ayum9422@gmail.com"
        txtPwd.text = "123456"
        
        setupView()
    }
    
    func setupView() -> Void {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    func validation() -> Bool {
        if (txtEmail.text?.replacingOccurrences(of: " ", with: "") == "") || (txtPwd.text == "") {
            errorMsg = "All fields are required."
            return false
        }
        
        return true
    }
    
    @IBAction func btnLoginClicked(_ sender: Any) {
        print("btnLoginClicked")
        
        if validation() {
            userLogin()
        }
        else {
            let alert = UIAlertController(title: "Error", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - API
    
    func userLogin() -> Void {
        
        startLoadingView()
        
        let email = txtEmail.text
        let password = txtPwd.text
        
        request = Webservice()
        let urlRequest :NSMutableURLRequest? = request?.userLogin(email: email, password: password)
        
        print("urlRequest : \(String(describing: urlRequest))")
        
        let requestTask = URLSession.shared.dataTask(with: urlRequest! as URLRequest) {
            (data: Data?, response: URLResponse?, error: Error?) in
            
            if(error != nil) {
                print("Error: \(String(describing: error))")
            }else {
                guard let data = data else { return }
                let stringData = (String(data: data, encoding: .utf8)!)
                let dict = self.convertToDictionary(text: stringData)
                
                print(dict!)
                
                if (dict! .value(forKey: "status")! as! NSInteger == 1) {
                    print("true")
                    
                    self.hideLoadingView()
                    let view = HomeViewController()
                    self.present(view, animated: true)
                }
                else {
                    print("false")
                    self.hideLoadingView()
                    let ErrorMsg = dict! .value(forKey: "message")!
                    
                    let alert = UIAlertController(title: "Error", message: ErrorMsg as? String, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                //print(dict! .value(forKey: "message")!)
                
                //let returnedData = dict! .value(forKey: "data")! as! NSDictionary
                //print(returnedData)
                
                //print(returnedData .value(forKey: "token")!)
                //self.getPostArticles(token: returnedData .value(forKey: "token")! as! String)
            }
        }
        requestTask.resume()
    }
    
    public  func convertToDictionary(text: String) -> NSDictionary? {
        print("converting")
        if let data = text.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    
    // MARK: - Keyboard Show Handler
    
    @objc func keyboardWasShown(_ notification: Notification?) {
        let info = notification?.userInfo
        var keyboardRect: CGRect? = (info?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue
        keyboardRect = view.convert(keyboardRect ?? CGRect.zero, from: nil)
        
        var contentInset: UIEdgeInsets = scrollView.contentInset
        contentInset.bottom = keyboardRect?.size.height ?? 0.0
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillBeHidden(_ notification: Notification?) {
        let contentInsets: UIEdgeInsets = .zero
        scrollView.contentInset = contentInsets
    }
    
    // MARK: - TextField Delegate
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textFieldDidBeginEditing")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textFieldDidEndEditing")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn")
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - LoadingView
    
    func startLoadingView() -> Void {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func hideLoadingView() -> Void {
        dismiss(animated: false, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
