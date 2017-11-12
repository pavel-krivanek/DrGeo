"
A manager for the DrGeo user interface controls (menu, button, etc.):
- build the standard UI for a given Dr. Geo window
- or build a customized UI for a given Dr. Geo window

I hold:
- the data to build the UI
- the methods to do it
- the preferences I can load/save from/to a xml description

- usedControls: ordered dictionnary indicating the used controls for a customized interface, key are symbols (#angle) and value are booleans
"
Class {
	#name : #DrGUIControlsManager,
	#superclass : #Object,
	#instVars : [
		'presenter',
		'usedControls',
		'customized'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'instance creation' }
DrGUIControlsManager class >> for: aPresenter [
	^ self new 
		presenter: aPresenter;
		activateWheels
]

{ #category : #initialization }
DrGUIControlsManager >> activateWheels [
	#(#wheelX #wheelY #wheelZ) do: [ :aControl | usedControls at: aControl put: true ].
]

{ #category : #menus }
DrGUIControlsManager >> addMenuItem: toolSymbol to: menu [
	| array |
	"access the buttonData method from the tool symbol"
	toolSymbol isSymbol
		ifTrue: [array := self perform: (toolSymbol, #ButtonData) asSymbol]
		ifFalse: [array := toolSymbol]. 
	menu 
		addToggle: array first 
		target: presenter
		selector: array third.
	menu lastItem
		font: self theme menuFont;
		setBalloonText: array fourth.
	"do we have a stock icon for this tool?"
	(DrGIcons respondsTo: array second) ifFalse: [^self].

	(DrGDefault isSugar or: [self app isToolbarless]) ifFalse: [
		menu lastItem icon: (DrGIcons scaled: array second to: 16)]  
]

{ #category : #menus }
DrGUIControlsManager >> addState: stateSymbol menuItem: array to: menu [
	menu 
		addToggle: array first 
		target: presenter
		selector: array third
		getStateSelector: stateSymbol.
	menu lastItem
		font: self theme menuFont;
		setBalloonText: array fourth.
	"do we have a stock icon for this tool?"
	(DrGIcons respondsTo: array second) ifFalse: [^self].

	menu lastItem icon: (DrGIcons scaled: array second to: 16) 
]

{ #category : #toolbars }
DrGUIControlsManager >> additionalToolbar [
	^ self isCustomized 
		ifTrue: [ self customToolbar ] ifFalse: [ self defaultToolbar  ]
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> additionalTools [
	^ #(#axes #exportBitmap #quit)
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> allTools [
	| allTools |
	"Collect all tool in a flat collection"
	allTools := OrderedCollection new.
	 #(#defaultToolbarToolsWithoutSpacer #additionalTools #pointTools #curveTools #transformationTools #numericTools #scriptTools #macroTools #animateTools) do: [ :tools | allTools addAll: (self perform: tools) ].
	^ allTools
]

{ #category : #'controls data' }
DrGUIControlsManager >> angleBisectorButtonData [
	^ {DrGAngleBisectorBuilder  title. #angleBisector. #createAngleBisector. DrGAngleBisectorBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> angleButtonData [
	^ {DrGAngleBuilder title. #angle. #createAngle. DrGAngleBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> animate1ButtonData [
	^ {'Animate x1' translated. #animate1. #animate1. 'Animate at speed 1.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> animate2ButtonData [
	^ {'Animate x2' translated. #animate2. #animate2. 'Animate at speed 2.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> animate3ButtonData [
	^ {'Animate x3' translated. #animate3. #animate3. 'Animate at speed 3.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> animate4ButtonData [
	^ {'Animate x4' translated. #animate4. #animate4. 'Animate at speed 4.' translated}
]

{ #category : #menus }
DrGUIControlsManager >> animateMenu [
	| menu |
	menu := self window newMenu.
	self animateTools do: [ :symbol | self addMenuItem: symbol to: menu ].
	^ menu
		
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> animateTab [
	^ self window newTable: (
		self animateTools collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> animateTools [
	^ #(#animate1 #animate2 #animate3 #animate4)
]

{ #category : #accessing }
DrGUIControlsManager >> app [
	^ presenter app
]

{ #category : #'controls data' }
DrGUIControlsManager >> arcButtonData [
	^ {DrGArcBuilder title. #arc. #createArc. DrGArcBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> arcCenterButtonData [
	^ {DrGArcCenterBuilder title. #arcCenter. #createArcCenter. DrGArcCenterBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> axesButtonData [
	^ {'Axes' translated. #grid. #axesOnOff. 'Show or hide the ox and oy axes.' translated. #isAxesVisible}
]

{ #category : #toolbars }
DrGUIControlsManager >> buttonIcon: selector [
	^ DrGDefault isWorkstation
		ifTrue: [DrGIcons scaled: selector to: 24]
		ifFalse: [DrGIcons scaled: selector to: DrGDefault toolbarIconSize]
]

{ #category : #toolbars }
DrGUIControlsManager >> buttonWith: symbolOrArray [ 
	"array first = menu label or button label
	array second = button form = selection mode
	array third = symbol callback
	array fourth = help string	"	
	| array |
	symbolOrArray isSymbol 
		ifTrue: [ 
			symbolOrArray == #spacer ifTrue: [ ^ self window newToolSpacer ].
			array := self perform: (symbolOrArray, #ButtonData) asSymbol]
		ifFalse: [ array := symbolOrArray].
	
	^ (DrGIcons respondsTo: array second) 
		ifTrue: [ 
			self window
				newButtonFor: presenter
				getState: (array at: 5 ifAbsent: [ #isTool: ])
				action: array third
				arguments: {array second}
				getEnabled: nil
				labelForm: (self buttonIcon: array second)
				help: array fourth]
		ifFalse: [ 
			self window
				newButtonFor: presenter
				getState: (array at: 5 ifAbsent: [ #isTool: ])
				action: array third
				arguments: {array second}
				getEnabled: nil
				label: array first
				help: array fourth]
]

{ #category : #widgets }
DrGUIControlsManager >> checkBoxFor: toolSymbol in: dialog [
	| array |
	"access the button data"
	array := self perform: (toolSymbol, #ButtonData) asSymbol. 
	^ dialog 
		newCheckboxFor: self 
		getSelected: toolSymbol
		setSelected: (toolSymbol, ':') asSymbol
		label: array first 
		help: array fourth.

]

{ #category : #'controls data' }
DrGUIControlsManager >> circleButtonData [
	^ {DrGCircleBuilder title. #circle. #createCircle. DrGCircleBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> coordinatesButtonData [
	^ {DrGCoordinatesBuilder title. #coordinates. #createCoordinates. DrGCoordinatesBuilder description}
]

{ #category : #menus }
DrGUIControlsManager >> curveMenu [
	| lineMenu |
	lineMenu := self window newMenu.
	self curveTools  do: [ :symbol | self addMenuItem: symbol to: lineMenu ].
	^ lineMenu
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> curveTab [
	^ self window newTable: (
		self curveTools collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> curveTools [
	^ #(#line #parallel #perpendicular #perpendicularBisector #angleBisector #ray #segment #vector #circle #arc #arcCenter #polygon #polygonRegular #locus)
]

{ #category : #toolbars }
DrGUIControlsManager >> customToolbar [
	|tools collection|
	collection := OrderedCollection new.
	self allTools do: [ :key | (usedControls at: key) ifTrue: [ collection add: (self buttonWith: key)]].
	DrGDefault ifTablet: [
		collection addAll: {
			self horizontalExpander.
			self buttonWith: #help.
			self buttonWith: #quit}].
	tools := self window newToolbar: collection.
	tools hResizing: #spaceFill.
	^ self window newToolDockingBar addMorph: tools.
]

{ #category : #'controls data' }
DrGUIControlsManager >> customizeControlsButtonData [
	^ {'Customise interface' translated. nil. #openCustomizerDialog. 'Open a dialog to customise the user interface: select the controls and tools you want with your sketch. You need to save and load the sketch to experiment the customised user interface.' translated}
]

{ #category : #accessing }
DrGUIControlsManager >> customized: aBoolean [
	customized := aBoolean.
]

{ #category : #widgets }
DrGUIControlsManager >> customizerDialog [
"Open a dialog to customize the set of used controls"
	| dialog allTools |
	allTools := self allTools.
	dialog := (self window newPluggableDialogWindow: 'Customize user interface' translated) useOKDefaultCancelButton.
	dialog contentMorph: (dialog newColumn: {
		dialog newRow: (self miscControls collect: [:symbol | self checkBoxFor: symbol in: dialog]).
		dialog newRow: { 
			dialog newColumn: ((allTools first: allTools size // 3) 
				collect: [:symbol | self checkBoxFor: symbol in: dialog]).
			dialog newVerticalSeparator.
			dialog newColumn: (allTools 
				collect: [:symbol | self checkBoxFor: symbol in: dialog]
				from: allTools size // 3 + 1
				to: allTools size * 2 // 3).
			dialog newVerticalSeparator.
			dialog newColumn: ((allTools last: allTools size // 3 + 1) 
				collect: [:symbol | self checkBoxFor: symbol in: dialog])
		}
	});
	model: self.
	self customized: (self window openModal: dialog) cancelled not

]

{ #category : #toolbars }
DrGUIControlsManager >> defaultToolbar [
	|tools collection|
	collection := self defaultToolbarTools collect: [ :symbol | self buttonWith: symbol ].
	DrGDefault ifTablet: [
		collection addAll: {
			self horizontalExpander.
			self buttonWith: #help.
			self buttonWith: #quit}].
	tools := self window newToolbar: collection.
	tools hResizing: #spaceFill.
	^ self window newToolDockingBar addMorph: tools.

]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> defaultToolbarTools [
	^ #(#new #open #keep 
	#spacer #spacer
	#undo #redo 
	#spacer #spacer
	#grid #gridMagnet 
	#spacer #spacer 
	#multipleMode #move 
	#spacer #spacer 
	#eraser #style #property)
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> defaultToolbarToolsWithoutSpacer [
	^ self defaultToolbarTools reject: [ :symbol | symbol == #spacer ]
]

{ #category : #'controls data' }
DrGUIControlsManager >> distanceButtonData [
	^ {DrGValueBuilder title. #distance. #createDistance. DrGValueBuilder description}
]

{ #category : #'reflective operations' }
DrGUIControlsManager >> doesNotUnderstand: aMessage [
"catch the message sent from the customizer dialog, see method customizerDialog"
	^ (usedControls includesKey: aMessage selector asLegalSelector)  "Without :"
		ifFalse: [super doesNotUnderstand: aMessage]
		ifTrue: [	
			| selector |				
			selector := aMessage selector. 
			selector isKeyword 
				ifTrue: [usedControls at: selector asLegalSelector put:  aMessage argument] 
				ifFalse: [usedControls at: selector]]
	
]

{ #category : #'controls data' }
DrGUIControlsManager >> editGroupButtonData [
	^ {'Edit group' translated.
	#editGroup .
	#editSelection .
	'Distance between objects, curve length, free value' translated}
]

{ #category : #menus }
DrGUIControlsManager >> editMenu [
	| menu |
	menu := self window newMenu.
	self addMenuItem: self moveButtonData to: menu.
	self addState: #isCreateMultipleMode menuItem: self multipleModeButtonData to: menu.
	menu addLine.
	self addMenuItem: self undoButtonData to: menu.
	self addMenuItem: self redoButtonData to: menu.
	menu addLine.
	self addMenuItem: self eraserButtonData to: menu.
	self addMenuItem: self styleButtonData to: menu.
	self addMenuItem: self propertyButtonData  to: menu.
	menu addLine.
	self addState: #isGridVisible menuItem: self gridButtonData to: menu.
	self addState: #isAxesVisible menuItem: self axesButtonData to: menu.
	self addState: #isGridded menuItem: self gridMagnetButtonData to: menu.
	menu addLine.
	self addMenuItem: self customizeControlsButtonData to: menu.
	^ menu
		
]

{ #category : #'controls data' }
DrGUIControlsManager >> eraserButtonData [
	^ {DrGDeleteTool title. #eraser. #eraser. DrGDeleteTool description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> exportBitmapButtonData [
	^ {'Save as picture' translated. #exportToBitmap. #exportToBitmap. 'Export this sketch as PNG picture.' translated }
]

{ #category : #menus }
DrGUIControlsManager >> fileMenu [
	| fileMenu |
	fileMenu := self window newMenu.
	self addMenuItem: #new to: fileMenu.
	fileMenu 
		addToggle: 'Change title' translated
		target: self window
		selector: #relabel.
	fileMenu addLine.
	self addMenuItem: #open to: fileMenu.
	fileMenu 
		addToggle: 'Open at...' translated
		target: presenter
		selector: #openFigureAt. 
	fileMenu addLine.
	self addMenuItem: #keep to: fileMenu.
	fileMenu 
		addToggle: 'Save as...' translated
		target:  presenter
		selector: #saveFigureAs.
	fileMenu lastItem setBalloonText: 'Keep this sketch under a different name.' translated.
	fileMenu 
		addToggle: 'Save at...' translated
		target:  presenter 
		selector: #saveFigureAt.
	fileMenu lastItem setBalloonText: 'Keep this sketch at a different location.' translated.
	fileMenu 
		addToggle: 'Save multiple' translated
		target:  presenter
		selector: #saveMultiple.
	fileMenu lastItem setBalloonText: 'Keep several sketches and macro-constructions in one file.' translated.
	self addMenuItem: #exportBitmap to: fileMenu.
	fileMenu addLine.
	fileMenu 
		addToggle: 'Close sketch' translated
		target: self window
		selector: #delete.
	self addMenuItem: #quit to: fileMenu.
	^ fileMenu
		
]

{ #category : #'controls data' }
DrGUIControlsManager >> freePointButtonData [
	^ {DrGFlyPointBuilder title. #freePoint. #createFreePoint. DrGFlyPointBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> gridButtonData [
	^ {'Grid' translated. #grid. #gridOnOff. 'Show or hide grid.' translated. #isGridVisible}
]

{ #category : #'controls data' }
DrGUIControlsManager >> gridMagnetButtonData [
	^ {'Magnetic Grid' translated. #gridMagnet. #gridStuckOnOff. 'Snap to grid.' translated. #isGridded}
]

{ #category : #'controls data' }
DrGUIControlsManager >> groupButtonData [
	^ {'Create Group' translated.
	#group .
	#captureSelection .
	'Create a selection group. To do a selection: i. set moving object mode, ii. select a zone by shift+drag over a backgroudn area.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> helpButtonData [
	^ {'Help' translated. #help. #help. 'Open a web help page.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> homothetyButtonData [
	^ {DrGHomothetyBuilder title. #scale. #createHomothety. DrGHomothetyBuilder description}
]

{ #category : #helpers }
DrGUIControlsManager >> horizontalExpander [
	^ Morph new color: Color transparent;
		height: 1;
		hResizing: #spaceFill;
		yourself
]

{ #category : #widgets }
DrGUIControlsManager >> horizontalWheel [ 
	| array |
	array := self wheelXButtonData.
	 ^ WheelMorph new beHorizontal; 
		factor: 0.05; 
		setBalloonText: array first;
		target: presenter; 
		actionSelector: array third; 
		color: Color green twiceDarker
]

{ #category : #initialization }
DrGUIControlsManager >> initialize [
	usedControls := OrderedIdentityDictionary new.
	self customized: false.
	"By default, not control is used in a customized UI"
	(self allTools, self miscControls) do: [ :aControl | usedControls at: aControl put: false].
]

{ #category : #'controls instalation' }
DrGUIControlsManager >> installMenu [
|menu shiftY |
	^  (DrGDefault isTablet not and: [self isMenu])
		ifTrue: [ 
			menu := self mainMenu.
			shiftY := menu minExtent y.
			self window addMorph: menu
				fullFrame: (LayoutFrame
					fractions: (0 @ 0 corner: 1 @ 0)
					offsets: (0 @ 0 corner: 0 @ shiftY)).
			shiftY]
		ifFalse: [ 0 ]
]

{ #category : #'controls instalation' }
DrGUIControlsManager >> installToolbarsAndTabsAt: deltaY [
|bar shiftY|
	self app isToolbarless ifTrue: [^ deltaY].
	bar := self additionalToolbar.
	shiftY := deltaY.
	self window addMorph: bar
		fullFrame: (LayoutFrame
			fractions: (0 @ 0 corner: 1 @ 0)
			offsets: (0 @ shiftY corner: 0 @ (shiftY + bar minExtent y))).
	shiftY := shiftY + bar minExtent y.
	
	self isCustomized ifTrue: [^ shiftY]. "no default toolbar with a custom UI"
	
	bar := self toolsInTab.
	self window addMorph: bar
		fullFrame: (LayoutFrame
			fractions: (0 @ 0 corner: 1 @ 0)
			offsets: (0 @ shiftY corner: 0 @ (shiftY + bar minExtent y))).
	^ shiftY + bar minExtent y.
	
]

{ #category : #'controls instalation' }
DrGUIControlsManager >> installTools [
	| menuBarShiftY statusHeight sideContainer |

	menuBarShiftY := self installMenu.
	menuBarShiftY := self installToolbarsAndTabsAt: menuBarShiftY.
	statusHeight := (self window statusbar minExtent y max: DrGDefault wheelWidth) 
		max: StandardFonts defaultFont height + 4.
	self installWheelsFrom: menuBarShiftY to: statusHeight.
	self window addMorph: self window statusbar
		fullFrame: (LayoutFrame
			fractions: (0 @ 1 corner: 1 @ 1)
			offsets: (0 @ statusHeight negated 
				corner: (DrGDefault wheelWidth + DrGDefault wheelHeight) negated @ 0)).
	self window statusbar
		borderStyle: (BorderStyle inset width: 1);
		cornerStyle: #square.

	sideContainer := AlignmentMorph  inARow: {self wrapMeInAthens: self window area}.
	self window sideContainer: sideContainer.
	sideContainer layoutInset: 0.
	self window area hResizing: #spaceFill.
	self installTreeFrom: menuBarShiftY status: statusHeight.
]

{ #category : #'controls instalation' }
DrGUIControlsManager >> installTreeFrom: menuBarShiftY status: statusHeight [ 
	| treeMorph splitter |
	(self app isToolbarless or: [self isTree not])
		ifTrue: [ "no tree"
			self window addMorph: self window sideContainer 
				fullFrame: (LayoutFrame 
					fractions: (0@0 corner: 1@1) 
					offsets: (0@ menuBarShiftY 
						corner: DrGDefault wheelWidth negated@statusHeight negated))]
		ifFalse: [ "Add tree morph and side container"
			self window tree: (DrGeoTree on: self app).
			self window tree on: MorphTreeChangeRequest send: #updateSelection to: presenter.
			treeMorph := self window tree defaultTreeMorph buildContents.
			splitter := ProportionalSplitterMorph new.
			splitter addLeftOrTop: treeMorph;
				addRightOrBottom: self window sideContainer.
			self window addMorph: treeMorph 
				fullFrame: (LayoutFrame 
					fractions: (0@0 corner: 0.2@1)
					offsets: (0 @ menuBarShiftY  
						corner: 0@statusHeight negated)).
			self window addMorph: splitter 
				fullFrame: (LayoutFrame 
					fractions: (0.2@0 corner: 0.2@1)
					offsets: (-3@ menuBarShiftY  
						corner: 19@statusHeight negated)).
			self window 
				addMorph: self window sideContainer 
				fullFrame: (LayoutFrame 
					fractions: (0.2@0 corner: 1@1) 
					offsets: (14@ menuBarShiftY 
						corner: DrGDefault wheelWidth negated@statusHeight negated))].
]

{ #category : #'controls instalation' }
DrGUIControlsManager >> installWheelsFrom: shiftY to: statusHeight [
	self isWheelY ifTrue: [self window addMorph: self verticalWheel
		fullFrame: (LayoutFrame
			fractions: (1 @ 1 corner: 1 @ 1)
			offsets: (DrGDefault wheelWidth negated @ (DrGDefault wheelHeight negated - statusHeight) 
				corner: 0 @ statusHeight negated))].
			
	self isWheelX ifTrue: [self window addMorph: self  horizontalWheel
		fullFrame: (LayoutFrame
			fractions: (1 @ 1 corner: 1 @ 1)
			offsets: ((DrGDefault wheelWidth + DrGDefault wheelHeight) negated @ 	statusHeight negated 
				corner: DrGDefault wheelWidth negated @ 0))].
			
	self isWheelZ ifTrue: [self window addMorph: self zoomWheel
		fullFrame: (LayoutFrame
			fractions: (1 @ 0 corner: 1 @ 0)
			offsets: (DrGDefault wheelWidth negated @ shiftY 
				corner: 0 @ (shiftY + DrGDefault wheelHeight)))]
]

{ #category : #'controls data' }
DrGUIControlsManager >> intersectionButtonData [
	^ {DrGPointIntersectionBuilder title. #intersection. #createPointIntersection. DrGPointIntersectionBuilder description}
]

{ #category : #testing }
DrGUIControlsManager >> isCustomized [
	^ customized
]

{ #category : #testing }
DrGUIControlsManager >> isMenu [
	"Do we have a menu"
	^ self isCustomized not or: [usedControls at: #menu]
]

{ #category : #testing }
DrGUIControlsManager >> isTree [
	"Do we have a tree view"
	^ self isCustomized not or: [usedControls at: #tree]
]

{ #category : #testing }
DrGUIControlsManager >> isWheelX [
	^ self isCustomized not or: [self wheelX]
]

{ #category : #testing }
DrGUIControlsManager >> isWheelY [
	^ self isCustomized not or: [self wheelY]
]

{ #category : #testing }
DrGUIControlsManager >> isWheelZ [
	^ self isCustomized not or: [self wheelZ]
]

{ #category : #'controls data' }
DrGUIControlsManager >> keepButtonData [
	^ {'Save' translated. #keep. #saveFigure. 'Keep this sketch permanently.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> lineButtonData [
	^ {DrGLineBuilder title. #line. #createLine. DrGLineBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> locusButtonData [
	^ {DrGLocusBuilder title. #locus. #createLocus. DrGLocusBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> macroBuildButtonData [
	^ {DrGMacroBuilder title. #macroBuild. #createMacro. DrGMacroBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> macroDeleteButtonData [
	^ {'Delete macro' translated.
	#eraser .
	#deleteMacro .
	'Delete a macro-construction from the registry.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> macroExecuteButtonData [
	^ {DrGMacroPlayer title. #macroExecute. #executeMacro. DrGMacroPlayer description}
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> macroTools [
	^ #(#macroBuild #macroExecute)
]

{ #category : #menus }
DrGUIControlsManager >> macroconstructionMenu [
	| menu |
	self window macroMenu: (menu := self window newMenu).
	 self macroTools do: [ :symbol | self addMenuItem: symbol to: menu].
	^ menu
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> macroconstructionTab [
	^ self window newTable: (
		self macroTools collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #menus }
DrGUIControlsManager >> mainMenu [
	| menuBar |
	menuBar := self window newToolDockingBar.
	menuBar
		add: 'File' translated
		font: self theme menuBarFont
		icon: nil
		help: 'Load, save or export Dr. Geo figure.' translated
		subMenu: self fileMenu.
	menuBar
		add: 'Edit' translated
		font: self theme menuBarFont
		icon: nil
		help: 'Erase or edit style and properties of items.' translated
		subMenu: self editMenu.
	menuBar 
		add: 'Points' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Create points: free, on curve, intersection or middle point.' translated 
		subMenu: self pointMenu.
	menuBar 
		add: 'Lines' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Create different curve types: line, half-line, segment, vector, circle...' translated 
		subMenu: self curveMenu.
	menuBar 
		add: 'Transformations' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Transform an object with a geometric transformation: symmetry, reflexion, rotation, translation or homothety (scale).' translated 
		subMenu: self transformationMenu.
	menuBar 
		add: 'Numerics & Text' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Create several numeric objects: free value, distance, length, angle, coordinates, equation and text.' translated 
		subMenu: self numericMenu.

	menuBar 
		add: 'Script' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Script: use, edit or create script to plug in the sketch.' translated 
		subMenu: self scriptMenu.
	menuBar lastSubmorph 
		on: #mouseEnter
		send: #updateScriptMenu
		to: self.
		
	menuBar 
		add: 'Macro-construction' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Build or execute macro-construction. A macro is a construction template you can apply to items in the sketch area.' translated 
		subMenu: self macroconstructionMenu.
	menuBar lastSubmorph
		on: #mouseEnter
		send: #updateMacroMenu
		to: self.
		
	menuBar 
		add: 'Animate' translated
		font: self theme menuBarFont
		icon: nil 
		help: 'Animate a free point on curve.' translated 
		subMenu: self animateMenu.
		
		
	^ menuBar 

]

{ #category : #'controls data' }
DrGUIControlsManager >> menuButtonData [ 
	^ {'Menu' translated. nil . nil . 'An unobtrusive menu with all Dr. Geo tools.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> middleButtonData [
	^ {DrGMiddleBuilder title. #middle. #createMiddlePoint. DrGMiddleBuilder description}
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> miscControls [
	^ #(#menu #tree #wheelX #wheelY #wheelZ)
]

{ #category : #'controls data' }
DrGUIControlsManager >> moveButtonData [
	^ {DrGSelectTool title. #move. #move. DrGSelectTool description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> multipleModeButtonData [
	^ {'Create Multiple' translated. #createMultiple. #createMultipleOnOff. 'Toggle between the build of several geometric objects and the build of one geometric object then move it.' translated. #isCreateMultipleMode}
]

{ #category : #initialization }
DrGUIControlsManager >> myRelease [
	presenter := nil.
]

{ #category : #'controls data' }
DrGUIControlsManager >> newButtonData [
	^ {'New' translated. #blankFigure. #newFigure. 'Open a new blank sketch.' translated}
]

{ #category : #menus }
DrGUIControlsManager >> numericMenu [
	| menu |
	menu := self window newMenu.
	self numericTools do: [ :symbol | self addMenuItem: symbol to: menu ].
	^ menu
		
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> numericTab [
	^ self window newTable: (
		self numericTools collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> numericTools [
	^ #(#distance #angle #coordinates #text)
]

{ #category : #'controls data' }
DrGUIControlsManager >> openButtonData [
	^ {'Open' translated. #open. #openFigureThumbnail. 'Open a sketch.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> parallelButtonData [
	^ {DrGParallelBuilder title. #parallel. #createParallel. DrGParallelBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> perpendicularBisectorButtonData [
	^ {DrGPerpendicularBisectorBuilder  title. #perpendicularBisector. #createPerpendicularBisector. DrGPerpendicularBisectorBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> perpendicularButtonData [
	^ {DrGPerpendicularBuilder title. #perpendicular. #createPerpendicular. DrGPerpendicularBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> pointByCoordinatesButtonData [
	^ {DrGPointByCoordinatesBuilder title. #pointDefinedByCoordinates. #createPointByCoordinates. DrGPointByCoordinatesBuilder description}
]

{ #category : #menus }
DrGUIControlsManager >> pointMenu [
	| pointMenu |
	pointMenu := self window newMenu.
	self pointTools do: [ :symbol | self addMenuItem: symbol to: pointMenu ].
	^ pointMenu
		
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> pointTab [
	^ self window newTable: (
		self pointTools collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> pointTools [
	^ #(#freePoint #middle #intersection #pointByCoordinates)
]

{ #category : #'controls data' }
DrGUIControlsManager >> polygonButtonData [
	^ {DrGPolygonBuilder title. #polygon. #createPolygon. DrGPolygonBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> polygonRegularButtonData [
	^ {DrGPolygonRegularBuilder title. #polygonRegular. #createPolygonRegular. DrGPolygonRegularBuilder  description}
]

{ #category : #accessing }
DrGUIControlsManager >> presenter: aPresenter [
	presenter := aPresenter
]

{ #category : #'controls data' }
DrGUIControlsManager >> propertyButtonData [
	^ {DrGPropertyTool title.
	#property .
	#property .
	DrGPropertyTool description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> quitButtonData [
	^ {'Quit' translated. #quit. #quit. 'Quit' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> rayButtonData [
	^ {DrGRayBuilder title. #ray. #createRay. DrGRayBuilder description}
]

{ #category : #xml }
DrGUIControlsManager >> readXmlFrom: controlNode [
	controlNode attributes keysDo: [ :attribute | usedControls at: attribute asSymbol put: true ]

]

{ #category : #'controls data' }
DrGUIControlsManager >> redoButtonData [
	^ {'Redo' translated.
	#redo .
	#redo .
	'Redo last action.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> reflectionButtonData [
	^ {DrGReflectionBuilder title. #axialSymmetry. #createReflection.DrGReflectionBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> rotationButtonData [
	^ {DrGRotationBuilder title. #rotation. #createRotation. DrGRotationBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> scriptCreateButtonData [
	^ {'Create a script' translated. #createScript . #createScript . 'Create a Smalltalk script.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> scriptEditButtonData [
	^ {'Edit a script' translated.	#editScript.	#editScript .	'Edit a Smalltalk script.' translated}
]

{ #category : #menus }
DrGUIControlsManager >> scriptMenu [
	| menu |
	self window scriptMenu: (menu := self window newMenu).
	 self scriptTools do: [ :symbol | self addMenuItem: symbol to: menu].
	^ menu 
		
]

{ #category : #'controls data' }
DrGUIControlsManager >> scriptRunButtonData [
	^ {DrGScriptPlayer title. #useScript. #useScript. DrGScriptPlayer description}
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> scriptTab [
	| collection |
	collection := self scriptTools.
	DrGDefault ifTablet: [ collection := collection allButLast: 2].
	^ self window newTable: (collection collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> scriptTools [
	^ #(#scriptRun #scriptEdit #scriptCreate)
]

{ #category : #'controls data' }
DrGUIControlsManager >> segmentButtonData [
	^ {DrGSegmentBuilder title. #segment. #createSegment. DrGSegmentBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> styleButtonData [
	^ {DrGStyleTool title. #style. #style. DrGStyleTool description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> symmetryButtonData [
	^ {DrGSymmetryBuilder title. #centralSymmetry. #createSymmetry. DrGSymmetryBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> textButtonData [
	^ {DrGTextBuilder title. #text. #createText. DrGTextBuilder description}
]

{ #category : #accessing }
DrGUIControlsManager >> theme [
	^ self window theme
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> toolButtonFor: toolSymbol [
	| array |
	"access the buttonData method from the tool symbol"
	array := self perform: (toolSymbol, #ButtonData) asSymbol. 
	^ self window newButtonFor: presenter 
		getState: #isTool:
		action: array third 
		arguments: {array second}
		getEnabled: nil
		label: array first 
		help: array fourth
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> toolsInTab [
	| tabGroup |
	tabGroup := self window newTabGroupTool: {
		'Points' translated -> 	self pointTab.
		'Lines' translated -> self curveTab.
		'Transformations' translated -> self transformationTab.
		'Numerics & Text' translated -> self numericTab.
		'Script' translated -> self scriptTab.	
		'Macro-construction' translated -> self macroconstructionTab.
		'Animate' translated -> self animateTab}.

	tabGroup firstSubmorph  vResizing: #shrinkWrap.
	^ tabGroup

]

{ #category : #menus }
DrGUIControlsManager >> transformationMenu [
	| menu |
	menu := self window newMenu.
	self transformationTools do: [ :symbol | self addMenuItem: symbol to: menu ].
	^ menu
		
]

{ #category : #'tabular groups' }
DrGUIControlsManager >> transformationTab [
	^ self window newTable: (
		self transformationTools collect: [:aSymbol | self toolButtonFor: aSymbol])
]

{ #category : #'controls enumerate' }
DrGUIControlsManager >> transformationTools [
	^ #(#symmetry #reflection #translation #rotation #homothety)
]

{ #category : #'controls data' }
DrGUIControlsManager >> translationButtonData [
	^ {DrGTranslationBuilder title. #translation. #createTranslation. DrGTranslationBuilder description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> treeButtonData [ 
	^ {'Construction tree' translated. nil . nil . 'The hierarchy tree presenting the visible constructed items.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> undoButtonData [
	^ {'Undo' translated.
	#undo .
	#undo .
	'Undo last action' translated}
]

{ #category : #menus }
DrGUIControlsManager >> updateMacroMenu [
	| macroMenu |
	macroMenu := self window macroMenu.
	macroMenu removeAllMorphs.
	self macroTools do: [ :symbol |  self addMenuItem: symbol to: macroMenu].
	DrGMacroFactory new pool ifNotEmpty: [ macroMenu addLine ].
	DrGMacroFactory new pool do: [:aMacro |
		macroMenu 
			add: aMacro title  
			target: presenter 
			selector: #executeMacro:
			argument: aMacro.
		macroMenu lastItem
			font: self theme menuFont;
			setBalloonText: aMacro description]

]

{ #category : #menus }
DrGUIControlsManager >> updateScriptMenu [
	| scripts scriptMenu |
	scriptMenu := self window scriptMenu.
	scriptMenu removeAllMorphs.
	self scriptTools do: [ :symbol |  self addMenuItem: symbol to: scriptMenu].
	scripts := DrGeoUserScript subclasses sorted: [:script1 :script2 | 
		script1 scriptName asLowercase < script2 scriptName asLowercase].
	scripts ifNotEmpty: [scriptMenu addLine].
	scripts do: [:aScript |
		scriptMenu 
			add: aScript scriptName  
			target: presenter 
			selector: #useScript:
			argument: aScript.
		scriptMenu lastItem
			font: self theme menuFont;
			setBalloonText: aScript description]

]

{ #category : #'controls data' }
DrGUIControlsManager >> vectorButtonData [
	^ {DrGVectorBuilder title. #vector. #createVector. DrGVectorBuilder description}
]

{ #category : #widgets }
DrGUIControlsManager >> verticalWheel [ 
	| array |
	array := self wheelYButtonData.
	 ^ WheelMorph new 
		beVertical; 
		factor: 0.05; 
		setBalloonText: array first; 
		target: presenter; 
		actionSelector: array third; 
		color: Color green twiceDarker
]

{ #category : #'controls data' }
DrGUIControlsManager >> viewerButtonData [
	^ {DrGViewerTool title. #viewer. #openItemViewer. DrGViewerTool description}
]

{ #category : #'controls data' }
DrGUIControlsManager >> wheelXButtonData [ 
	^ {'Horizontal wheel' translated. nil . #moveOx: . 'A wheel to move horizontally the sketch.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> wheelYButtonData [
	 ^ {'Vertical wheel' translated . nil . #moveOy: . 'A wheel to move vertically the sketch.' translated}
]

{ #category : #'controls data' }
DrGUIControlsManager >> wheelZButtonData [
	 ^ {'Zoom wheel' translated . nil . #scale: . 'A wheel to zoom in, zoom out the sketch.' translated}
]

{ #category : #accessing }
DrGUIControlsManager >> window [
	^ presenter view
]

{ #category : #helpers }
DrGUIControlsManager >> wrapMeInAthens: aMorph [
	|athensMorph|
	athensMorph := AthensWrapMorph new
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		addMorph: aMorph.
	^ athensMorph 
]

{ #category : #xml }
DrGUIControlsManager >> writeAsXmlTo: aNode [
	usedControls keysAndValuesDo: [ :tool :isUsed |
		isUsed ifTrue: [ aNode attributeAt: tool put: 'True']]
]

{ #category : #widgets }
DrGUIControlsManager >> zoomWheel [ 
	| array |
	array := self wheelZButtonData.
	 ^ WheelMorph new 
		beVertical; 
		factor: 1; 
		setBalloonText: array first; 
		target: presenter; 
		actionSelector: array third; 
		color: Color orange darker
]
