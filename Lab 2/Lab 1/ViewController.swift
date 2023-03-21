//
//  ViewController.swift
//  Lab 1
//
//  Created by Paul Angelo Sy on 2/22/23.
//

import UIKit

struct Pokemon: Codable {
    var name: String
    var url: String
}

struct PokemonList: Codable{
    let results: [Pokemon]
}



class tableViewController: UITableViewController {
    
    var pokemonName: [String] = []

    func decode(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let decoder = JSONDecoder()
            if let data = data {
                do {
                    let tasks = try decoder.decode(PokemonList.self, from: data)
                    tasks.results.forEach { i in
                        self?.addPokemon(name: i.name)
                    }
                    completion()
                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    func addPokemon(name: String) {
        pokemonName.append(name)
    }

    func getPokemon(completion: @escaping ([String]) -> Void) {
        decode {
            completion(self.pokemonName)
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "tableViewCell", bundle: nil), forCellReuseIdentifier: "cellTemplate")
        tableView.delegate = self
        tableView.dataSource = self
        getPokemon { [weak self] pokemon in
            self?.pokemonName = pokemon
            self?.tableView.reloadData()
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellTemplate", for: indexPath) as? tableViewCell else {
            return UITableViewCell()
        }
        cell.cellLabel.text = pokemonName[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonName.count
    }
}
