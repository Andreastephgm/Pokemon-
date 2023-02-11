//
//  ViewController.swift
//  who is that pokemon
//
//  Created by Alex Camacho on 01/08/22.
//

import UIKit
import Kingfisher

class PokemonViewController: UIViewController {
    
    @IBOutlet weak var pikachuImage: UIImageView!
    
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelAnswer: UILabel!
    
    @IBOutlet var buttonAnswer: [UIButton]!
    
    lazy var pokemonManager = PokemonManager()
    lazy var imageManager = ImageManager()
    lazy var gameManager = GameModel()
    
    var random4Pokemon : [PokemonModel] = []{
        didSet{
            setButtonTitles()
        }
    }
    var correctAnswer : String = ""
    var correctAnswerImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        imageManager.delegate = self
        
        createButtons()
        pokemonManager.fetchManager()
        labelAnswer.text = " "
    }
    
    func createButtons(){
        for button in buttonAnswer{
            button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.shadowOpacity = 1.0
            button.layer.shadowRadius = 0
            button.layer.masksToBounds = false
            button.layer.cornerRadius = 10.0
        }
        
    }
    
    func setButtonTitles(){
        for (index, button) in buttonAnswer.enumerated(){
            DispatchQueue.main.async {[self] in
                button.setTitle(random4Pokemon[safe: index]?.name.capitalized, for: .normal)
            }
        }
    }
    
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let userAnswer = sender.title(for: .normal)!
        
        if gameManager.checkAnswer(userAnswer, correctAnswer){
            labelAnswer.text = "si, es un \(userAnswer)!"
            labelScore.text = " Puntaje: \(gameManager.score)"
            
            
            
            sender.layer.borderColor = UIColor.systemGreen.cgColor
            sender.layer.borderWidth = 2.0
            
            let url = URL(string: correctAnswerImage)
            pikachuImage.kf.setImage(with: url)
            
            Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { Timer in
                self.pokemonManager.fetchManager()
                self.labelAnswer.text = " "
                sender.layer.borderWidth = 0
            }
            
        }else{
            //labelAnswer.text = "NOOO, es un \(correctAnswer)!"
            //sender.layer.borderColor = UIColor.systemRed.cgColor
            //sender.layer.borderWidth = 2.0
            //let url = URL(string: correctAnswerImage)
            //pikachuImage.kf.setImage(with: url)
            
            //Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { Timer in
            //  self.resetGame()
            // sender.layer.borderWidth = 0
            self.performSegue(withIdentifier: "goToResult", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult"{
            let destination = segue.destination as! ResultViewController
            destination.pokemonName = correctAnswer
            destination.finalScore = Int(gameManager.score)
            destination.pokemonUrl = correctAnswerImage
            MaxScore()
            destination.highestScore = gameManager.highHighScore
            
            resetGame()
        }
        
        func MaxScore(){
            gameManager.saveScores()
            
        }
        
        func resetGame(){
            self.pokemonManager.fetchManager()
            gameManager.setScore(score: 0)
            labelScore.text = " Puntaje: \(gameManager.score)"
            self.labelAnswer.text = " "
            
            
        }
    }
    
    
}

extension PokemonViewController:PokemonManagerDelegate{
    func didUpdatePokemon(pokemons: [PokemonModel]) {
        random4Pokemon = pokemons.choose(4)
        let index = Int.random(in: 0...3)
        let imageData = random4Pokemon[index].imageUrl
        correctAnswer = random4Pokemon[index].name
        
        imageManager.fetchImage(url: imageData)
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension PokemonViewController: ImageManagerDelegate{
    func didUpdateImage(image: ImageModel) {
       
        correctAnswerImage = image.imageUrl
        
        DispatchQueue.main.async { [self] in
            let url = URL(string: image.imageUrl)
            let effect = ColorControlsProcessor(brightness: -1, contrast: 1, saturation: 1, inputEV: 0)

            pikachuImage.kf.setImage(with: url, options:[
                .processor(effect)
            ])
        }
    }
    
    func didFailWithErrorImage(error: Error) {
        print(error)
    }
    
    
}
extension Collection where Indices.Iterator.Element == Index{
    public subscript(safe index : Index) -> Iterator.Element?{
        return (startIndex <= index && index < endIndex) ? self[index]: nil
    }
}

extension Collection{
    func choose(_ n: Int) -> Array<Element>{
        Array(shuffled().prefix(n))
    }
}


























