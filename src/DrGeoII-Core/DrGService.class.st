"
I am a DrGeo app without toolbar, I only come with the wheels and the top menu. I am used to display computed sketches (i.e. sketches constrcuted from Smalltalk code with the DrGeo API)
"
Class {
	#name : #DrGService,
	#superclass : #BorderedMorph,
	#instVars : [
		'app',
		'area'
	],
	#category : #DrGeoII-Core-App
}

{ #category : #'instance creation' }
DrGService class >> for: aDrgeo [
	^ self basicNew app: aDrgeo;
		initialize
]

{ #category : #'instance creation' }
DrGService class >> with: aDrgeoModel [ 
	^ self basicNew initialize: aDrgeoModel
]

{ #category : #menu }
DrGService >> add: btnSelector menuItemBtn: array to: menu [
	menu 
		add: array first 
		target: self
		selector: #giveMeButton:
		argument: btnSelector.
	menu lastItem 
		icon: (DrGIcons scaled: array second to: 16);
		setBalloonText: array fourth  
		
]

{ #category : #menu }
DrGService >> addCustomMenuItems: menu hand: aHandMorph [ 
	"super addCustomMenuItems: menu hand: aHandMorph."
	| submenu |
	menu addLine.
	submenu := MenuMorph new.
	self addToolsMenuItems: submenu hand: aHandMorph.
	menu add: 'Dr. Geo tools' translated subMenu: submenu.
	submenu := MenuMorph new.
	self addGetButtonsMenuItems: submenu hand: aHandMorph.
	menu add: 'Give me Dr. Geo buttons' translated subMenu: submenu
]

{ #category : #menu }
DrGService >> addGetButtonsMenuItems: menu hand: aHandMorph [ 
	"from this menu we can ask for buttons to plug arround"
	self addPointBtnMenuItems: menu hand: aHandMorph.
	self addLineBtnMenuItems: menu hand: aHandMorph.
	self addTransformationBtnMenuItems: menu hand: aHandMorph.
	self addNumericBtnMenuItems: menu hand: aHandMorph.
	self addMacroBtnMenuItems: menu hand: aHandMorph.
	self addOtherBtnMenuItems: menu hand: aHandMorph.
]

{ #category : #menu }
DrGService >> addLineBtnMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self add: #lineBtn menuItemBtn: self presenter lineButtonData to: subMenu.
	self add: #parallelBtn menuItemBtn: self presenter parallelButtonData to: subMenu.
	self add: #perpendicularBtn menuItemBtn: self presenter perpendicularButtonData to: subMenu.
	self add: #rayBtn menuItemBtn: self presenter rayButtonData to: subMenu.
	self add: #segmentBtn menuItemBtn: self presenter segmentButtonData to: subMenu.
	self add: #vectorBtn menuItemBtn: self presenter vectorButtonData to: subMenu.
	self add: #circleBtn menuItemBtn: self presenter circleButtonData to: subMenu.
	self add: #arcBtn menuItemBtn: self presenter arcButtonData to: subMenu.	
	self add: #polygonBtn menuItemBtn: self presenter polygonButtonData to: subMenu.	
	self add: #locusBtn menuItemBtn: self presenter locusButtonData to: subMenu.
	menu add: ('Curves' translated) subMenu: subMenu
]

{ #category : #menu }
DrGService >> addLineMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self addMenuItem: self presenter lineButtonData to: subMenu.
	self addMenuItem: self presenter parallelButtonData to: 	subMenu.
	self addMenuItem: self presenter perpendicularButtonData to: subMenu.
	self addMenuItem: self presenter rayButtonData to: subMenu.
	self addMenuItem: self presenter segmentButtonData to: subMenu.
	self addMenuItem: self presenter vectorButtonData to: subMenu.
	self addMenuItem: self presenter circleButtonData to: subMenu.
	self addMenuItem: self presenter arcButtonData to: subMenu.
	self addMenuItem: self presenter polygonButtonData to: subMenu.
	self addMenuItem: self presenter locusButtonData to: subMenu.
	menu add: 'Curves' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addMacroBtnMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self add: #macroBuildBtn menuItemBtn: self presenter macroBuildButtonData to: subMenu.
	self add: #executeBtn menuItemBtn: self presenter macroExecuteButtonData to: subMenu.
	menu add: 'Macro-construction' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addMacroMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self addMenuItem: self presenter macroBuildButtonData to: subMenu.
	self addMenuItem: self presenter macroExecuteButtonData to: subMenu.
	self addMenuItem: self presenter macroDeleteButtonData to: subMenu.
	menu add: 'Macro-construction' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addMenuItem: array to: menu [
	menu 
		add: array first 
		target: self presenter
		selector: array third.
	menu lastItem
		setBalloonText: array fourth  
		
]

{ #category : #menu }
DrGService >> addNumericBtnMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self add: #distanceBtn menuItemBtn: self presenter distanceButtonData to: subMenu.
	self add: #angleBtn menuItemBtn: self presenter angleButtonData to: subMenu.
	self add: #coordinatesBtn menuItemBtn: self presenter coordinatesButtonData to: subMenu.
	self add: #scriptBtn menuItemBtn: self presenter scriptRunButtonData to: subMenu.
	self add: #scriptEditBtn menuItemBtn: self presenter scriptEditButtonData to: subMenu.
	self add: #scriptCreateBtn menuItemBtn: self presenter scriptCreateButtonData to: subMenu.

	menu add: 'Numerics' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addNumericMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self addMenuItem: self presenter distanceButtonData to: subMenu.
	self addMenuItem: self presenter angleButtonData to: subMenu.
	self addMenuItem: self presenter coordinatesButtonData to: subMenu.
	self addMenuItem: self presenter scriptRunButtonData to: subMenu.
	self addMenuItem: self presenter scriptEditButtonData to: subMenu.
	self addMenuItem: self presenter scriptCreateButtonData to: subMenu.
	menu add: 'Numerics' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addOtherBtnMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self add: #undoBtn menuItemBtn: self presenter undoButtonData to: subMenu.
	self add: #redoBtn menuItemBtn: self presenter redoButtonData to: subMenu.
	self add: #eraserBtn menuItemBtn: self presenter eraserButtonData to: subMenu.
	self add: #styleBtn menuItemBtn: self presenter styleButtonData to: subMenu.
	self add: #propertyBtn menuItemBtn: self presenter propertyButtonData to: subMenu.
	self add: #moveBtn menuItemBtn: self presenter moveButtonData to: subMenu.		
	self add: #gridBtn menuItemBtn: self presenter gridButtonData to: subMenu.
	self add: #gridStuckBtn menuItemBtn: self presenter gridMagnetButtonData to: subMenu.
	self add: #viewerBtn menuItemBtn: self presenter viewerButtonData to: subMenu.
	menu add: 'Other' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addOtherMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self addMenuItem: self presenter undoButtonData to: subMenu.
	self addMenuItem: self presenter redoButtonData to: subMenu.
	self addMenuItem: self presenter eraserButtonData to: subMenu.
	self addMenuItem: self presenter styleButtonData to: subMenu.
	self addMenuItem: self presenter propertyButtonData to: subMenu.
	self addMenuItem: self presenter moveButtonData to: subMenu.
	subMenu 
		addUpdating: #gridString
		target: self presenter
		selector: #gridOnOff
		argumentList: #();
		
		addUpdating: #griddedString
		target: self presenter
		selector: #gridStuckOnOff
		argumentList: #().
	self addMenuItem: self presenter viewerButtonData to: subMenu.
	self addMenuItem: self presenter multipleModeButtonData to: subMenu.
	subMenu 		
		addUpdating: #createMultipleString
		target: self presenter
		selector: #createMultipleOnOff
		argumentList: #();
		
		add: 'default position and scale' translated
		target: self area
		selector: #defaultScalePosition.
	menu add: 'Other' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addPointBtnMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self add: #freePointBtn menuItemBtn: self presenter freePointButtonData to: subMenu.
	self add: #middlePointBtn menuItemBtn: self presenter middleButtonData to: subMenu.	
	self add: #intersectionPointBtn menuItemBtn: self presenter intersectionButtonData to: subMenu.	
	self add: #pointByCoordinatesBtn menuItemBtn: self presenter pointByCoordinatesButtonData to: subMenu.
	menu add: 'Points' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addPointMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self addMenuItem: self presenter freePointButtonData to: subMenu.
	self addMenuItem: self presenter middleButtonData to: subMenu.
	self addMenuItem: self presenter pointByCoordinatesButtonData to: subMenu.
	menu add: 'Points' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addToolsMenuItems: menu hand: aHandMorph [ 
	self addPointMenuItems: menu hand: aHandMorph.
	self addLineMenuItems: menu hand: aHandMorph.
	self addTransformationMenuItems: menu hand: aHandMorph.
	self addNumericMenuItems: menu hand: aHandMorph.
	self addMacroMenuItems: menu hand: aHandMorph.
	self addOtherMenuItems: menu hand: aHandMorph
]

{ #category : #menu }
DrGService >> addTransformationBtnMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self add: #symmetryBtn menuItemBtn: self presenter symmetryButtonData to: subMenu.
	self add: #reflectionBtn menuItemBtn: self presenter reflectionButtonData to: subMenu.
	self add: #translationBtn menuItemBtn: self presenter translationButtonData to: subMenu.
	self add: #rotationBtn menuItemBtn: self presenter rotationButtonData to: subMenu.
	self add: #homothetyBtn menuItemBtn: self presenter homothetyButtonData to: subMenu.
	menu add: 'Transformations' translated subMenu: subMenu
]

{ #category : #menu }
DrGService >> addTransformationMenuItems: menu hand: aHandMorph [ 
	| subMenu |
	subMenu := MenuMorph new.
	self addMenuItem: self presenter symmetryButtonData to: subMenu.
	self addMenuItem: self presenter reflectionButtonData to: subMenu.
	self addMenuItem: self presenter translationButtonData to: subMenu.
	self addMenuItem: self presenter rotationButtonData to: subMenu.
	self addMenuItem: self presenter homothetyButtonData to: subMenu.
	menu add: 'Transformations' translated subMenu: subMenu
]

{ #category : #button }
DrGService >> angleBtn [
	^ self buttonAtHand: self presenter angleButtonData 
]

{ #category : #accessing }
DrGService >> app [
	^ app
]

{ #category : #accessing }
DrGService >> app: anObject [
	app := anObject
]

{ #category : #button }
DrGService >> arcBtn [
	^ self buttonAtHand: self presenter arcButtonData 
]

{ #category : #accessing }
DrGService >> area [
	^ area
]

{ #category : #button }
DrGService >> buttonAtHand: array [
"
array first = button form
array second = symbol callback
array third = help string
"
	^ IconicButton new
		labelGraphic: (DrGIcons scaled: array second to: 24);
		color: self colorButton;
		setBalloonText: array fourth translated;
		target: self presenter;
		actionSelector: array third
]

{ #category : #button }
DrGService >> circleBtn [
	^ self buttonAtHand: self presenter circleButtonData 
]

{ #category : #button }
DrGService >> colorButton [
	^ Color green alpha: 0.2
]

{ #category : #accessing }
DrGService >> controls [
	^ self presenter controlsManager
]

{ #category : #button }
DrGService >> coordinatesBtn [
	^ self buttonAtHand: self presenter coordinatesButtonData 
]

{ #category : #button }
DrGService >> distanceBtn [
	^ self buttonAtHand: self presenter distanceButtonData 
]

{ #category : #button }
DrGService >> editGroupBtn [
	^ self buttonAtHand: self presenter editGroupButtonData 
]

{ #category : #button }
DrGService >> eraserBtn [
	^ self buttonAtHand: self presenter eraserButtonData 
]

{ #category : #button }
DrGService >> freePointBtn [
	^ self buttonAtHand: self presenter freePointButtonData
]

{ #category : #accessing }
DrGService >> fullScreen [
	self position: 0@0.
	self extent: World extent
]

{ #category : #button }
DrGService >> giveMeButton: aSymbol [
	self currentHand attachMorph: (self perform: aSymbol)
]

{ #category : #button }
DrGService >> gridBtn [
	^ self buttonAtHand: self presenter gridButtonData 
]

{ #category : #button }
DrGService >> gridStuckBtn [
	^ self buttonAtHand: self presenter gridMagnetButtonData 
]

{ #category : #button }
DrGService >> groupBtn [
	^ self buttonAtHand: self presenter groupButtonData 
]

{ #category : #button }
DrGService >> homothetyBtn [
	^ self buttonAtHand: self presenter homothetyButtonData  
]

{ #category : #initialize-release }
DrGService >> initialize [
	super initialize.
	self color: Color white .
	self borderWidth: 1.
	self clipSubmorphs: true.
	self layoutPolicy: ProportionalLayout new.
	area := DrGDrawable newOn: app.
	self installTools.
	self extent: 800 @ 600
]

{ #category : #initialize-release }
DrGService >> installTools [ 
	self 
		addMorph: (self wrapMeInAthens: area)
	 	fullFrame: (LayoutFrame new
			leftFraction: 0 offset: 0;
			topFraction: 0 offset: 0;
			rightFraction: 1 offset: -25;
			bottomFraction: 1 offset: -25).
	self
		addMorph: self controls verticalWheel
		fullFrame: (LayoutFrame new
			leftFraction: 1 offset: -25;
			topFraction: 1 offset: -120;
			rightFraction: 1 offset: 0;
			bottomFraction: 1 offset: -20).
	self
		addMorph: self controls horizontalWheel
		fullFrame: (LayoutFrame new
			leftFraction: 1 offset: -120;
			topFraction: 1 offset: -25;
			rightFraction: 1 offset: -20;
			bottomFraction: 1 offset: 0).
	self
	 	addMorph: self controls zoomWheel 
		fullFrame: (LayoutFrame new
			leftFraction: 1 offset: -25;
			topFraction: 0 offset: 0;
			rightFraction: 1 offset: 0;
			bottomFraction: 0 offset: 100).
	area layoutChanged
]

{ #category : #testing }
DrGService >> isApplication [
	^false
]

{ #category : #testing }
DrGService >> isService [
	^true
]

{ #category : #button }
DrGService >> lineBtn [
	^ self buttonAtHand: self presenter lineButtonData  
]

{ #category : #button }
DrGService >> locusBtn [
	^ self buttonAtHand: self presenter locusButtonData  
]

{ #category : #button }
DrGService >> macroBuildBtn [
	^ self buttonAtHand: self presenter macroBuildButtonData   
]

{ #category : #button }
DrGService >> macroDeleteBtn [
	^ self buttonAtHand: self presenter macroDeleteButtonData    
]

{ #category : #button }
DrGService >> macroExecuteBtn [
	^ self buttonAtHand: self presenter macroExecuteButtonData    
]

{ #category : #button }
DrGService >> middlePointBtn [
	^ self buttonAtHand: self presenter middleButtonData    
]

{ #category : #button }
DrGService >> moveBtn [
	^ self buttonAtHand: self presenter moveButtonData     
]

{ #category : #button }
DrGService >> multipleModeBtn [          
	^ self buttonAtHand: self presenter multipleModeButtonData        
]

{ #category : #button }
DrGService >> parallelBtn [
	^ self buttonAtHand: self presenter parallelButtonData      
]

{ #category : #button }
DrGService >> perpendicularBtn [
	^ self buttonAtHand: self presenter parallelButtonData
]

{ #category : #button }
DrGService >> pointByCoordinatesBtn [ 
	^ self buttonAtHand: self presenter pointByCoordinatesButtonData 
]

{ #category : #button }
DrGService >> polygonBtn [ 
	^ self buttonAtHand: self presenter polygonButtonData 
]

{ #category : #menu }
DrGService >> popupMenu [
	"super addCustomMenuItems: menu hand: aHandMorph."
	| menu |
	menu := MenuMorph new title: 'Dr. Geo tools' translated.
	self addToolsMenuItems: menu hand: nil.
	menu addStayUpItem.
	menu popUpInWorld: World
]

{ #category : #accessing }
DrGService >> presenter [
	^ app presenter
]

{ #category : #button }
DrGService >> propertyBtn [  
	^ self buttonAtHand: self presenter propertyButtonData 
]

{ #category : #button }
DrGService >> rayBtn [   
	^ self buttonAtHand: self presenter rayButtonData
]

{ #category : #button }
DrGService >> redoBtn [    
	^ self buttonAtHand: self presenter redoButtonData 
]

{ #category : #button }
DrGService >> reflectionBtn [     
	^ self buttonAtHand: self presenter reflectionButtonData  
]

{ #category : #button }
DrGService >> rotationBtn [      
	^ self buttonAtHand: self presenter rotationButtonData  
]

{ #category : #button }
DrGService >> scriptBtn [      
	^ self buttonAtHand: self presenter scriptRunButtonData   
]

{ #category : #button }
DrGService >> scriptCreateBtn [      
	^ self buttonAtHand: self presenter scriptCreateButtonData   
]

{ #category : #button }
DrGService >> scriptEditBtn [      
	^ self buttonAtHand: self presenter scriptEditButtonData   
]

{ #category : #button }
DrGService >> segmentBtn [      
	^ self buttonAtHand: self presenter segmentButtonData    
]

{ #category : #button }
DrGService >> styleBtn [      
	^ self buttonAtHand: self presenter styleButtonData    
]

{ #category : #button }
DrGService >> symmetryBtn [       
	^ self buttonAtHand: self presenter symmetryButtonData     
]

{ #category : #accessing }
DrGService >> title [
	^ 'Unnamed Dr. Geo service' translated
]

{ #category : #accessing }
DrGService >> title: aString [
]

{ #category : #button }
DrGService >> translationBtn [        
	^ self buttonAtHand: self presenter translationButtonData     
]

{ #category : #button }
DrGService >> undoBtn [         
	^ self buttonAtHand: self presenter undoButtonData      
]

{ #category : #button }
DrGService >> vectorBtn [         
	^ self buttonAtHand: self presenter vectorButtonData      
]

{ #category : #button }
DrGService >> viewerBtn [         
	^ self buttonAtHand: self presenter viewerButtonData       
]

{ #category : #initialize-release }
DrGService >> wrapMeInAthens: aMorph [
	|athensMorph|
	athensMorph := AthensWrapMorph new
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addMorph: aMorph.
	area hResizing: #spaceFill.
	^ athensMorph 
]
