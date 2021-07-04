//
//  RecipeVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 28.06.2021.
//

import UIKit
import SafariServices

protocol RecipeVCDelegate: AnyObject {
    func deleteTapped()
}

enum LeftButtonActionType {
    case add, delete
}

class RecipeVC<T>: UIViewController where T: Info {

    let image = MealImage(frame: .zero)
    let recipeTitle = FLabel(fontSize: 20, weight: .semibold, alignment: .left)
    let cookingTimeLabel  = FLabel(fontSize: 16, weight: .regular, alignment: .left)
    let siteButton = FButton(title: "Go to website")
    let recipeInfo = FLabel(fontSize: 16, weight: .regular, alignment: .justified)
    weak var delegate: RecipeVCDelegate!
    
    var recipe: Info!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(recipe: T, buttonType: LeftButtonActionType) {
        self.init(nibName: nil, bundle: nil)
        self.recipe = recipe
        configureNavBar(buttonType: buttonType)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(image, recipeTitle, cookingTimeLabel, siteButton, recipeInfo)
        configureUI()
        configureSiteButtonAction()
    }

  
    // MARK: - Configure UI
    private func configureUI() {
        image.downloadImage(fromURL: recipe.image)
        image.layer.cornerRadius = 20
        recipeTitle.text = recipe.title
        cookingTimeLabel.text = "Will be ready in \(recipe.readyInMinutes) minutes."
        let infoText = recipe.summary.replacingOccurrences(of: #"</?b>"#, with: "", options: .regularExpression)
            .replacingOccurrences(of: #"<a.*>"#, with: "", options: .regularExpression)
            .replacingOccurrences(of: #"Similar reci.*."#, with: "", options: .regularExpression)
            .replacingOccurrences(of: #"This score.*$"#, with: "", options: .regularExpression)
        
        recipeInfo.text = infoText
        
        view.backgroundColor = .secondarySystemBackground
        recipeInfo.numberOfLines = 15
        
        let padding: CGFloat = 12
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            image.heightAnchor.constraint(equalToConstant: 250),
            
            recipeTitle.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 2 * padding),
            recipeTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeTitle.heightAnchor.constraint(equalToConstant: 30),
            
            cookingTimeLabel.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            cookingTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            cookingTimeLabel.trailingAnchor.constraint(equalTo: siteButton.leadingAnchor, constant: -padding),
            cookingTimeLabel.heightAnchor.constraint(equalToConstant: 20),
            
            siteButton.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            siteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            siteButton.heightAnchor.constraint(equalToConstant: 20),
            siteButton.widthAnchor.constraint(equalToConstant: 130),
            
            recipeInfo.topAnchor.constraint(equalTo: recipeTitle.bottomAnchor, constant: padding),
            recipeInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            recipeInfo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            recipeInfo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding)
        ])
    }
    
    
    // MARK: - Configure navigation bar
    func configureNavBar(buttonType: LeftButtonActionType) {
        switch buttonType {
        case .add:
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        case .delete:
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Remove", style: .done, target: self, action: #selector(removeButtonTapped))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
    }
    
    @objc func addButtonTapped() {
        CoreDataManager.shared.save(recipe: recipe)
    }
    
    @objc func doneButtonTapped() {
        dismiss(animated: true, completion: nil) 
    }
    
    @objc func removeButtonTapped() {
        CoreDataManager.shared.delete(recipe: recipe)
        delegate.deleteTapped()
    }
    
    
    //MARK: - Configure site button action
    func configureSiteButtonAction() {
        siteButton.addTarget(self, action: #selector(siteButtonTapped), for: .touchUpInside)
    }
    
    @objc func siteButtonTapped() {
        guard let url = URL(string: recipe.sourceUrl) else {
            presentAlertVC(title: "Something went wrong", message: FError.invalidUrl.rawValue)
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
}
