import CarPlay
import MediaPlayer

class CarPlaySceneDelegate: UIResponder, CPTemplateApplicationSceneDelegate {
    var interfaceController: CPInterfaceController?
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                   didConnect interfaceController: CPInterfaceController) {
        self.interfaceController = interfaceController
        
        let playButton = CPNowPlayingImageButton(image: UIImage(systemName: "play.circle.fill")!) { _ in
            RadioPlayerManager.shared.play()
        }
        
        let stopButton = CPNowPlayingImageButton(image: UIImage(systemName: "stop.circle.fill")!) { _ in
            RadioPlayerManager.shared.stop()
        }
        
        let template = CPNowPlayingTemplate.shared
        template.updateNowPlayingButtons([playButton, stopButton])
        
        interfaceController.setRootTemplate(template, animated: true)
    }
    
    func templateApplicationScene(_ templateApplicationScene: CPTemplateApplicationScene,
                                   didDisconnect interfaceController: CPInterfaceController) {
        self.interfaceController = nil
    }
}

class RadioPlayerManager {
    static let shared = RadioPlayerManager()
    private var player: AVPlayer?
    
    func play() {
        let url = URL(string: "https://radio.akli.hu/radio/live")!
        player = AVPlayer(url: url)
        player?.play()
    }
    
    func stop() {
        player?.pause()
        player = nil
    }
}

