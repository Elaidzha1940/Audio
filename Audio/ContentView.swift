//  /*
//
//  Project: Audio
//  File: ContentView.swift
//  Created by: Elaidzha Shchukin
//  Date: 14.08.2023
//
//  Status: in progress | Decorated
//
//  */

import SwiftUI
import AVKit

struct ContentView: View {
    
    let audioFileName = "dj"
    
    @State private var player: AVAudioPlayer?
    
    @State private var isPlaying = false
    @State private var totalTime: TimeInterval = 0.0
    @State private var currentTime: TimeInterval = 0.0
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    @State private var animationContent: Bool = false
    
    var body: some View {
        
        VStack {
          
            
        }
    }
    
    private func setupAudio() {
        guard let url = Bundle.main.url(forResource: audioFileName, withExtension: "mp3")
        else {
            return
        }
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            totalTime = player?.duration ?? 0.0
        } catch {
            print("Error oading")
        }
    }
    private func playAudio() {
        player?.play()
        isPlaying = true
         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(expandSheet: .constant(true), animation: Namespace().wrappedValue)
            .preferredColorScheme(.dark)
    }
}

extension View {
    
    var deviceCornerRadius: CGFloat {
        
        let key = "_displayCornerRadius"
        
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
            return 0
        }
        return 0

    }
}
