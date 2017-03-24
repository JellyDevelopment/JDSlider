//
//  JDSlider.swift
//  Pods
//
//  Created by David López Carrascal on 22/2/16.
//  Copyright ©2016 David López Carrascal. All rights reserved.
//
//

import UIKit

//MARK: JDSliderDataSource
public protocol JDSliderDataSource: class {
    
    func slider(jdSliderNumberOfSlides slider: JDSliderView) -> Int
    func slider(_ slider: JDSliderView, viewForSlideAtIndex index: Int) -> UIView
}

//MARK: JDSliderDelegate
public protocol JDSliderDelegate: class {
    
    func slider(_ slider: JDSliderView, didSelectSlideAtIndex index: Int)
}

//MARK: JDSliderView
open class JDSliderView: UIView {
    
    //MARK: Enum
    public enum StatePageIndicator{
        case normal
        case highlight
    }

    //MARK:Public Properties
    open weak var delegate      : JDSliderDelegate?
    open weak var datasource    : JDSliderDataSource?
    
    //MARK:Private Properties
    fileprivate var numbersOfSlides    : Int = 0
    fileprivate var jdSliderScrollView : UIScrollView!
    open var pageControl         : UIPageControl!

    
    //MARK: Init
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self._setUpUI()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self._setUpUI()
    }
    
    //MARK: LifeCycle
    open override func layoutSubviews() {
        super.layoutSubviews()
        self._adapterUI()
        self._prepareDataSource()
    }

    //MARK: Selector
    func handleTap(_ sender: UITapGestureRecognizer){
        self.delegate?.slider(self, didSelectSlideAtIndex: self.pageControl.currentPage)
    }
    
    //MARK: Public Methods
    open func tintPageIndicator(_ color: UIColor, state: StatePageIndicator){
        
        switch state {
            case .normal:
                self.pageControl.pageIndicatorTintColor = color
                break
            case .highlight:
                self.pageControl.currentPageIndicatorTintColor = color
                break
        }
    }
    
    open func setCurrentPageIndicator(tintColor color: UIColor){
        self.pageControl.currentPageIndicatorTintColor = color
    }
    
    open func reloadData(){
        self._adapterUI()
        self._prepareDataSource()
    }
    
    //MARK: Private Methods
    fileprivate func _prepareDataSource(){
        if let dataSource = self.datasource {
            
            //Set number of slides
            self.numbersOfSlides = dataSource.slider(jdSliderNumberOfSlides: self)
            self.pageControl.numberOfPages = self.numbersOfSlides
            
            //Set widht and height
            let scrollViewWidth  : CGFloat  = self.jdSliderScrollView.frame.width
            let scrollViewHeight : CGFloat  = self.jdSliderScrollView.frame.height
            
            if self.numbersOfSlides == 0 {
                
                self.pageControl.isHidden        = true
                self.jdSliderScrollView.isHidden = true
                
            } else if self.numbersOfSlides > 0{
                
                for i in 0...(self.numbersOfSlides - 1) {
                    
                    let x      = CGFloat(i) * scrollViewWidth
                    let view   = dataSource.slider(self, viewForSlideAtIndex: i)
                    view.frame = CGRect(x: x, y: 0, width: scrollViewWidth, height: scrollViewHeight)
                    self.jdSliderScrollView.addSubview(view)
                }
                
                self.jdSliderScrollView.contentSize = CGSize(width: self.jdSliderScrollView.frame.width * CGFloat(self.numbersOfSlides), height: self.jdSliderScrollView.frame.height)
                
                self.jdSliderScrollView.delegate = self
                self.pageControl.currentPage     = 0
            }
            
            let singleTap = UITapGestureRecognizer(target: self, action: #selector(JDSliderView.handleTap(_:)))
            singleTap.cancelsTouchesInView = false
            self.jdSliderScrollView.addGestureRecognizer(singleTap)

        }
    }
    
    fileprivate func _setUpUI(){
        
        //Setup ScrollView
        self.jdSliderScrollView = UIScrollView()
        
        self.jdSliderScrollView.isScrollEnabled = true
        self.jdSliderScrollView.isPagingEnabled = true
        self.jdSliderScrollView.bounces       = false
        
        self.jdSliderScrollView.showsHorizontalScrollIndicator = false
        self.jdSliderScrollView.showsVerticalScrollIndicator   = false
        
        self.addSubview(self.jdSliderScrollView)
        
        //Setup PageControl
        self.pageControl = UIPageControl()
        self.addSubview(self.pageControl)
    }
    
    fileprivate func _adapterUI(){

        self.jdSliderScrollView.frame = self.frame
        self.pageControl.frame.origin.x = self.center.x - self.pageControl.frame.width/2
        self.pageControl.frame.origin.y = self.frame.size.height - 20
    }
}

//MARK: UIScrollViewDelegate
extension JDSliderView: UIScrollViewDelegate {
    
    public func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        if scrollView == self.jdSliderScrollView {
            
            // Test the offset and calculate the current page after scrolling ends
            let pageWidth:CGFloat   = self.jdSliderScrollView.frame.size.width
            let currentPage:CGFloat = floor((self.jdSliderScrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
            
            self.pageControl.currentPage = Int(currentPage);
        }
    }
}
