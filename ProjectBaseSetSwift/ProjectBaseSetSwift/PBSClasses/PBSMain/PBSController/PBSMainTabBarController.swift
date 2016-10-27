//
//  PBSMainTabBarController.swift
//  ProjectBaseSet-Swift
//
//  Created by victor on 16/9/1.
//  Copyright © 2016年 wsl. All rights reserved.
//

import UIKit

class PBSMainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor=UIColor.white;
        //添加所有控制器
        print(" //添加所有控制器")
       addChildviewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupComposeBtn()
    }
    

    func  composeBtnClick(_ bt:UIButton){
        let discoverVc=PBSDiscoverViewController()
        let nav=PBSMainNavigationController(rootViewController: discoverVc)
        present(nav, animated: true, completion: nil)
    }
    
    //添加加号按钮
    private func setupComposeBtn(){
        //添加加号按钮
        tabBar.addSubview(composeBtn)
        
        // 2.调整加号按钮的位置
        let width = UIScreen.main.bounds.size.width / CGFloat(viewControllers!.count)
        let rect  = CGRect(x: 0, y: 0, width: width, height: 49)
        // 第一个参数:是frame的大小
        // 第二个参数:是x方向偏移的大小
        // 第三个参数: 是y方向偏移的大小
        composeBtn.frame = rect.offsetBy(dx: 2 * width, dy: 0)
    }
    
    

    private func addChildviewControllers(){
        addChildViewController(childControllerName: "PBSHomeViewController", title: "首页", imageName: "tabbar_home")
        addChildViewController(childControllerName: "PBSAlbumViewController", title: "相册", imageName: "tabbar_message_center")
        // 再添加一个占位控制器
        addChildViewController(childControllerName: "NullViewController", title: "", imageName: "")
        
        
        addChildViewController(childControllerName: "PBSMessageViewController", title: "消息", imageName: "tabbar_discover")
        addChildViewController(childControllerName: "PBSMineViewController", title: "我", imageName: "tabbar_profile")
    }
    
    /**
     初始化子类控制器
     */
    private func addChildViewController(childControllerName: String, title:     String, imageName :String){
        let ns = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        print(ns)
        // 将字符串转化为类，默认情况下命名空间就是项目名称，但是命名空间可以修改
        
        let cls: AnyClass? = NSClassFromString(ns + "." + childControllerName)
        let vcClass = cls as! UIViewController.Type
        let vc = vcClass.init()

        
        //设置首页数据
        vc.tabBarItem.image = UIImage(named: imageName)
        
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_selected")
        
        vc.title=title
        
        let nav=PBSMainNavigationController()
        
        nav.addChildViewController(vc)
        
        addChildViewController(nav)
    }
    
    
    //懒加载添加加号按钮
    private lazy var composeBtn:UIButton = {
        let btn = UIButton()
        //设置前景图片
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), for: .normal)
     
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), for: .highlighted)
        
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), for: .normal)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), for: .highlighted)
       // btn.addTarget(self, action:#selector(composeBtnClick(_:)), forControlEvents: UIControlEvents.TouchUpInside)
     
        btn.addTarget(self, action:#selector(composeBtnClick(_:)), for:.touchUpInside)
        
        return btn
    }()
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    
    

}
