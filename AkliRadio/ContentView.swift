import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject private var radioPlayer = RadioPlayer()
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Akli Radio")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Image(systemName: radioPlayer.isPlaying ? "stop.circle.fill" : "play.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            
            Button(action: {
                radioPlayer.togglePlayback()
            }) {
                Text(radioPlayer.isPlaying ? "Stop" : "Play")
                    .font(.title)
                    .padding()
                    .frame(width: 200)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            
            Text(radioPlayer.isPlaying ? "Playing..." : "Stopped")
                .foregroundColor(.gray)
        }
        .padding()
    }
}

class RadioPlayer: ObservableObject {
    @Published var isPlaying = false
    private var player: AVPlayer?
    
    let streamURL = "https://radio.akli.hu/radio/live"
    
    func togglePlayback() {
        if isPlaying {
            stop()
        } else {
            play()
        }
    }
    
    func play() {
        guard let url = URL(string: streamURL) else { return }
        player = AVPlayer(url: url)
        player?.play()
        isPlaying = true
    }
    
    func stop() {
        player?.pause()
        player = nil
        isPlaying = false
    }
}

