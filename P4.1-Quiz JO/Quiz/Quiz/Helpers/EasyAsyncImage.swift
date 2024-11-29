import SwiftUI

struct EasyAsyncImage: View {
    
    var url: URL?
    
    var body: some View {
  
        AsyncImage(url: url){ phase in
            if url == nil {
                Color.yellow
            } else if let image = phase.image {
                image.resizable()
            } else if phase.error != nil{
                Color.red
            } else {
                ProgressView()
            }
        }
    }
}

/*
#Preview {
    EasyAsyncImage()
}
*/
