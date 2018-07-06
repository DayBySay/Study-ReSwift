//
//  Study_ReSwiftTests.swift
//  Study-ReSwiftTests
//
//  Created by Takayuki Sei on 2018/07/06.
//  Copyright © 2018年 Takayuki Sei. All rights reserved.
//

import XCTest
import ReSwift
@testable import Study_ReSwift

class ReduxPaperSwiftTests: XCTestCase {
    func test1() {
        let store = Store<AppState>(reducer: appReducer, state: nil)
        store.dispatch(ChooseWeaponAction(weapon: .rock))
        store.dispatch(ChooseWeaponAction(weapon: .scissors))
        XCTAssertEqual(store.state.result, .player1wins)
    }
    
    func test2() {
        let store = Store<AppState>(reducer: appReducer, state: nil)
        store.dispatch(ChooseWeaponAction(weapon: .rock))
        store.dispatch(ChooseWeaponAction(weapon: .paper))
        XCTAssertEqual(store.state.result, .player2wins)
    }
}
