//
//  ContentView.swift
//  SavingImgCoreData
//
//  Created by Michele on 14/01/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(entity: Saving.entity(), sortDescriptors:[
        NSSortDescriptor(keyPath: \Saving.user, ascending: true),
        NSSortDescriptor(keyPath: \Saving.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Saving.favo, ascending: false),
        NSSortDescriptor(keyPath: \Saving.descriptions, ascending: true)
    ]) var savings : FetchedResults<Saving>
    @State var image : Data = .init(count:0)
    @State var show = false
    var body: some View {
        NavigationView{
//            I will remove the list separator now by implementing Scroll View and forEach
            ScrollView(.vertical,showsIndicators: false) {
                ForEach(savings,id:\.self){ save in
                    VStack(alignment:.leading){
                        Image(uiImage: UIImage(data: save.imageD ?? self.image)!)
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width - 34, height: 210)
                            .cornerRadius(15)
                        HStack {
                            Text("\(save.descriptions ?? "")")
                            Spacer()
                            Button(action: {
                                save.favo.toggle()
                                try? self.moc.save()
                            }, label: {
                                Image(systemName: save.favo ? "bookmark.fill": "bookmark")
                            })
                            
                        }
                        Text("\(save.user ?? "")")
                            .font(.callout)
                            .foregroundColor(.secondary)
    //                   I've already done in this view
    //                   Lets create the sender info view
                    }
                    
                }.padding()
            }.navigationBarTitle("News",displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                    self.show.toggle()
                }, label: {
                    Image(systemName: "camera.fill")
            }))
            
        }
        .sheet(isPresented: self.$show, content: {
            SenderView().environment(\.managedObjectContext, self.moc)
//            Lets run the app only to see how it looks like
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
