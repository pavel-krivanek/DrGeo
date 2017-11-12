"
The application model. It is encapsulating our sub model: geometry model, tree model and script model.
Two viewers are proposed:
 - a service is basicaly a canvas with wheel morphs, it can be embedded in bookmorph ,...
 - a polymorph window with a friendly graphic user interface
 - isNotInteractive: do we let pop up show up
"
Class {
	#name : #DrGeo,
	#superclass : #Object,
	#instVars : [
		'view',
		'domain',
		'costumes',
		'undoneCostumes',
		'presenter',
		'lastCostume',
		'notInteractive',
		'toolbarless',
		'saved'
	],
	#category : #DrGeoII-Core-App
}

{ #category : #'user interface' }
DrGeo class >> aboutDrgeo [
	|dialog width text |
	text := self drgeoInformationString.
	width := 0.
	text linesDo: [:l | 
		width := width max: (UITheme current textFont widthOfStringOrText: l)].
	dialog := LongMessageDialogWindow new entryText: text.
	dialog iconMorph image: DrGIcons drgeo.
	dialog title: 'About Dr. Geo'.
	dialog open.
	dialog textMorph minWidth: 20;
		 minHeight: 20.
	dialog
		width: (width + 120 min: Display width - 50).
	dialog position: 25 @ 25
]

{ #category : #'instance creation' }
DrGeo class >> applicationToolbarless [
	"instanciate a DrGeo service, to embbed in third party application or for the widgetless Etoys. It is just the canvas with suround menu and icon"
	^ self applicationToolbarlessIn: DrGeoDomain new
]

{ #category : #'instance creation' }
DrGeo class >> applicationToolbarlessIn: aDomain [ 
	"A new model with an existing domain. For multiple MVP on a same
	Domain"
	^ super basicNew domain: aDomain;
		 initializeApplicationToolbarless
]

{ #category : #'user interface' }
DrGeo class >> drgeoCopyright [
	^ 'Copyright 1996-2015 Hilaire Fernandes'
]

{ #category : #'user interface' }
DrGeo class >> drgeoInformationString [
	|text |
	text := 'Dr. Geo is about interactive geometry and programming.
{1}
	
It allows one to create geometric figure plus the interactive manipulation 
of such figure in respect with their geometric constraints. 
It is usable in teaching situation with students from primary or secondary level. 

It is simple and effective with some unique features as Smalltalk scripting 
and programmed interactive sketches. 

{2}

LICENSE : GPL' format: {self drgeoVersion. self drgeoCopyright}.
	^ text
]

{ #category : #'user interface' }
DrGeo class >> drgeoVersion [
	^ 'Installed version: ', ConfigurationOfDrGeo new project currentVersion versionNumber versionString
]

{ #category : #canvas }
DrGeo class >> emptyPreview [
"compute an empty PNG preiview and put it in a stream"
	|form stream textForm|
	form := Form extent: self previewSize depth: 8.
	form fill: form boundingBox rule: Form over fillColor: Color white.
	textForm := (StringMorph contents: 'No preview' translated font: DrGDefault font) imageForm.
	form copy: form boundingBox from: textForm to: (form center - (textForm extent / 2)) rule: Form over.
	stream := ByteArray new writeStream.
	PNGReadWriter putForm: form onStream: stream.
	^ stream
]

{ #category : #canvas }
DrGeo class >> figuresArray [
	|items activeFigures|
	activeFigures := OrderedCollection new.
	DrGeoWindow allInstances do: [:each | 
		each owner isNil ifFalse: [activeFigures add: each app]].
	items := OrderedCollection new.
	activeFigures do: [:figure |
		items add: (Array 
			with:  figure 
			with:  'Fig. - ' translated, figure title 
			with: (ValueHolder new contents: figure isSaved not))].
	^ items

]

{ #category : #'objects from disk' }
DrGeo class >> file: filename [ 
	|answer|
	DrGLoader start.
	answer := DrGeoXml new load: filename for: #new:.
	DrGLoader stop.
	^ answer
]

{ #category : #'objects from disk' }
DrGeo class >> fileFullscreen: filename [ 
	|answer|
	DrGLoader start.
	answer := DrGeoXml new load: filename for: #newFullScreen:.
	DrGLoader stop.
	^ answer
]

{ #category : #'objects from disk' }
DrGeo class >> fullscreenOn: stream [
	|answer |
	DrGLoader start.
	answer := DrGeoXml new loadFrom: stream for: #newFullScreen:.
	DrGLoader stop.
	^ answer 
]

{ #category : #'instance creation' }
DrGeo class >> in: aDomain [ 
	^ self in: aDomain controlsManager: nil
]

{ #category : #'instance creation' }
DrGeo class >> in: aDomain controlsManager: controlsManager [
	"A new model with an existing domain. For multiple MVP on a same
	Domain"
	^ super basicNew domain: aDomain;
		 initializeApplication: controlsManager
]

{ #category : #canvas }
DrGeo class >> macrosArray [
	|items|
	items := OrderedCollection new.
	DrGMacroFactory new pool do: [:macro |
		items add: (Array 
			with: macro 
			with: 'Macro - ' translated, macro title 
			with: (ValueHolder new contents: macro isSaved not) )].
	^ items
]

{ #category : #'instance creation' }
DrGeo class >> new [
	^ self new: nil
]

{ #category : #'instance creation' }
DrGeo class >> new: controlsManager [
	"instanciate a standard DrGeo application"
	|answer|
	DrGLoader start.
	answer := DrGDefault isEtoys 
		ifFalse: [self in: DrGeoDomain new controlsManager: controlsManager]
		ifTrue: [DrGeo sample openInWorld].
	DrGLoader stop.
	^ answer
]

{ #category : #'instance creation' }
DrGeo class >> newFullScreen [
	^ self newFullScreen: nil
]

{ #category : #'instance creation' }
DrGeo class >> newFullScreen: controlsManager [
	|app|
	app := DrGeo new: controlsManager.
	app view 
		fullscreen;
		position: 0@0.
	^ app
]

{ #category : #'objects from disk' }
DrGeo class >> newXmlOn: stream [ 
	^ DrGeoXml new loadFrom: stream for: #new:
]

{ #category : #'instance creation' }
DrGeo class >> openFigure [
	" DrGeo openFigure "
	| stream apps title|
	stream := DrGeoWindow basicNew
		fileOpen: 'Pick a Dr. Geo file name' translated 
		extensions: #('fgeo')
		path:  DrGDefault examplesPath 
		preview: #drgeo.
	stream ifNotNil: [ 
		apps := DrGeo newXmlOn: stream.
		title := stream name asFileReference basenameWithoutExtension capitalized]
]

{ #category : #'instance creation' }
DrGeo class >> openFigureThumbnail: parentView [
	" DrGeo openFigureThumbnail "
	| dialog |
	dialog := DrGFileThumbnailDialog new.
	parentView 
		ifNil: [dialog openInWorld;
				center: World center;
				delete.
			self currentWorld openModal: dialog]
		ifNotNil: [dialog openInWorld.
			dialog center: World center.
			parentView openModal: dialog].
	(dialog cancelled or: [dialog finalSelectedFile isNil]) ifTrue: [^ dialog closeResource].
	((DrGeo fullscreenOn: (dialog selectedFileStream)) notEmpty & parentView notNil)  ifTrue: [
		parentView deleteWithoutConfirmation].
	dialog closeResource.
	DrGDefault showVirtualKeyboard: false.
]

{ #category : #canvas }
DrGeo class >> preview [
	"class side: return an empty PNG  preview in a stream"
	^ self emptyPreview
]

{ #category : #canvas }
DrGeo class >> previewSize [
	^ 320@240
]

{ #category : #'user interface' }
DrGeo class >> quit [
	self unsavedData isNotEmpty ifTrue: [ 
		(self confirm: 'There is unsaved data! 
Are you sure to quit Dr. Geo environment?' translated) ifFalse: [ ^ self]].
	Smalltalk quitPrimitive
]

{ #category : #'instance creation' }
DrGeo class >> sample [
	"DrGeo sample openInWorld"
	^ self service view
]

{ #category : #'instance creation' }
DrGeo class >> service [
	"instanciate a DrGeo service, to embbed in third party application or for the widgetless Etoys. It is just the canvas with suround menu and icon"
	^ self serviceIn: DrGeoDomain new
]

{ #category : #'instance creation' }
DrGeo class >> serviceIn: aDomain [ 
	"A new model with an existing domain. For multiple MVP on a same
	Domain"
	^ super basicNew domain: aDomain;
		 initializeService
]

{ #category : #'objects from disk' }
DrGeo class >> serviceViewXml: filename [ 
	(self serviceXml: filename) do: [:each | 
		each view
			center: Display center;
			openInWorld]
]

{ #category : #'objects from disk' }
DrGeo class >> serviceXml: filename [ 
	^ DrGeoXml new load: filename for: #service

]

{ #category : #'user interface' }
DrGeo class >> toolsMenuOn: aBuilder [
	<drgeoMenu>
	(aBuilder item: #'System Browser') 
		parent: #'Tools';
		action: [Smalltalk tools browser openOnClass: DrGeo]; 
		icon: Nautilus taskbarIcon;
		help: 'A source code browser to view, edit and save Dr. Geo code'.
	(aBuilder item: #Workspace) 
		parent: #'Tools';
		action: [Workspace open]; 
		icon: Workspace taskbarIcon;
		help: 'An editor to write and execute Dr. Geo programmed figure'.
	(aBuilder item: #'Method finder') 
		parent: #'Tools';
		action: [Finder open]; 
		icon: ThemeIcons current smallInfoIcon;
		help: 'A tool to discover method'.
	(aBuilder item: #'Open a file')
		parent: #'Tools';
		action: [FileList open];
		icon: ThemeIcons current  smallOpenIcon;
		help: 'Open a text, a picture or a script'.
		
	DrGDefault isWorkstation ifTrue: [
		(aBuilder item: #'Update Dr. Geo')
			parent: #'Tools';
			action: 
				[Gofer new
					url: 'http://smalltalkhub.com/mc/HilaireFernandes/DrGeo/main';
					package: 'ConfigurationOfDrGeo';
					load.
				((Smalltalk at: #ConfigurationOfDrGeo ) project version: #development) load: #release];
			icon: ThemeIcons current smallUpdateIcon].  
		
	(aBuilder item: #'Save session') 
		parent: #'Tools';
		action: [Smalltalk saveSession]; 
		icon: ThemeIcons current  smallSaveIcon;
		help: 'Save this Dr. Geo session'.
]

{ #category : #canvas }
DrGeo class >> unsavedData [
"Answer a collection of unsaved data"
	| unsavedData |
	unsavedData := OrderedCollection new.
	unsavedData 
		addAll: (self figuresArray select: [:each | each third contents]);
		addAll: (self macrosArray select: [:each | each third contents]).
	^ unsavedData
]

{ #category : #'user interface' }
DrGeo class >> worldMenu: aBuilder [
	<drgeoMenu>
	(aBuilder item: 'New' translated) 
		action: [DrGeo newFullScreen]; 
		icon: ThemeIcons current smallNewIcon;
		order: 0.
	(aBuilder item: 'Open' translated) 
		action: [DrGeo openFigureThumbnail: nil];
		icon: ThemeIcons current smallOpenIcon;
		order: 1.
	(aBuilder item: 'Settings' translated) 
		action: [(SettingBrowser forKeywords: #('drgeosettings')) open];
		icon: ThemeIcons current smallConfigurationIcon;
		order: 2.
	(aBuilder item: 'About' translated) 
		action: [DrGeo aboutDrgeo];
		icon: ThemeIcons current smallLanguageIcon;
		order: 3.
	(aBuilder item: #'Tools') icon: ThemeIcons current smallDoItIcon; order: 5.0.
	(aBuilder item: 'Quit' translated) action: [DrGeo quit]; order: 999

]

{ #category : #costume }
DrGeo >> add: aCostume [
	^ costumes add: aCostume.
]

{ #category : #accessing }
DrGeo >> area [
	^ view area
]

{ #category : #initialize-release }
DrGeo >> buildViewAndOpen: controlsManager [
	presenter := DrGeoPresenter for: self.
	controlsManager ifNotNil: [presenter controlsManager: controlsManager]. "use another one"
	view := DrGeoWindow for: self.
	presenter controlsManager installTools.
	view themeChanged; openInWorld.
	presenter move.
	DrGDefault ifTablet: [view removeGrips].
	DrGDefault ifRelease: [view beSticky]
]

{ #category : #costume }
DrGeo >> costume: aMathItem [ 
	"new math item event : A new math item has been created, create its costume"

	lastCostume := self add: (DrGMathItemCostume for: aMathItem in: self area)
]

{ #category : #costume }
DrGeo >> costumeOf: aMathItem [
"Find the costume of the given mathItem"
	^ costumes 
		detect: [:costume | costume mathItem == aMathItem]
		ifFound: [ :costume | costume ]
		ifNone: [ nil]
]

{ #category : #costume }
DrGeo >> costumes [
	^costumes
]

{ #category : #costume }
DrGeo >> costumesOf: aMathItemCollection [
"Find the costumes of the given mathItem collection"
	^ aMathItemCollection collect: [:aMathItem | self costumeOf: aMathItem]

]

{ #category : #costume }
DrGeo >> deleteCostume: aCostume [
	aCostume release.
	undoneCostumes add: aCostume.
	costumes := costumes copyWithout: aCostume.
	
]

{ #category : #accessing }
DrGeo >> domain [
	^domain 
]

{ #category : #accessing }
DrGeo >> domain: aDomain [
	domain := aDomain 
]

{ #category : #costume }
DrGeo >> fastLastCostume [
"Find the costume of the factory last mathItem"
	^ lastCostume 
]

{ #category : #costume }
DrGeo >> forceVisible: aBoolean [
"Force or not the visibility of hidden costume"
	aBoolean ifTrue: [self redrawCostumes. self area changed ].
	costumes do: [:costume |
		costume forceVisible: aBoolean].
]

{ #category : #accessing }
DrGeo >> fullScreen [ 
	view fullscreen 
]

{ #category : #costume }
DrGeo >> groupCostumes: aCompositeItem [ 
|compositeCostume subCostumes|
	subCostumes := OrderedCollection new.
	aCompositeItem subItems do: [:item |
		self remove: (subCostumes add: (self costumeOf: item))].
	compositeCostume := DrGCompositeCostume 
		for: aCompositeItem 
		in: self area 
		with: subCostumes .
	self add: compositeCostume.

]

{ #category : #initialize-release }
DrGeo >> initialize [
	super initialize.
	costumes := OrderedCollection new.
	undoneCostumes := OrderedCollection new.
	notInteractive := false.
	saved := true. "because empty at initialize, no save is needed, so we marked as saved"
	self registerEvents
]

{ #category : #initialize-release }
DrGeo >> initializeApplication [
	self initializeApplication: nil
]

{ #category : #initialize-release }
DrGeo >> initializeApplication: controlsManager [
	self initialize.
	self buildViewAndOpen: controlsManager
]

{ #category : #initialize-release }
DrGeo >> initializeApplicationToolbarless [
	self initialize.
	self toolbarless: true.
	self buildViewAndOpen: nil
]

{ #category : #initialize-release }
DrGeo >> initializeService [
	self initialize.
	presenter := DrGeoPresenter for: self.
	view := DrGService for: self.
]

{ #category : #testing }
DrGeo >> isNotInteractive [
	^ notInteractive
]

{ #category : #testing }
DrGeo >> isSaved [
	^ saved
]

{ #category : #testing }
DrGeo >> isToolbarless [
	^ toolbarless ifNil: [toolbarless := false]
]

{ #category : #costume }
DrGeo >> lastCostume [
"Find the costume of the factory last mathItem"
|lastMathItem costume|
	costume := costumes last.
	costume mathItem = domain factory last ifTrue: [^costume].
	lastMathItem := domain factory last.
	costumes do: [:aCostume|
		aCostume mathItem = lastMathItem ifTrue: [^aCostume]].
	^nil

]

{ #category : #accessing }
DrGeo >> notInteractive: boolean [
	notInteractive := boolean
]

{ #category : #costume }
DrGeo >> pointCostumeClosestTo: aPoint atRange: anInteger [
|closestCostume smallestDistance|
	smallestDistance := anInteger. 
	costumes do: [:aCostume | | dist |
		(aCostume isPointCostume and: [(dist := aCostume distanceTo: aPoint)< smallestDistance])
			ifTrue:
				[closestCostume := aCostume.
				smallestDistance := dist]].
	^closestCostume 
]

{ #category : #costume }
DrGeo >> pointCostumes [
	^ costumes select: [:aCostume | 
		aCostume isPointCostume]

]

{ #category : #accessing }
DrGeo >> presenter [
	^presenter 
]

{ #category : #canvas }
DrGeo >> preview [
"compute an PNG preiview and put it in a stream"
	|form scale stream|
	form := (Form extent: self area extent depth: 32) fillWhite.
	self area owner athensSurface displayOnMorphicCanvas: form getCanvas at: 0 @ 0.	
	scale := self previewSize x / form width min: self previewSize y / form height.
	form := form magnify: form boundingBox by: scale smoothing: 3.
	stream := ByteArray new writeStream.
	PNGReadWriter putForm: form onStream: stream.
	^ stream
]

{ #category : #canvas }
DrGeo >> previewSize [
	^ DrGeo previewSize
]

{ #category : #costume }
DrGeo >> recoverCostume: aMathItem [ 
	"a redo math item event : a math item has been recalled, find its
	costume "
	| costume |
	costume := self undoneCostumeOf: aMathItem.
	costume
		ifNil: [self costume: aMathItem]
		ifNotNil: [costume mathItem: aMathItem.
			costume reInitialize.
			undoneCostumes := undoneCostumes copyWithout: costume.
			self add: costume]
]

{ #category : #costume }
DrGeo >> redrawCostumes [
	"View resized, update the area"

	costumes do: [ :costume | costume redraw ].
	self presenter tool ifNotNil: [ :aTool | aTool redrawFlyingCostume ].
	self updateGrid
]

{ #category : #initialize-release }
DrGeo >> registerEvents [
	domain
		when: #redoMathItem
		send: #recoverCostume:
		to: self.
	domain
		when: #newMathItem
		send: #costume:
		to: self.
	domain
		when: #updatedItems
		send: #updateCostumes
		to: self.
	domain
		when: #updatedDirtyItems
		send: #updateDirtyCostumes
		to: self.
	domain
		when: #groupCostumes
		send: #groupCostumes:
		to: self.
	domain
		when: #ungroupCostumes
		send: #ungroupCostumes:
		to: self
]

{ #category : #initialize-release }
DrGeo >> release [
	super release.
	self area release.
	self removeEvents.
	presenter release.
	view release.
	view:= nil.
	presenter := nil
]

{ #category : #costume }
DrGeo >> remove: aCostume [
	aCostume ifNotNil:
	 [costumes remove: aCostume].
]

{ #category : #initialize-release }
DrGeo >> removeEvents [
	domain removeActionsWithReceiver: self.
]

{ #category : #'objects from disk' }
DrGeo >> saveAs: filename [ 
	DrGeoXml new
		app: self;
		saveAs: filename.
	self saved: true
]

{ #category : #'objects from disk' }
DrGeo >> saveOn: stream [
	DrGeoXml new
		app: self;
		saveOn: stream.
	self saved: true
]

{ #category : #accessing }
DrGeo >> saved: bool [
	| title |
	title := view title.
	(bool and: [ saved not ]) ifTrue: [view title: (title allButFirst: 2)].
	(bool not and: [saved]) ifTrue: [view title: '* ', title].
	saved := bool.

]

{ #category : #canvas }
DrGeo >> scale [
	self error: 'Implemented in the drawable'
]

{ #category : #accessing }
DrGeo >> title [
	^ view 
		ifNotNil: [ | title | 
			title := view title.
			self isSaved 
				ifFalse: [title allButFirst: 2] 
				ifTrue: [ title ]]
		ifNil: ['no name']
]

{ #category : #accessing }
DrGeo >> toolbarless: boolean [
	toolbarless := boolean 
]

{ #category : #costume }
DrGeo >> undoneCostumeOf: aMathItem [
"Find the costume of the given mathItem if any"
	^ undoneCostumes 
		detect: [:costume | costume mathItem == aMathItem]
		ifFound: [:costume | costume ]
		ifNone: [ nil ]

]

{ #category : #costume }
DrGeo >> ungroupCostumes: aCompositeItem [ 
|compositeCostume |
	compositeCostume := self costumeOf: aCompositeItem.
	compositeCostume subCostumes do: [:aCostume |
		self add: aCostume].
	self remove: compositeCostume.

]

{ #category : #costume }
DrGeo >> updateCostumes [
	costumes do: [ :each | each update ]
]

{ #category : #costume }
DrGeo >> updateDirtyCostumes [
	self presenter tool costumes do: [ :each | each update ].
	self area changed
]

{ #category : #canvas }
DrGeo >> updateGrid [
	self area ifNotNil: [
		self area updateGrid.
		self area changed]
]

{ #category : #accessing }
DrGeo >> view [
	^ view
]
