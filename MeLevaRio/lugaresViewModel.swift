//
//  lugaresViewModel.swift
//  MeLevaRio
//
//  Created by Renan Matias on 28/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import Foundation

protocol LugaresDelegate: class {
    // método que irá atualizar a interface com um parametro booleano de success, para indicar se o request foi feito com sucesso ou houve alguma falha na conexão com o backend.
    // em caso de sucesso atualizamos nossa interface, em caso de falha podemos exibir uma mensagem/alert ao usuário e dar a opção de tentar refazer a operação.
    func updateInterface(success: Bool)
}

class LugaresViewModel {
    
    // PROPERTIES
    
    private var lugaresResult: [lugares] = []
    
    var numberOfLugares: Int {
        return lugaresResult.count
    }
    
    // DELEGATE
    
    weak var delegate: LugaresDelegate?
    
    // INIT
    
    init(delegate: LugaresDelegate) {
        self.delegate = delegate
    }
    
    // REQUEST
    
    func downloadObjects() {
        LugaresRequest().downloadObjects { lugares, error in
            guard let objects = lugares, error == nil else {
                // HOUVE UM ERRO NA CONEXÃO
                self.delegate?.updateInterface(success: false) // avisando a interface para atualizar seu conteúdo e que houve algum problema na conexão (exemplo: exibir alerta com mensagem de erro)
                return
            }
            // OBJETOS FORAM OBTIDOS COM SUCESSO DO BACKEND, SEM NENHUMA FALHA NA CONEXÃO
            self.lugaresResult = objects // guardamos os objetos obtidos do backend em uma variavel da nossa ViewModel
            self.delegate?.updateInterface(success: true) // avisando a interface para atualizar seu conteúdo
        }
    }
    
    /// DTO
    ///
    /// - Returns:
    func getLugaresDTO() -> lugarViewDTO {
        // Estamos selecionando o primeiro elemento/index do array de objetos
        guard let lugar = lugaresResult.first?.lugar?.first else {
            return lugarViewDTO()
        }
        
        // Estamos criando um DTO com 3 informações/propriedades do nosso objeto selecionado
        let dto = lugarViewDTO(descricao: lugar.descricao,
                               latitude: lugar.latitude,
                               longitude: lugar.longitude,
                               mainImage: lugar.mainImage,
                               nome: lugar.nome,
                               images: lugar.images)
        
        // Estamos retornando nessa função um DTO com somente 3 informações, ao invés de retornar o objeto em si inteiro
        return dto
    }
    
}
