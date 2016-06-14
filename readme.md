# SideScrollBarController

## A simple, elegant and customizable controller that allows you to swipe left and right between views;

### Installation instructions:
- just copy/paste or drag `SideScrollBarController.swift` into your project

### Usage
Simple Example in ViewController.swift

```	
		// instantiate view1, view2 to your liking...

		let sideScrollBarController = SideScrollBarController(vc: self, pages: [view1,view2], labels: ["🏃","🔥"], onLabels: ["Following","Featured"])

		sideScrollBarController.topBar.backgroundColor = UIColor.whiteColor()
		sideScrollBarController.iconNormalColor =  UIColor.blackColor()
		sideScrollBarController.iconHighlightedColor = UIColor.blackColor()
		sideScrollBarController.pageIndicator.backgroundColor = ButtonColor

		// update views
		sideScrollBarController.updateViews()
```


Look at the code if you want to customize anything else, its pretty straight forward.

Contact me for questions: jakemor.com