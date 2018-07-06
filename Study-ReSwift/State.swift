//
//  State.swift
//  Study-ReSwift
//
//  Created by Takayuki Sei on 2018/07/06.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import ReSwift

// MARK: - STATE
struct AppState: StateType {
    var message: Message
    var turn: Turn
    var player1Play: Play
    var player2Play: Play
    var result: Result?

    init() {
        self.message = .player1choose
        self.turn = Turn(player: .one)
        self.player1Play = Play(chosen: false, weapon: nil)
        self.player2Play = Play(chosen: false, weapon: nil)
    }
}

enum Message: String {
    case player1choose = "Player 1 - Choose your weapon:"
    case player2choose = "Player 2 - Choose your weapon"
    case player1wins =  "Player 1 WINS!"
    case player2wins = "Player 2 WINS!"
    case draw = "DRAW!"
}

struct Turn {
    var player: Player
}

enum Player {
    case one
    case two
}

struct Play {
    var chosen: Bool
    var weapon: Weapon?
}

enum Weapon: String {
    case rock = "Rock"
    case paper = "Paper"
    case scissors = "Scissors"
}

enum Result {
    case draw
    case player1wins
    case player2wins
}

// MARK: - ACTIONS

struct ChooseWeaponAction: Action {
    var weapon: Weapon
}

// MARK: - REDUCERS

func appReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    case let chooseWeaponAction as ChooseWeaponAction:
        let turn = state.turn

        switch turn.player {
        case .one:
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)
            state.player1Play = play
            state.turn = Turn(player: .two)
            state.message = .player2choose
        case .two:
            let play = Play(chosen: true, weapon: chooseWeaponAction.weapon)
            state.player2Play = play
            let player1weapon = state.player1Play.weapon ?? .rock
            let player2weapon = state.player2Play.weapon ?? .rock
            
            switch player1weapon {
            case .rock:
                switch player2weapon {
                case .rock:
                    state.result = .draw
                    state.message = .draw
                case .paper:
                    state.result = .player2wins
                    state.message = .player2wins
                case .scissors:
                    state.result = .player1wins
                    state.message = .player1wins
                }
            case .paper:
                switch player2weapon {
                case .rock:
                    state.result = .player1wins
                    state.message = .player1wins
                case .paper:
                    state.result = .draw
                    state.message = .draw
                case .scissors:
                    state.result = .player2wins
                    state.message = .player2wins
                }
            case .scissors:
                switch player2weapon {
                case .rock:
                    state.result = .player2wins
                    state.message = .player2wins
                case .paper:
                    state.result = .player1wins
                    state.message = .player1wins
                case .scissors:
                    state.result = .draw
                    state.message = .draw
                }
            }
        }
    default:
        break
    }

    return state
}
