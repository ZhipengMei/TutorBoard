//
//  ViewController.swift
//  TutorBoard
//
//  Created by Adrian on 2/15/18.
//  Copyright © 2018 Mei. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DrawViewController: UIViewController {
    private lazy var drawRef: DatabaseReference = Database.database().reference(withPath: "Drawing")
    private var drawRefHandle: DatabaseHandle?
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    var red:CGFloat = 44/255
    var green:CGFloat = 62/255
    var blue:CGFloat = 80/255
    
    var currentColor:NSNumber = 7;
    
    @IBOutlet weak var imageView: UIImageView!
    
    //let screenWidth = UIScreen.main.bounds.size.width //The screen's width
    //let screenHeight = UIScreen.main.bounds.size.height //The screen's height
    
//    var timer: Timer?
    
    let colorsBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 44/255, green: 62/255, blue: 80/255, alpha: 1)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let redColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor.red
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    let blueColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor.blue
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    let yellowColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor.yellow
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    let orangeColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor.orange
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    let greenColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor.green
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    let lightBlueColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor(red: 129/255, green: 207/255, blue: 224/255, alpha: 1)
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    let blackColor: UIButton = {
        let red = UIButton()
        red.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        red.backgroundColor = UIColor.black
        red.translatesAutoresizingMaskIntoConstraints = false
        red.layer.cornerRadius = 20
        red.layer.masksToBounds = true
        return red
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(colorsBarView)
//        setupColorBarView()
        observeNewPoints()
        observeReset()
//        let notificationCenter = NotificationCenter.default
        
//        startTimer()
        
    }
    
    //create reload button on nav bar
    func reloadBtn() {
        // Image needs to be added to project.
        let buttonIcon = UIImage(named: "Reload")
        
        let rightBarButton = UIBarButtonItem(title: "Reload", style: UIBarButtonItemStyle.done, target: self, action: #selector(DrawViewController.myRightSideBarButtonItemTapped(_:)))
        rightBarButton.image = buttonIcon
        
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        print("myLeftSideBarButtonItemTapped")
        drawRef.removeValue()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        appdelegate.shouldSupportAllOrientation = false
        
        //hide the tabbar for full screen
        self.tabBarController?.tabBar.isHidden = true
        
        //(UINavigationBar.appearance()).barTintColor = UIColor.white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let red = UIButton(frame: CGRect(x: <#T##CGFloat#>, y: <#T##CGFloat#><#T##CGFloat#>, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
        
    }
    
    //display the tab bar
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func setupColorBarView(){
        /*
         //Constraints Set Up for the colors tab
         let colorBarHeight = self.view.frame.width/9 + 20
         colorsBarView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
         colorsBarView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
         colorsBarView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
         colorsBarView.heightAnchor.constraint(equalToConstant: self.view.frame.width/9 + 20).isActive = true
         
         colorsBarView.addSubview(redColor)
         colorsBarView.addSubview(blueColor)
         colorsBarView.addSubview(yellowColor)
         colorsBarView.addSubview(orangeColor)
         colorsBarView.addSubview(greenColor)
         colorsBarView.addSubview(lightBlueColor)
         colorsBarView.addSubview(blackColor)
         
         let spacing = (view.frame.width * 2)/72
         
         redColor.leftAnchor.constraint(equalTo: colorsBarView.leftAnchor, constant: (self.view.frame.width * 2)/92).isActive = true
         redColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         redColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         redColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         
         orangeColor.leftAnchor.constraint(equalTo: redColor.rightAnchor, constant: spacing).isActive = true
         orangeColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         orangeColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         orangeColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         
         yellowColor.leftAnchor.constraint(equalTo: colorsBarView.leftAnchor, constant: 110).isActive = true
         yellowColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         yellowColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         yellowColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         
         greenColor.leftAnchor.constraint(equalTo: colorsBarView.leftAnchor, constant: 160).isActive = true
         greenColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         greenColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         greenColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         
         lightBlueColor.leftAnchor.constraint(equalTo: colorsBarView.leftAnchor, constant: 210).isActive = true
         lightBlueColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         lightBlueColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         lightBlueColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         
         blueColor.leftAnchor.constraint(equalTo: colorsBarView.leftAnchor, constant: 260).isActive = true
         blueColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         blueColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         blueColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         
         blackColor.leftAnchor.constraint(equalTo: colorsBarView.leftAnchor, constant: 310).isActive = true
         blackColor.centerYAnchor.constraint(equalTo: colorsBarView.centerYAnchor).isActive = true
         blackColor.widthAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         blackColor.heightAnchor.constraint(equalTo: colorsBarView.widthAnchor, multiplier: 1/9).isActive = true
         */
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLine(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView?.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor)
        
        context?.strokePath()
        
        imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let newDrawRef = drawRef.childByAutoId()
        let fromPointX = NSNumber(value: Float(fromPoint.x))
        let fromPointY = NSNumber(value: Float(fromPoint.y))
        let toPointX = NSNumber(value: Float(toPoint.x))
        let toPointY = NSNumber(value: Float(toPoint.y))
        let drawInfo = Draw(fromPointX: fromPointX, fromPointY: fromPointY, toPointX: toPointX, toPointY: toPointY, color: currentColor)
        
        
        newDrawRef.setValue(drawInfo.toAnyObject())
    }
    
    func drawLineObserve(fromPoint: CGPoint, toPoint: CGPoint, color: NSNumber) {
        setRGB(color: color)
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView?.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(5)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: 1).cgColor)
        
        context?.strokePath()
        
        imageView?.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first{
            let currentPoint = touch.location(in: self.view)
            drawLine(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    
    @IBAction func pickAColor(_ sender: Any) {
    
        if (sender as AnyObject).tag == 0{
            currentColor = 0;
            red = 231/255
            green = 76/255
            blue = 60/255
        }
        if (sender as AnyObject).tag == 1{
            currentColor = 1;
            red = 230/255
            green = 136/255
            blue = 34/255
        }
        if (sender as AnyObject).tag == 2{
            currentColor = 2;
            red = 241/255
            green = 196/255
            blue = 15/255
        }
        if (sender as AnyObject).tag == 3{
            currentColor = 3;
            red = 52/255
            green = 152/255
            blue = 219/255
        }
        if (sender as AnyObject).tag == 4{
            currentColor = 4;
            red = 46/255
            green = 204/255
            blue = 113/255
        }
        if (sender as AnyObject).tag == 5{
            currentColor = 5;
            red = 155/255
            green = 89/255
            blue = 182/255
        }
        if (sender as AnyObject).tag == 6{
            currentColor = 6;
            red = 149/255
            green = 165/255
            blue = 166/255
        }
        if (sender as AnyObject).tag == 7{
            currentColor = 7;
            red = 44/255
            green = 62/255
            blue = 80/255
        }
        
    }
    
    func setRGB(color: NSNumber){
        if (color == 0){
            red = 231/255
            green = 76/255
            blue = 60/255
        }
        if (color == 1){
            red = 230/255
            green = 136/255
            blue = 34/255
        }
        if (color == 2){
            red = 241/255
            green = 196/255
            blue = 15/255
        }
        if (color == 3){
            red = 52/255
            green = 152/255
            blue = 219/255
        }
        if (color == 4){
            red = 46/255
            green = 204/255
            blue = 113/255
        }
        if (color == 5){
            red = 155/255
            green = 89/255
            blue = 182/255
        }
        if (color == 6){
            red = 149/255
            green = 165/255
            blue = 166/255
        }
        if (color == 7){
            red = 44/255
            green = 62/255
            blue = 80/255
        }
    }
    
    @IBAction func reset(_ sender: Any) {
        self.imageView.image = nil
        drawRef.removeValue()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped{
            drawLine(fromPoint: lastPoint, toPoint: lastPoint)
        }
    }
    
    private func observeNewPoints(){
        drawRefHandle = drawRef.observe(.childAdded, with: { snapshot in
            let drawData = snapshot.value as! Dictionary<String, Double>
            
//            let id = snapshot.key
            let fromPointX = drawData["fromPointX"]
            let fromPointY = drawData["fromPointY"]
            let toPointX = drawData["toPointX"]
            let toPointY = drawData["toPointY"]
            let fromPoint = CGPoint(x: fromPointX!, y: fromPointY!)
            let toPoint = CGPoint(x: toPointX!, y: toPointY!)
            let colorFromData = drawData["color"]
            let nsColor = NSNumber(value: colorFromData!)
            
            self.drawLineObserve(fromPoint: fromPoint, toPoint: toPoint, color: nsColor)
        })
    }
    
    private func observeReset(){
        drawRefHandle = drawRef.observe(.childRemoved, with: { snapshot in
            self.imageView.image = nil
        })
    }
    
//    func startTimer(){
//        timer = Timer.scheduledTimer(withTimeInterval: 10.0, repeats: true, block: {[weak self] _ in
//            print("Hello")
//        })
//    }
//
//    func stopTimer(){
//        timer?.invalidate()
//    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

