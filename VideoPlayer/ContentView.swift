import AVKit
import SwiftUI

struct ContentView: View {
    
    // http://bbb3d.renderfarming.net/download.html
    // https://github.com/iptv-org/iptv
    // https://github.com/iptv-org/iptv/blob/master/streams/ca.m3u
    
    var body: some View {
        //@State var player = AVPlayer(url: URL(string: "https://download.blender.org/peach/bigbuckbunny_movies/BigBuckBunny_640x360.m4v")!)
        @State var player = AVPlayer(url: URL(string: "https://citynewsregional.akamaized.net/hls/live/1024052/Regional_Live_7/master.m3u8")!)
        //@State var player = AVPlayer(url: Bundle.main.url(forResource: "video", withExtension: "mp4")!)
        VideoPlayer(player: player)
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            //.ignoresSafeArea()
            .onAppear {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: .landscape))
                NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: nil, queue: .main) { _ in
                    player.seek(to: .zero)
                    player.play()
                }
                player.play()
            }
            .background(.black)
    }
}

#Preview {
    ContentView()
}
