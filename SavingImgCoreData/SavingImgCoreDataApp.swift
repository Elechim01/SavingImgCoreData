//
//  SavingImgCoreDataApp.swift
//  SavingImgCoreData
//
//  Created by Michele on 14/01/21.
//

import SwiftUI

@main
struct SavingImgCoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
//        @Environment(\.managedObjectContext) var moc
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
