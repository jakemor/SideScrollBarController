//
//  HomeScrollView.swift
//  Restaurant
//
//  Created by Jake Mor on 3/22/16.
//  Copyright © 2016 Jake Mor. All rights reserved.
//

import UIKit

class HomeScrollView: UIScrollView, UIScrollViewDelegate {
	
	var topBar: UIView!
	var tabButtonLabels:[UILabel]!
	var pageIndicator: UIView!
	var pageCount: Int!
	var owner: UIViewController!
	var buttonsBG: UIView!
	var iconNormalColor: UIColor = UIColor.darkGrayColor()
	var iconHighlightedColor: UIColor = UIColor.blackColor()
	var labelText: [String]!
	var onLabelText: [String]!
	
	var pageChangedBlock: (Int)->() = {_ in }
	
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		contentSize = CGSize(width: frame.size.width*3, height: frame.size.height)
		pagingEnabled = true
	}
	
	init(vc: UIViewController, pages:[UIView], labels:[String], onLabels:[String]) {
		
		let view = vc.view
		
		view.backgroundColor = UIColor.whiteColor()
		
		super.init(frame: view.frame)
		
		contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)

		scrollsToTop = true
		
		showsVerticalScrollIndicator = false
		showsHorizontalScrollIndicator = false
		
		
		self.backgroundColor = UIColor.clearColor()
		
		owner = vc
		
		view.addSubview(self)
		contentSize = CGSize(width: frame.size.width*CGFloat(pages.count), height: frame.size.height - 50)
		
		pageCount = pages.count
		
		var count = 0
		
		for p in pages {
			addSubview(p)
			p.frame.origin.x = frame.size.width*CGFloat(count)
			count += 1
		}
		
		pagingEnabled = true
		
		
		// bottom bar bg
		
		let offset:CGFloat = 0
		
		
		let h:CGFloat = 45
		
		topBar = UIView(frame: CGRectMake(-2, -1, frame.size.width + 4, h))
		topBar.backgroundColor = UIColor.whiteColor()
		topBar.layer.borderWidth = 0.5
		topBar.layer.borderColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.0).CGColor
		
		view.addSubview(topBar)
		
		count = 0
		
		tabButtonLabels = [UILabel]()
		
		// labels
		for _ in pages {
			
			let width = (frame.size.width)/CGFloat(pages.count)
			let height = CGFloat(25)
			
			// add label
			let l = UILabel(frame: CGRectMake(width*CGFloat(count), 9, width, height))
			l.text = labels[count]
			l.font = UIFont(name: "AvenirNext-Regular", size: 15.0)
			l.textAlignment = .Center
			l.textColor = iconHighlightedColor
			tabButtonLabels.append(l)
			view.addSubview(l)

			count += 1
		}
		
		
		// button bg
		
		
		// page indicator
		pageIndicator = UIView(frame: CGRectMake(0, h - 2.5, (frame.size.width)/CGFloat(pages.count), 1.5))
		
		
		pageIndicator.backgroundColor = UIColor.blackColor()
		pageIndicator.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).CGColor

		
		view.addSubview(pageIndicator)
		
		
		// tap event / touch sensor
		
		let touchBar = UIView(frame: CGRectMake(-2, 0, frame.size.width + 4, h))
		touchBar.backgroundColor = UIColor.clearColor()
		view.addSubview(touchBar)
		
		let touch = UITapGestureRecognizer()
		touch.addTarget(self, action: "touchedtopBar:")
		touchBar.addGestureRecognizer(touch)
		
		// other
		
		delegate = self
		
		self.onLabelText = onLabels
		self.labelText = labels
		
		scrollViewDidScroll(self)
	}
	
	func touchedtopBar(sender: UITapGestureRecognizer?) {
		if let t = sender {
			let p = t.locationInView(topBar).x/frame.size.width
			
			let pageNoD = p/(1.00/CGFloat(pageCount))
			let pageNo = CGFloat(Int(pageNoD))
			
			setContentOffset(CGPoint(x: pageNo*frame.size.width, y: 0), animated: true)
		}
	}
	
	func update() {
		scrollViewDidScroll(self)
	}
	
	var page = 0
	
	func scrollViewDidScroll(scrollView: UIScrollView) {
		
		let p = max(0.0, min(scrollView.contentOffset.x/scrollView.contentSize.width, CGFloat(pageCount - 1)/CGFloat(pageCount) ))
		
		
		let pageNoD = p/(1.00/CGFloat(pageCount)) + 0.49
		
		let pageNo = Int(pageNoD)
		
		if pageNo != page {
			
			tabButtonLabels[page].text = labelText[page]
			tabButtonLabels[pageNo].text = onLabelText[pageNo]
			page = pageNo
			
		}
		
		pageIndicator.frame.origin.x = frame.size.width*scrollView.contentOffset.x/scrollView.contentSize.width	}
	
	func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
		print(page)
		
		pageChangedBlock(page)
		
	}
	
	func updateViews() {
		scrollViewDidScroll(self)
	}
	
	
	/*
	// Only override drawRect: if you perform custom drawing.
	// An empty implementation adversely affects performance during animation.
	override func drawRect(rect: CGRect) {
	// Drawing code
	}
	*/
	
}
