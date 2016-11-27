//
//  AudioRecordViewController.swift
//  AudioDemo
//
//  Created by 李小龙 on 2016/11/25.
//  Copyright © 2016年 李小龙. All rights reserved.
//

import UIKit

class AudioRecordViewController: UIViewController {

    var recordManger: AudioManger?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        recordManger = AudioManger()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func startRecord(_ sender: Any) {
        recordManger?.getRequestRecordPermission(permssionBlock: { (allowed) in
            if(allowed == true) {
                self.recordManger?.startRecord()
                
            } else {
                
            }
        })
    }

    @IBAction func stopRecord(_ sender: Any) {
        
        self.recordManger?.stopRecord()
        
    }
    
    @IBAction func startPlaying(_ sender: Any) {
        
        self.recordManger?.startPlaying()
        
    }
    
    @IBAction func pausePlaying(_ sender: Any) {
        
        self.recordManger?.pausePlaying()
        
    }
    
    @IBAction func stopPlaying(_ sender: Any) {
        
        self.recordManger?.stopPlaying()
        
    }
    

}
