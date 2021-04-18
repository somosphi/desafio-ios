//
//  StatementTableViewCellImage.swift
//  DesafioIOS
//
//

import UIKit

class StatementTableViewCellImage: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        self.backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let circleRadius : CGFloat = 4.5
        let spaceBetweenLineAndCircle : CGFloat = 2
        drawVerticalLine(xValue: rect.centerX, from: 0, to: rect.centerY - circleRadius - spaceBetweenLineAndCircle)
        drawCircle(center: rect.center, radius: circleRadius)
        drawVerticalLine(xValue: rect.centerX, from: rect.centerY + circleRadius + spaceBetweenLineAndCircle,
                         to: rect.maxY)
        
    }
    
    private func drawVerticalLine(xValue : CGFloat, from : CGFloat, to : CGFloat){
        let path = UIBezierPath()
        path.move(to: CGPoint(x: xValue, y: from))
        path.addLine(to: CGPoint(x: xValue, y: to))
        UIColor.grayPhi?.setStroke()
        path.lineWidth = 1
        path.stroke()
    }
    
    private func drawCircle(center : CGPoint, radius: CGFloat){
        let circle = UIBezierPath(arcCenter:center ,
                                  radius: CGFloat(radius),
                                  startAngle: CGFloat(0),
                                  endAngle: CGFloat(2*Double.pi),
                                  clockwise: true)
        UIColor.greenPhi?.setFill()
        circle.fill()
        
    }
}
