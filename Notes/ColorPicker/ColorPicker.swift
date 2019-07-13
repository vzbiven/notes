//
//  ColorPicker.swift
//  Notes
//

import UIKit

@IBDesignable
class ColorPicker: UIView {
    
    var currentColor: UIColor = .white {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        let xibView = loadViewFromXib()
        xibView.frame = self.bounds
        xibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(xibView)
        currentColorView.layer.borderWidth = 1.0
        currentColorView.layer.borderColor = UIColor.black.cgColor
        currentColorView.layer.cornerRadius = 20.0
    }
    
    private func loadViewFromXib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "ColorPicker", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first! as! UIView
    }
    
    @IBOutlet weak var currentColorView: UIView!
    @IBOutlet weak var hsbView: HSBView!
    
    @IBAction func hsbViewTapped(_ sender: UITapGestureRecognizer) {
        currentColorView.backgroundColor = hsbView.currentColor
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        hsbView.brightness = CGFloat(sender.value)
    }
    @IBAction func doneTapped(_ sender: UIButton) {
        self.isHidden = true
        currentColor = currentColorView.backgroundColor!
        
    }
}
