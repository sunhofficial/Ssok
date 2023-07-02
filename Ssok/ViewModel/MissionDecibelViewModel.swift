//
//  MissionDecibelViewModel.swift
//  Ssok
//
//  Created by 김민 on 2023/06/29.
//

import Foundation
import AVFoundation

class MissionDecibelViewModel: ObservableObject {

    @Published var decibels: Float = 0.0
    @Published var isCompleted = false

    let engine = AVAudioEngine()
    let playerNode = AVAudioPlayerNode()
    let bufferSize: AVAudioFrameCount = 4096
    
    init() {
        let input = engine.inputNode
        let busNum = 0
        let hardwareSampleRate = input.inputFormat(forBus: busNum).sampleRate
        let recordingFormat = AVAudioFormat(standardFormatWithSampleRate: hardwareSampleRate, channels: 1)!

        engine.attach(playerNode)
        engine.connect(playerNode, to: engine.mainMixerNode, format: input.inputFormat(forBus: busNum))

        input.installTap(onBus: busNum,
                         bufferSize: bufferSize,
                         format: recordingFormat) { [weak self] (buffer, _) in
            guard let self = self else { return }

            buffer.frameLength = self.bufferSize

            let channelDataValue = buffer.floatChannelData?.pointee
            let channelData = UnsafeBufferPointer(start: channelDataValue, count: Int(buffer.frameLength))

            var decibels: Float = 0.0

            if !channelData.isEmpty {
                let rootMeanSquare = sqrt(channelData.reduce(0) {$0 + pow($1, 2)} / Float(channelData.count))
                decibels = 20.0 * log10(rootMeanSquare)
            }

            DispatchQueue.main.async {
                self.decibels = self.normalizeDecibel(decibels)
            }
        }
    }

    func start() throws {
        try engine.start()
        playerNode.play()
    }

    func stop() {
        engine.stop()
        playerNode.stop()
        engine.inputNode.removeTap(onBus: 0)
        decibels = 0.0
    }

    func setPercentage(_ goal: String) -> Float {
        return decibels / Float(goal)!
    }

    func isMissionCompleted(_ goal: String) {
        if decibels >= Float(goal)! {
            isCompleted = true
            stop()
        }
    }

    private func normalizeDecibel(_ decibel: Float) -> Float {
        let lowLevel: Float = -70.0
        let highLevel: Float = 0.0
        var level = max(0.0, decibel - lowLevel)
        level = min(level, highLevel - lowLevel)
        return level
    }
}
