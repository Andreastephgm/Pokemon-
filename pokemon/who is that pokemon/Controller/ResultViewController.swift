//
//  ResultViewController.swift
//  who is that pokemon
//
//  Created by Andrea Stefanny Garcia Mejia on 24/01/23.
//

import UIKit
import Kingfisher

class ResultViewController: UIViewController {
    
    
    @IBOutlet weak var pikachuImageView: UIImageView!
    
    
    @IBOutlet weak var labelAnswer: UILabel!
    
    @IBOutlet weak var labelState: UILabel!
    
    @IBOutlet weak var labelPuntajeGameOver: UILabel!
    
    @IBOutlet weak var labelPuntajeHigest: UILabel!
    
    @IBAction func buttonReplay(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    var pokemonName:String = " "
    var pokemonUrl: String = " "
    var finalScore: Int = 0
    var highestScore: Int = 0
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelPuntajeGameOver.text = "Perdiste, tu puntaje fue de \(finalScore)"
        labelAnswer.text = "No, es un \(pokemonName)"
        pikachuImageView.kf.setImage(with: URL(string: pokemonUrl))
        labelPuntajeHigest.text = "Puntuacion Maxima Alcanzada: \(highestScore)"
        
    }
    
 
}
