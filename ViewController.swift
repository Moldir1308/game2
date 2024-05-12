//
//  ViewController.swift
//  game 1
//
//  Created by Мухит Молдир on 25.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    lazy var button1 = makeButton()
    lazy var button2 = makeButton()
    lazy var button3 = makeButton()
    lazy var button4 = makeButton()
    lazy var button5 = makeButton()
    lazy var button6 = makeButton()
    lazy var button7 = makeButton()
    lazy var button8 = makeButton()
    lazy var button9 = makeButton()
    lazy var button10 = makeButton()
    lazy var button11 = makeButton()
    lazy var button12 = makeButton()
    lazy var button13 = makeButton()
    lazy var button14 = makeButton()
    lazy var button15 = makeButton()
    lazy var button16 = makeButton()
    
    let emojiTexts = ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻‍❄️", "🐃", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻‍❄️", "🐃", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻‍❄️", "🐃", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻‍❄️", "🐃"].shuffled()
    
    var buttonsArray = [UIButton]()
    
    var openedCards = [UIButton]()
    
    var currentOpenedCard = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignals()
        setupUI()
        
    }
    func setupUI() {
        view.backgroundColor = .black
        
        var horizontalStackViews = [UIStackView]()
        
        for i in stride(from: 0, to: 32, by:4) {
            let stackView = makeHorizontalStackView(views: Array(buttonsArray[i...(i+3)]))
            stackView.heightAnchor.constraint(equalToConstant: 80).isActive = true
            horizontalStackViews.append(stackView)
        }
        
        
        let verticalStackView = UIStackView(arrangedSubviews: horizontalStackViews)
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 15
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(verticalStackView)
        verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        verticalStackView.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 10).isActive = true
        verticalStackView.rightAnchor.constraint(equalTo: view.rightAnchor,constant:  -10).isActive = true
        
    }
    
    func setupSignals() {
        
        for _ in 0..<32 {
            let button = makeButton()
            buttonsArray.append(button)
            
        }
        
        for buttonIndex in 0..<buttonsArray.count {
            let button = buttonsArray[buttonIndex]
            let emoji = emojiTexts[buttonIndex]
            button.setTitle(emoji, for: .selected)
            button.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        }
        
    }
    
    
    
    @objc func handleButtonPressed(button: UIButton) {
        if currentOpenedCard < 2 {
            openedCards.append(button)
            currentOpenedCard += 1
        } else if currentOpenedCard == 2 {
            print ("openedCards \(openedCards)")
            if openedCards[0].title(for: .selected) ==
                openedCards[1].title(for: .selected) {
                openedCards[0].alpha = 0
                openedCards[1].alpha = 0
            }
            
            buttonsArray.forEach {button in //({$0.isSelected = false})
                button.isSelected = false
            }
            currentOpenedCard = 1
            openedCards.removeAll()
            openedCards.append(button)
        }
        
        button.isSelected.toggle()
    }
    
    func makeHorizontalStackView(views: [UIView]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    
    func makeButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle("", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}

// MARK: - SwiftUI
import SwiftUI
@available(iOS 13.0, *)
struct MainVCProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        func updateUIViewController(_ uiViewController: MainViewController, context: Context) {
        }
        
        
        let mainVC = MainViewController()
        func makeUIViewController(context: UIViewControllerRepresentableContext<MainVCProvider.ContainerView>) -> MainViewController {
            return mainVC
        }
        
        
    }
}
