//
//  ViewController.swift
//  Xylophone
//
//  Created by Андрей Яфаркин on 24.03.2022.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var notes: [UIButton]!
    var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var counts = 0.0
        
        for note in notes {
            note.isHidden = true
            Timer.scheduledTimer(withTimeInterval: counts, repeats: false) { timer in
                self.playSound(soundName: (note.titleLabel?.text)!)
                note.isHidden = false
            }
            counts += 0.55
        }
    }
    
    @IBAction func keyPressed(_ sender: UIButton) {
        
        // узнаем тайтл найших кнопок
        let buttonTitle = sender.titleLabel?.text
        //устанавливаем в нашу функцию тайтлы
        playSound(soundName: buttonTitle!)
        // уменьшаем непрозрачность кнопки
        sender.alpha = 0.5
        // после нажатия восстанавливается автоматически непрозрачность после 0,2 сек
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.alpha = 1
        }
        
        let currentColor = sender.backgroundColor
        sender.backgroundColor = .cyan
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            sender.backgroundColor = currentColor
        }
    }
    
    func playSound (soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player =  try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}


