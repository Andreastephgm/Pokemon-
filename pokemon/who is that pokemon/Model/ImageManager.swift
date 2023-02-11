//
//  ImageManager.swift
//  who is that pokemon
//
//  Created by Andrea Stefanny Garcia Mejia on 19/01/23.
//

import Foundation

protocol ImageManagerDelegate{
    func didUpdateImage(image:ImageModel)
    func didFailWithErrorImage(error:Error)
}

struct ImageManager{
    var delegate: ImageManagerDelegate?
    
    func fetchImage(url:String){
        imageRequest(with: url)
    }
    
    private func imageRequest ( with urlString: String){
        //1.create url
        if let url = URL(string: urlString){
            //2. create url session
            let session = URLSession(configuration: .default)
            //3. give the session a task
            let task = session.dataTask(with: url){data,response, error in
                if error != nil{
                    self.delegate?.didFailWithErrorImage(error: error!)
                }
                if let safeData = data{
                    if let image = self.parseJSON(imageData: safeData ){
                        self.delegate?.didUpdateImage(image: image)
                    }
                }
            }
            // 4. start task
            task.resume()
        }
    }
    
    private func parseJSON(imageData: Data) -> ImageModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodeData = try decoder.decode(ImageData.self, from: imageData)
            let image = decodeData.sprites?.other?.officialArtwork?.frontDefault ?? ""
            
            return ImageModel(imageUrl: image)
        }
        
        catch{
            return nil
        }
    }
    
}
