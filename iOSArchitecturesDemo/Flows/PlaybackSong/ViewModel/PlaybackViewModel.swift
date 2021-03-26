//
//  PlaybackViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol PlaybackViewModelInput {
    func play()
    func pause()
    func stop()
}

protocol PlaybackViewModelOutput {
    var onProgressViewChanged: ((Double) -> Void)? { get set }
}

class PlaybackViewModel: PlaybackViewModelInput, PlaybackViewModelOutput {
    var onProgressViewChanged: ((Double) -> Void)?
    var timer: Timer?
    var progress: Double {
        didSet {
            onProgressViewChanged?(progress)
        }
    }
    
    init(progress: Double, onProgressViewChanged: ((Double) -> Void)?) {
        self.progress = progress
        self.onProgressViewChanged = onProgressViewChanged
        onProgressViewChanged?(progress)
    }
    
    func play() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] (timer) in
            guard let self = self else { return }
            
            let newProgress = self.progress + 0.05
            if self.progress == 1 {
                timer.invalidate()
            }
            self.progress = min(newProgress, 1)
        })
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func stop() {
        timer?.invalidate()
        progress = 0
    }
}
