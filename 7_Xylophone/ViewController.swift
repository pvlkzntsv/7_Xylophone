//
//  ViewController.swift
//  7_Xylophone
//
//  Created by pvl kzntsv on 24.01.2023.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    var player = AVAudioPlayer()
    
    private let xylophoneStackView: UIStackView = {
        let xylophone = UIStackView()
        xylophone.alignment = .center
        xylophone.distribution = .fillEqually
        xylophone.spacing = 10
        xylophone.axis = .vertical
        xylophone.translatesAutoresizingMaskIntoConstraints = false
        return xylophone
    }()
    
    func makeButtons() {
        let notesArray = ["C", "D", "E", "F", "G", "A", "B"]
        for (i, note) in notesArray.enumerated() {
            let button = UIButton(type: .system)
            button.setTitle(note, for: .normal)
            button.backgroundColor = UIColor(named: note) ?? .gray
            xylophoneStackView.addArrangedSubview(button)
            button.addAction(UIAction { _ in self.playSound(button)}, for: .touchUpInside)
            button.addAction(UIAction{_ in self.fadeView(button as UIView) }, for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalTo: xylophoneStackView.widthAnchor, multiplier: ( 1 - CGFloat(i + 1) * 0.05) ).isActive = true
            }
    }
    
    func fadeView(_ sender: UIView) {
        sender.layer.opacity = 0.5
        Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false) { _ in sender.layer.opacity = 1 }
    }
    
    func playSound(_ sender: UIButton) {
        guard let note = sender.titleLabel?.text else { return }
        let url = Bundle.main.url(forResource: note, withExtension: "wav")
                player = try! AVAudioPlayer(contentsOf: url!)
                player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        makeButtons()
        view.addSubview(xylophoneStackView)
        NSLayoutConstraint.activate([
            xylophoneStackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            xylophoneStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 1),
            xylophoneStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            xylophoneStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            xylophoneStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            xylophoneStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

