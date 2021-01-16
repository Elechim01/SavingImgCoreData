//
//  SenderView.swift
//  SavingImgCoreData
//
//  Created by Michele on 14/01/21.
//

import SwiftUI

struct SenderView: View {
//    I only need this moc here to send all the info to the main view
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State var nome = ""
    @State var description = ""
    @State var image : Data = .init(count:0)
    @State var show = false
    var body: some View {
        NavigationView {
            VStack{
                if self.image.count != 0{
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        Image(uiImage: UIImage(data: self.image)!)
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .cornerRadius(6)
                        
                    })
                }else{
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        Image(systemName: "photo.fill")
                            .font(.system(size: 55))
                            .foregroundColor(.blue)
                    })
                    
                }
                TextField("description...", text: self.$description)
                    .padding()
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(20)
                TextField("name...", text: self.$nome)
                    .padding()
                    .background(Color(red: 233.0/255, green: 234.0/255, blue: 243.0/255))
                    .cornerRadius(20)
    //            Lets create button to make a action
                Button(action: {
    //                Now lets give action to our button
                    let send = Saving(context: self.moc)
//                    send.user = self.nome
                    send.descriptions = self.description
                    print(self.image)
                    send.imageD = self.image
                    try? self.moc.save()
                    self.presentationMode.wrappedValue.dismiss()
                    self.nome = ""
                    self.description = ""
                }, label: {
                    Text("Send").fixedSize()
                        .frame(width: 250,height: 30)
                        .foregroundColor((self.nome.count > 0 && self.description.count > 0 && self.image.count > 0) ? Color.white: Color.black)
    //                Lets do the same with the background color
                        .background((self.nome.count > 0 && self.description.count > 0 && self.image.count > 0) ? Color.blue: Color.gray)
                        .cornerRadius(13)
                })
                }
                .sheet(isPresented: self.$show, content: {
                    ImagePicker(show: self.$show, image: self.$image)
            })
            .navigationBarItems(trailing: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Cancel")
            }))
        }
            
    }
}

struct SenderView_Previews: PreviewProvider {
    static var previews: some View {
        SenderView()
    }
}
