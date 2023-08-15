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
        
        GeometryReader  {
            
            let size = $0.size
            let safeArea = $0.safeAreaInsets
            
            ZStack {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                        Image("grandpa")
                            .blur(radius: 55)
                    })
                
                VStack(spacing: 15) {
                    GeometryReader {
                        
                        let size = $0.size
                        Image("grandpa")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    .frame(height: size.width - 50)
                    .padding(.vertical, size.height < 700 ? 10 : 30)
                    
                    PlayerView(size)
                    
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .ignoresSafeArea(.container, edges: .all)
        }
        
        .onAppear(perform: setupAudio)
        .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { _ in
            updateProgress()
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
    private func stopAudio() {
        player?.pause()
        isPlaying = false
    }
    private func updateProgress() {
        guard let player = player else { return }
        currentTime = player.currentTime
    }
    private func seekAudio(to time: TimeInterval) {
        player?.currentTime = time
    }
    private func timeString(time: TimeInterval) -> String {
        let minute = Int() / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Dj Mix")
                                .font(.system(size: 30, weight: .bold, design: .default))
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            //action
                        } label: {
                            Image(systemName: "ellipsis.circle.fill")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                )
                        }
                    }
                    
                    Slider(value: Binding(get: {
                        currentTime
                    }, set: { newValue in
                        seekAudio(to: newValue)
                    }), in: 0...totalTime)
                    .foregroundColor(.white)
                    
                    HStack {
                        
                        Text(timeString(time: currentTime))
                        Spacer()
                        Text(timeString(time: totalTime))
                    }
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                HStack(spacing: size.width * 0.18) {
                    
                    Button {
                        //action
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .system(size: 30, weight: .bold, design: .monospaced) : .system(size: 30, weight: .bold, design: .monospaced))
                    }
                    
                    Button {
                        //action
                    } label: {
                        Image(systemName: isPlaying ? "pause.fill" : "play.fill")
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                            .onTapGesture {
                                isPlaying ? stopAudio() : playAudio()
                            }
                    }
                    
                    Button {
                        //action
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .system(size: 30, weight: .bold, design: .monospaced) : .system(size: 30, weight: .bold, design: .monospaced))
                    }
                }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                VStack(spacing: spacing) {
                    
                    HStack(spacing: 15 ) {
                        Image(systemName: "speaker.fill")
                        
                        Capsule()
                            .fill(.ultraThinMaterial)
                            .environment(\.colorScheme, .light)
                            .frame(height: 5)
                        Image(systemName: "speaker.wave.3.fill")
                    }
                    .padding()
                    
                    HStack(alignment: .top, spacing: size.width * 0.18) {
                        
                        Button {
                            //action
                        } label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                        }
                        
                        VStack(spacing: 6) {
                            
                            Image(systemName: "airpodspro.chargingcase.wireless.fill")
                                .font(.title2)
                                .foregroundColor(.gray)
                            
                            Text("Elaidzha's Airpods")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Image(systemName: "list.dash")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            .accentColor(.white)
        }
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
