"
A DrGPresenter is a presenter for the DrGeo app.
It is the interface to callback and button definition.

Instance Variables
	resource: 			a locale or remote resource repository where was recently saved a sketch
	selectedTool:		a symbol representing the selected UI tool

"
Class {
	#name : #DrGeoPresenter,
	#superclass : #Object,
	#instVars : [
		'model',
		'tool',
		'gridStuck',
		'isCreateMultipleMode',
		'selectedTool',
		'selection',
		'app',
		'resource',
		'filename',
		'controlsManager'
	],
	#category : #DrGeoII-Core-App
}

{ #category : #'instance creation' }
DrGeoPresenter class >> for: aDrgeo [ 
	| presenter |
	presenter := self basicNew app: aDrgeo.
"	presenter
		model: ((DrGGeometryModel in: aDrgeoModel domain)
				presenter: presenter).
"
	presenter initialize.
	^ presenter
]

{ #category : #'instance creation' }
DrGeoPresenter class >> with: aDrgeo [ 
	| presenter |
	presenter := self basicNew app: aDrgeo.
"	presenter
		model: ((DrGGeometryModel in: aDrgeoModel domain)
				presenter: presenter).
"
	presenter initialize.
	^ presenter
]

{ #category : #'callback canvas' }
DrGeoPresenter >> animate [
	selectedTool == #animate 
		ifTrue: ["just close the tabl"
			self triggerEvent: #selectedToolFromTab] 
		ifFalse: [
			self selectTool: DrGAnimateTool.
			selectedTool := #animate].
	self changed
]

{ #category : #'callback canvas' }
DrGeoPresenter >> animate1 [
	self animate.
	self tool animateStep: 0.01.

]

{ #category : #'callback canvas' }
DrGeoPresenter >> animate2 [
	self animate.
	self tool animateStep: 0.043.

]

{ #category : #'callback canvas' }
DrGeoPresenter >> animate3 [
	self animate.
	self tool animateStep: 0.076.

]

{ #category : #'callback canvas' }
DrGeoPresenter >> animate4 [
	self animate.
	self tool animateStep: 0.1

]

{ #category : #accessing }
DrGeoPresenter >> app [
	^ app
]

{ #category : #accessing }
DrGeoPresenter >> app: aDrgeo [
	app := aDrgeo
]

{ #category : #accessing }
DrGeoPresenter >> area [
	^ self view ifNotNil: [self view area]
]

{ #category : #'callback UI' }
DrGeoPresenter >> askForBitmapToExport [
	| answer|
	answer := UIManager default 
		request: 'Name the bitmap to export:' translated
		initialAnswer: app title.
	^ answer 
		ifNotNil: [MultiByteFileStream forceNewFileNamed: (DrGDefault myExportsPath / (answer, '.png')) pathString ]
]

{ #category : #'callback UI' }
DrGeoPresenter >> askForFileToSave [
"Save a sketch at an arbitrary location"
| file rsce|
	file := self view
		fileSave: 'Pick a Dr. Geo file name' translated 
		extensions: #('fgeo')
		path: (filename ifNil: [DrGDefault mySketchesPath]).
	file  ifNotNil: [
		rsce := DrGDirectoryLocal new 
		filename: file basename;
		directory: file parent pathString]. 
	^ rsce 
]

{ #category : #'callback UI' }
DrGeoPresenter >> askForSketchToKeep [
| dialog newResource answer|
	DrGDefault showVirtualKeyboard: true.
	dialog := DrGFilenameDialog new
		textFont: UITheme new textFont;
		title: 'Filename' translated;
		text: 'Name the sketch to keep.' translated.
	dialog openInWorld.
	self view openModal: dialog.
	DrGDefault showVirtualKeyboard: false.
	(dialog cancelled or: [dialog entryText isNil]) ifTrue: [^ nil].
	dialog network 
		ifTrue: [newResource := DrGDefault networkResourcesCreateShare] 
		ifFalse: [newResource := DrGDefault mySketchResources].
	newResource ifNotNil: [newResource filename: dialog entryText, '.fgeo'].
	^ newResource
]

{ #category : #'callback canvas' }
DrGeoPresenter >> axesOnOff [
	self area axesVisibleOnOff.
	self area updateGrid.
	self changed
]

{ #category : #helpers }
DrGeoPresenter >> cachePreviewFilename: string [
	"the name of the cahed preview if it exist"
	^ ((string allButLast: 4), 'png')
]

{ #category : #'callback create' }
DrGeoPresenter >> captureSelection [
|mathItems|
	self selection: self area selection.
	self selection ifNotNil:
		[mathItems := self selection collect: [:aMorph |
				aMorph costume mathItem].
		self domain createCompositeItem: mathItems].
	self area selection: nil
]

{ #category : #accessing }
DrGeoPresenter >> controlsManager [
	^ controlsManager
]

{ #category : #accessing }
DrGeoPresenter >> controlsManager: anObject [
	controlsManager := anObject.
	controlsManager presenter: self.
]

{ #category : #'callback create' }
DrGeoPresenter >> createAngle [
	self selectTool: DrGBuildTool with: DrGAngleBuilder.
	selectedTool := #angle.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createAngleBisector [
	self selectTool: DrGFlyBuildTool with: DrGAngleBisectorBuilder.
	selectedTool := #angleBisector.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createArc [
	self selectTool: DrGFlyBuildTool with: DrGArcBuilder.
	selectedTool := #arc.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createArcCenter [
	self selectTool: DrGFlyBuildTool with: DrGArcCenterBuilder.
	selectedTool := #arcCenter.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createCircle [
	DrGDefault ifPremium: [
		self selectTool: DrGFlyBuildTouchTool with: DrGCircleBuilder.
		selectedTool := #circle.
		self changed]
]

{ #category : #'callback create' }
DrGeoPresenter >> createCoordinatePoint [
	self selectTool: DrGBuildTool with: DrGPointByCoordinatesBuilder.
	selectedTool := #pointDefinedByCoordindates.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createCoordinates [
	self selectTool: DrGBuildTool with: DrGCoordinatesBuilder.
	selectedTool := #coordinates.
	self changed

]

{ #category : #'callback create' }
DrGeoPresenter >> createDistance [
	self selectTool: DrGBuildTool with: DrGValueBuilder.
	selectedTool := #distance.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createFreePoint [
	self selectTool: DrGFlyPointBuildTool with: DrGFlyPointBuilder.
	selectedTool := #freePoint.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createHomothety [
	self selectTool: DrGBuildTool with: DrGHomothetyBuilder.
	selectedTool := #scale.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createLine [
	self selectTool: DrGFlyBuildTouchTool with: DrGLineBuilder.
	selectedTool := #line.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createLocus [
	self selectTool: DrGBuildTool with: DrGLocusBuilder.
	selectedTool := #locus.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createMacro [
	self selectTool: DrGMacroBuildTool with: DrGMacroBuilder.
	selectedTool := #macroBuild.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createMiddlePoint [
	self selectTool: DrGBuildTool with: DrGMiddleBuilder.
	selectedTool := #middle.
	self changed
]

{ #category : #'callback canvas' }
DrGeoPresenter >> createMultipleOnOff [
	isCreateMultipleMode := isCreateMultipleMode not.
	self changed
]

{ #category : #accessing }
DrGeoPresenter >> createMultipleString [
	^ (self isCreateMultipleMode
		ifTrue: ['<on>']
		ifFalse: ['<off>'])
		, 'create multiple' translated
]

{ #category : #'callback create' }
DrGeoPresenter >> createParallel [
	DrGDefault ifPremium: [
		self selectTool: DrGFlyBuildTouchTool with: DrGParallelBuilder.
		selectedTool := #parallel.
		self changed]
]

{ #category : #'callback create' }
DrGeoPresenter >> createPerpendicular [
	DrGDefault ifPremium: [
		self selectTool: DrGFlyBuildTouchTool with: DrGPerpendicularBuilder.
		selectedTool := #perpendicular.
		self changed]
]

{ #category : #'callback create' }
DrGeoPresenter >> createPerpendicularBisector [
	self selectTool: DrGFlyBuildTouchTool with: DrGPerpendicularBisectorBuilder.
	selectedTool := #perpendicularBisector.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createPointByCoordinates [
	self selectTool: DrGBuildTool with: DrGPointByCoordinatesBuilder.
	selectedTool := #pointDefinedByCoordinates.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createPointIntersection [
	self selectTool: DrGBuildTool with: DrGPointIntersectionBuilder.
	selectedTool := #intersection.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createPolygon [
	self selectTool: DrGFlyBuildTool with: DrGPolygonBuilder.
	selectedTool := #polygon.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createPolygonRegular [
	self selectTool: DrGFlyBuildTool with: DrGPolygonRegularBuilder.
	selectedTool := #polygonRegular.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createRay [
	self selectTool: DrGFlyBuildTouchTool with: DrGRayBuilder.
	selectedTool := #ray.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createReflection [
	self selectTool: DrGBuildTool with: DrGReflectionBuilder.
	selectedTool := #axialSymmetry.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createRotation [
	self selectTool: DrGBuildTool with: DrGRotationBuilder.
	selectedTool := #rotation.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createScript [
	|browser dialog scriptClass|
	"We force to select mode as we do not interact with the sketch"	
	self move.
	self triggerEvent: #selectedToolFromTab.
	self changed.


	dialog := DrGScriptDesignerDialog new.
	DrGDefault ifTablet: [dialog topCentered].
	dialog openModal.
	dialog cancelled ifTrue: [^self].
	"Create the script class, then open a browser on"
	scriptClass := self createScriptFrom: dialog.
	
	browser := Nautilus newOnClass: scriptClass selector: #compute.
	browser ui title: ('Edit script: {1}' translated format: {scriptClass scriptName}).

	SystemAnnouncer uniqueInstance weak on: MethodModified send: #update: to: self domain.
	browser  ui window extent: 800@350.

]

{ #category : #helpers }
DrGeoPresenter >> createScriptFrom: dialog [
"Build a new script from the dialog, return the newly created script object"
	|scriptClass stream|
	scriptClass := DrGeoUserScript 
		subclass: ('DrGeoScript', dialog scriptName hash printString) asSymbol
		instanceVariableNames: '' 
		classVariableNames: '' 
		category:  'DrGeoII-User'.
	"name"
	stream := WriteStream on: String new.
	stream << 'scriptName' << Character cr
		<< Character tab << $^ 
		<< dialog scriptName storeString.
	scriptClass class compile: stream contents classified: 'public'.
	"description"
	stream := WriteStream on: String new.
	stream << 'description' << Character cr
		<< Character tab << $^  
		<< dialog description string storeString.
	scriptClass class compile: stream contents classified: 'public'.
	"argumentsType"
	stream := WriteStream on: String new.
	stream << 'newArgumentsType' << Character cr
		<< Character tab	<< $^ <<${.
	dialog argumentsType 
		do: [:type| stream << type printString] 
		separatedBy: [stream << $.].
	stream << $}.
	scriptClass class compile: stream contents classified: 'private'.
	"compute"
	stream := WriteStream on: String new.
	stream << 'compute' << Character cr
		<< '"Edit me"' << Character cr
		<< Character tab	<< $^ << '1+1'.
	scriptClass compile: stream contents classified: 'public'.
	
	^ scriptClass
]

{ #category : #'callback create' }
DrGeoPresenter >> createSegment [
	self selectTool: DrGFlyBuildTouchTool with: DrGSegmentBuilder.
	selectedTool := #segment.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createSymmetry [
	self selectTool: DrGBuildTool with: DrGSymmetryBuilder.
	selectedTool := #centralSymmetry.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createText [
	self selectTool: DrGBuildTool with: DrGTextBuilder.
	selectedTool := #text.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createTranslation [
	self selectTool: DrGBuildTool with: DrGTranslationBuilder.
	selectedTool := #translation.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> createVector [
	self selectTool: DrGFlyBuildTouchTool with: DrGVectorBuilder.
	selectedTool := #vector.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> deleteMacro [
	self selectTool: DrGSelectTool.
	selectedTool := #deleteMacro.
	self changed
]

{ #category : #updating }
DrGeoPresenter >> deleteMathItem: aCostume [
	self domain deleteMathItem: aCostume mathItem.
	self domain updateAllMathItems
]

{ #category : #accessing }
DrGeoPresenter >> domain [
	^app domain 
]

{ #category : #'callback create' }
DrGeoPresenter >> editScript [
	|browser|
	"We force to select mode, then open a browser on the script classes"
	self move.
	browser := (Nautilus newOnClass: DrGeoUserScript)
	 		selectedCategory: #examples.
	browser ui title: 'Edit or create scripts' translated.
	SystemAnnouncer uniqueInstance weak on: MethodModified send: #update: to: self domain.
	browser  ui window extent: 800@350.
	
	self triggerEvent: #selectedToolFromTab.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> editSelection [
	self selectTool: DrGEditGroupTool
]

{ #category : #'callback create' }
DrGeoPresenter >> eraser [
	selectedTool := #eraser.
	self selectTool: DrGDeleteTool.
	self changed: #selectedTool.
	app redrawCostumes.
]

{ #category : #'callback create' }
DrGeoPresenter >> executeMacro [
	self selectTool: DrGMacroPlayTool with: DrGMacroPlayer.
	selectedTool := #macroExecute.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> executeMacro: aMacro [
	self selectTool: DrGMacroPlayTool with: DrGMacroPlayerHeadless.
	selectedTool := #macroExecute. 
	self tool builder selectedMacro: aMacro.
	self tool switchState: DrGMacroPlayToolStateSelect.
	self changed
]

{ #category : #'callback UI' }
DrGeoPresenter >> exportToBitmap [
	| stream |
	stream := self askForBitmapToExport.
	stream ifNotNil: [ | form |
		form := (Form extent: self area extent depth: 32) fillWhite.
		self area owner athensSurface displayOnMorphicCanvas: form getCanvas at: 0 @ 0.
		PNGReadWriter putForm: form copy onStream: stream.
		Clipboard clipboardText: stream contents asText.
		stream close].
]

{ #category : #'callback canvas' }
DrGeoPresenter >> gridOnOff [
	self area gridVisibleOnOff.
	self area updateGrid.
	self changed
]

{ #category : #accessing }
DrGeoPresenter >> gridString [
	^ (self isGridVisible
		ifTrue: ['<on>']
		ifFalse: ['<off>'])
		, 'grid' translated
]

{ #category : #'callback canvas' }
DrGeoPresenter >> gridStuckOnOff [
	gridStuck := gridStuck not.
	self changed
]

{ #category : #accessing }
DrGeoPresenter >> griddedString [
	^ (self isGridded
		ifTrue: ['<on>']
		ifFalse: ['<off>'])
		, 'snap to grid' translated
]

{ #category : #'callback UI' }
DrGeoPresenter >> help [
	DrGDefault openURI: 'http://www.drgeo.eu/tablet'
]

{ #category : #initialize-release }
DrGeoPresenter >> initialize [
	super initialize.
	controlsManager := DrGUIControlsManager for: self.
	self move.
	isCreateMultipleMode := false.
	gridStuck := false.
]

{ #category : #testing }
DrGeoPresenter >> isAxesVisible [
	^ self area 
		ifNotNil: [self area axesVisible]
		ifNil: [false]
]

{ #category : #testing }
DrGeoPresenter >> isCreateMultipleMode [
	^isCreateMultipleMode
]

{ #category : #testing }
DrGeoPresenter >> isForceVisible [
	"We force unvisible costume to be visible when in style mode only"
	^ (self isTool: #style) or: [self isTool: #eraser]
]

{ #category : #testing }
DrGeoPresenter >> isGridVisible [
	^ self area 
		ifNotNil: [self area gridVisible]
		ifNil: [false]
]

{ #category : #testing }
DrGeoPresenter >> isGridded [
	^ gridStuck
]

{ #category : #testing }
DrGeoPresenter >> isTool: symbolTool [
"Do we have this symbolTool selected"
	^ selectedTool == symbolTool 
]

{ #category : #accessing }
DrGeoPresenter >> model [
	^model
]

{ #category : #accessing }
DrGeoPresenter >> model: aModel [
	model := aModel
]

{ #category : #'callback canvas' }
DrGeoPresenter >> move [
	self selectTool: DrGSelectTool.
	selectedTool := #move.
	self changed
]

{ #category : #'callback canvas' }
DrGeoPresenter >> moveOx: increment [
	self area moveOx: increment.
]

{ #category : #'callback canvas' }
DrGeoPresenter >> moveOy: increment [
	self area moveOy: increment.
]

{ #category : #'callback UI' }
DrGeoPresenter >> newFigure [
	DrGDefault ifTablet: [
		(UIManager default 
			confirm: 'Close the existing sketch and create an empty one?' translated 
			trueChoice: 'New sketch' translated
			falseChoice: 'No, keep this sketch' translated) ifTrue: [
				self newFigureAndForgetPrevious].
		^self].
	DrGeo new
]

{ #category : #'callback UI' }
DrGeoPresenter >> newFigureAndForgetPrevious [
	DrGeo newFullScreen.
	self view deleteWithoutConfirmation
]

{ #category : #'callback UI' }
DrGeoPresenter >> openCustomizerDialog [
	controlsManager customizerDialog 
]

{ #category : #'callback UI' }
DrGeoPresenter >> openFigureAt [
"Open a sketch at an arbitrary location"
	DrGeo openFigure 
]

{ #category : #'callback UI' }
DrGeoPresenter >> openFigureThumbnail [
	DrGDefault isTablet
		ifTrue: [ |answer|
			answer := UIManager default 
				confirm: 'Close the existing sketch and open a new one?' translated 
				trueChoice: 'Open sketch' translated
				falseChoice: 'No, keep this sketch' translated.
			answer  ifTrue: [	DrGeo openFigureThumbnail: self view]]
		ifFalse: ["we don't close the existing view when not in tablet"
			DrGeo openFigureThumbnail: nil]
]

{ #category : #'callback create' }
DrGeoPresenter >> openItemViewer [
	self selectTool: DrGViewerTool.
	self changed
]

{ #category : #'callback UI' }
DrGeoPresenter >> openNewFigureThumbnail [
	DrGeo openFigureThumbnail: nil
]

{ #category : #tool }
DrGeoPresenter >> openViewerForCostume: aCostume [
	aCostume openViewer.
	self selectTool: DrGSelectTool
]

{ #category : #'callback create' }
DrGeoPresenter >> property [ 
	self selectTool: DrGPropertyTool.
	selectedTool := #property.
	self changed
]

{ #category : #'callback UI' }
DrGeoPresenter >> quit [
	DrGeo quit.
]

{ #category : #updating }
DrGeoPresenter >> readyToBuild [
	|answer|
	"readyToBuild event, the builder is ready to build, request to the domain the construction of the math item under the builder"
	answer := self domain createMathItem: self tool builder.
	answer last ifFalse: [(app costumeOf: answer first) unhide].
	self selectionCleanUp.
	self domain updateAllMathItems.
	app saved: false.
]

{ #category : #updating }
DrGeoPresenter >> readyToBuildClone [
	|answer|
	"readyToBuild event sent from the SelectTool. The builder is ready to clone an items and its parents,
	 request to the domain the construction of the math item under the builder"
	answer := self domain createMathItem: self tool builder.
	self tool grabClone: answer first last.
]

{ #category : #updating }
DrGeoPresenter >> readyToBuildMacro [
	"readyToBuild event, the builder is ready to build a macro, request to the domain the construction of the math item under the builder"
	self domain createMacro: self tool builder.
	self move
]

{ #category : #updating }
DrGeoPresenter >> readyToPlayMacro [
	"readyToBuild event, the builder is ready to play a macro (enought input items), request to the domain the construction of the math items under the builder"
	self domain playMacro: self tool builder in: app.
	self move
]

{ #category : #'callback canvas' }
DrGeoPresenter >> redo [
	self domain redo.
	self domain updateAllMathItems.
	app saved: false
]

{ #category : #initialize-release }
DrGeoPresenter >> release [
	tool release.
	model release.
	self domain release.
	controlsManager myRelease.
	app := nil.
	controlsManager := nil.
	model := nil.
	filename := nil.
	resource := nil.
]

{ #category : #'callback UI' }
DrGeoPresenter >> save: rsrc [
"Save this resource and make it our default one"
| stream |
	[self saveWithinLimitedTime: [
		self app saved: true.
		DrGLoader start.
		resource := rsrc.
		self view title: resource filename asFileReference basenameWithoutExtension capitalized.
		stream := RWBinaryOrTextStream on: (String new: 4000).
		self app saveOn: stream. 
		resource put: stream. 
		resource put: self app preview into: (self cachePreviewFilename: resource filename )].
	stream close.
	rsrc close]
		on: Error 
		do: [:ex | DrGLoader stop. 
			resource ifNotNil: [resource close].
			resource := nil.
			stream close.
			self halt].
	DrGLoader stop
]

{ #category : #'callback UI' }
DrGeoPresenter >> saveFigure [
	DrGDefault ifPremium: [
		resource 
			ifNil: [self saveFigureAs]
			ifNotNil: [
				resource ensureConnection.
				self save: resource]]

]

{ #category : #'callback UI' }
DrGeoPresenter >> saveFigureAs [
	self askForSketchToKeep ifNotNil: [ :rsrc | self save: rsrc ]
]

{ #category : #'callback UI' }
DrGeoPresenter >> saveFigureAt [
	self askForFileToSave ifNotNilDo: [:rsrc | self save: rsrc]
]

{ #category : #'callback UI' }
DrGeoPresenter >> saveMultiple [
"Make a selection of figures and macro-constructions to save"
	|items dialog stream|
	items := OrderedCollection new.
	items addAll: DrGeo figuresArray;	addAll: DrGeo macrosArray.
	dialog := (SelectItemDialog items: items)
		textFont: StandardFonts defaultFont;
		title:  'Save Multiple' translated;
		text: 'Select the sketches and macros you want to save:' translated.
	(self view openModal: dialog) cancelled ifTrue: [ ^self].
	[self askForSketchToKeep ifNotNilDo: [:rsrc |
		items := items select: [:item | item third contents = true] thenCollect: [:item | item first].
		self saveWithinLimitedTime: [
			stream := RWBinaryOrTextStream on: (String new: 4000).
			DrGeoXml new saveMultiple: items on: stream.
			rsrc put: stream.
			rsrc 
				put:  (items detect: [:item | item class = DrGeo] ifNone: [DrGeo]) preview 
				into: (self cachePreviewFilename: rsrc filename )].
		stream close]] ensure: [DrGLoader stop]

]

{ #category : #'callback UI' }
DrGeoPresenter >> saveWithinLimitedTime: aBlock [
	[aBlock value]
		valueWithin: 10 seconds
		onTimeout: 	
			[DrGLoader stop.
			UIManager default abort: 'I can''t save the sketch.
Check the local resource or the server.' translated].
]

{ #category : #'callback canvas' }
DrGeoPresenter >> scale: increment [
	self area scale: increment.
]

{ #category : #tool }
DrGeoPresenter >> selectTool: aToolClassName [
	self tool: nil.
	self tool: (aToolClassName new presenter: self).
	self triggerEvent: #selectedToolFromTab
]

{ #category : #tool }
DrGeoPresenter >> selectTool: aToolClassName with: aBuilderClassName [ 
	self
		tool: ((aToolClassName with: aBuilderClassName)
				presenter: self).
	self domain changed: #selectedTool.
	self triggerEvent: #selectedToolFromTab
]

{ #category : #tool }
DrGeoPresenter >> selectToolAfterBuilding [
	self isCreateMultipleMode
		ifFalse:
			[self move]
]

{ #category : #accessing }
DrGeoPresenter >> selection [
	^selection
]

{ #category : #accessing }
DrGeoPresenter >> selection: aSelection [
	aSelection 
		ifNil: [selection := nil]
		ifNotNil:
			[selection := aSelection select: [:aMorph |
				aMorph isMorphCostume]]
]

{ #category : #tool }
DrGeoPresenter >> selectionCleanUp [
|createdItem|
	"a mathItem is just been created, do some clean up"
	self tool reset.
	createdItem := self domain factory last.
	"eventually if not in createMultipleMode we escape from this tool"
	(createdItem isFreePointItem 
		or: [createdItem isIntersectionPointItem 
		or: [createdItem isPointItemOnCurve]])
			ifFalse: [self selectToolAfterBuilding].
	((tool class = DrGFlyPointBuildTool) or: [selectedTool = #intersection]) ifTrue: [
		self selectToolAfterBuilding].

]

{ #category : #'callback canvas' }
DrGeoPresenter >> style [
	selectedTool := #style.
	self selectTool: DrGStyleTool.
	self changed: #selectedTool.
	app redrawCostumes.

]

{ #category : #accessing }
DrGeoPresenter >> tool [
	^tool
]

{ #category : #accessing }
DrGeoPresenter >> tool: aTool [ 
	tool
		ifNotNil: [tool release].
	tool := aTool.
	tool ifNotNil: [tool registerDependant: self].
	(tool notNil and: [self view notNil])  ifTrue: [self view statusMessage:  tool description]
]

{ #category : #'callback canvas' }
DrGeoPresenter >> undo [
	self tool resetForFreshStart.
	self domain undo.
	self domain updateAllMathItems.
	app saved: false
]

{ #category : #updating }
DrGeoPresenter >> updateSelection [
	(self isTool: #move) ifTrue: [|node| 
		node := self view tree selection lastSelectedNode.
		node isNil 
			ifTrue: [self tool costume: nil]
			ifFalse: [node item isMathItem ifTrue: [
				self tool costume: (app costumeOf: node item)]]]
]

{ #category : #'callback create' }
DrGeoPresenter >> useScript [
	self selectTool: DrGScriptPlayTool with: DrGScriptPlayer.
	selectedTool := #useScript.
	self changed
]

{ #category : #'callback create' }
DrGeoPresenter >> useScript: aScript [
	self selectTool: DrGScriptPlayTool with: DrGScriptPlayerHeadless.
	selectedTool := #useScript.
	self tool builder scriptClass: aScript.
	self tool switchState: DrGMacroPlayToolStateSelect.
	self changed
]

{ #category : #accessing }
DrGeoPresenter >> view [
	^ app ifNotNil: [app view]
]
