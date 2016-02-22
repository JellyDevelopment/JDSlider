# JDSlider

[![Version](https://img.shields.io/cocoapods/v/JDSlider.svg?style=flat)](http://cocoapods.org/pods/JDSlider)
[![License](https://img.shields.io/cocoapods/l/JDSlider.svg?style=flat)](http://cocoapods.org/pods/JDSlider)
[![Platform](https://img.shields.io/cocoapods/p/JDSlider.svg?style=flat)](http://cocoapods.org/pods/JDSlider)

![Preview](https://github.com/JellyDevelopment/JDSlider/blob/master/beetripper.gif)  
*[Beetripper App's screenshots](http://beetripper.com)*

## Example Project

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

JDSlider is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "JDSlider"
```
### Manual

Clone the repository:

```bash
$ git clone https://github.com/JellyDevelopment/JDSlider.git
```
Drag and drop `JDSlider.swift` file into your project. Add `import JDSlider` to all view controllers that need to use it.

##Usage

* Create an UIView in Interface Builder and change to JDSliderView class.
* Set the Slider's Delegate and Datasource

```swift
class ViewController: UIViewController, JDSliderDataSource, JDSliderDelegate {

    //MARK: @IBOutlet
    @IBOutlet var sliderView: JDSliderView!
    
    //MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.sliderView.delegate    = self
        self.sliderView.datasource  = self
    }
}
```
* Implement JDSliderDataSource, JDSliderDelegate

```swift
//MARK: JDSliderDelegate
func slider(jdSlider: JDSliderView, didSelectSlideAtIndex index: Int) {
   print("Touch slide with index: \(index)")
}
   
//MARK: JDSliderDataSource
func slider(jdSliderNumberOfSlides slider: JDSliderView) -> Int {
   return self.arrayImages.count
}
    
func slider(jdSlider: JDSliderView, viewForSlideAtIndex index: Int) -> UIView {
   let imageView = UIImageView()
   imageView.image = UIImage(named: self.arrayImages[index])
            
   return imageView
}
```
* You can customize the page indicator's color
```swift
self.sliderView.tintPageIndicator(UIColor.orangeColor(), state: .Highlight)
self.sliderView.tintPageIndicator(UIColor.blackColor(), state: .Normal)
```
## Author

* [Jelly Development](https://github.com/JellyDevelopment)
    * Juanpe Catalán, juanpecm@gmail.com
    * David Carrascal, davidlcarrascal@gmail.com

## License

JDSlider is available under the MIT license. See the LICENSE file for more info.
