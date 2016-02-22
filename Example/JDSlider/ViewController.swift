//
//  ViewController.swift
//  JDSlider
//
//  Created by David López on 02/22/2016.
//  Copyright (c) 2016 David López. All rights reserved.
//

import UIKit
import JDSlider

class ViewController: UIViewController, JDSliderDataSource, JDSliderDelegate {

    //MARK: @IBOutlet
    @IBOutlet var sliderView: JDSliderView!
    
    //MARK: Properties
    var arrayImages = ["lorempixel", "lorempixel-1", "lorempixel-2"]
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sliderView.delegate    = self
        self.sliderView.datasource  = self

        self.sliderView.tintPageIndicator(UIColor.orangeColor(), state: .Highlight)
        self.sliderView.tintPageIndicator(UIColor.blackColor(), state: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: JDSliderDelegate
    func slider(jdSlider: JDSliderView, didSelectSlideAtIndex index: Int) {
        
        print("Touch slide with index: \(index)")
    }
    
    //MARK: JDSliderDataSource
    func slider(jdSliderNumberOfSlides slider: JDSliderView) -> Int {
        return 3
    }
    
    func slider(jdSlider: JDSliderView, viewForSlideAtIndex index: Int) -> UIView {

        if index == 2 {
            
            let vc = UINib(nibName: "slideExample", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
            return vc
            
        } else {
            
            let imageView = UIImageView()
            imageView.image = UIImage(named: self.arrayImages[index])
            
            return imageView
        }
    }
}

