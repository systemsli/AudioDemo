//
//  AudioManger.swift
//  AudioDemo
//
//  Created by 李小龙 on 2016/11/23.
//  Copyright © 2016年 李小龙. All rights reserved.
//

import Foundation
import AVFoundation

typealias RequestRecordPermissionBlock = (Bool) -> Void

class AudioManger: NSObject, AVAudioRecorderDelegate {

    let recordSettings = [AVSampleRateKey : NSNumber(value: Float(44100.0)),//声音采样率
        AVFormatIDKey : NSNumber(value: Int32(kAudioFormatMPEG4AAC)),//编码格式
        AVNumberOfChannelsKey : NSNumber(value: 1),//采集音轨
        AVEncoderAudioQualityKey : NSNumber(value: Int32(AVAudioQuality.medium.rawValue))]
    //audioRecorder和audioPlayer，一个用于录音，一个用于播放
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var recordPath: URL!
    var isAllowed:Bool = false

    //获取音频会话单例
    let audioSession = AVAudioSession.sharedInstance()
    

    
    
    
    /// 查看是否开启麦克风权限
    ///
    /// - Parameter permssionBlock: <#permssionBlock description#>
    func getRequestRecordPermission(permssionBlock: @escaping RequestRecordPermissionBlock){
        
        audioSession.requestRecordPermission { (allowed) in
            
            self.isAllowed = allowed
            permssionBlock(allowed)
            
        }
    }
    
    
    /// 取得录音文件存放位置
    ///
    /// - Returns: <#return value description#>
    private func audioRecordData() -> URL {
        
        let currentDateTime = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        let recordingName = formatter.string(from: currentDateTime) + ".caf"
        let urlPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! + "/" + recordingName
        let url = URL(fileURLWithPath: urlPath)
        
        return url
        
    }
    
    
    /// 创建播放器
    ///
    /// - Returns: 播放器
    private func createRecord() {
        do {
  
            self.setAudioSession()
            recordPath = self.audioRecordData()
            try audioRecorder =  AVAudioRecorder(url: self.audioRecordData(), settings: recordSettings)
            
        } catch let error as NSError {
            print(error)
            
        }
    }

    
    
    private func createPlayer() {
    
        do {
            
            try audioPlayer = AVAudioPlayer(contentsOf: audioRecorder.url)
            
        } catch let error as NSError {
            print(error)
            
        }
        
    }
    
    
    /// 设置音频会话
    private func setAudioSession() {
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
        } catch let error as NSError {
            print(error)
        }
    }
    
    
    /// 开始录音
    func startRecord()  {
        if(isAllowed) {
            
            
            if audioRecorder == nil {
                self.createRecord()
            }
            
            //如果正在播放音频，则停止播放
            if audioPlayer != nil && audioPlayer.isPlaying {
                audioPlayer.stop()
            }
                
    
            if !audioRecorder.isRecording {
                do {
                    try audioSession.setActive(true)
                    audioRecorder.record()
                } catch let error as NSError{
                    print(error)
                }
            }
 
        } else {
            print("没有麦克风权限")
        }
    }
    
    
    /// 停止录音
    func stopRecord() {
        
        if audioRecorder.isRecording {
            audioRecorder.stop()
            do {
                try audioSession.setActive(false)
            } catch let error as NSError {
                print(error)
            }
        }
        
    }
    
    
    /// 开始播放
    func startPlaying() {
        
        if(!audioRecorder.isRecording) {
            
            if audioPlayer == nil {
                self.createPlayer()
            }
            
            audioPlayer.play()
        }
    }
    
    
    /// 暂停播放
    func pausePlaying() {

        audioPlayer.pause()

    }
    
    
    /// 停止播放
    func stopPlaying() {
        
        audioPlayer.stop()
        
    }
    
    /// 取得录音文件保存路径
    ///
    /// - Returns: 取得录音文件的位置
    func getRecordSavePath() -> URL {

        return audioRecorder.url

    }
}
