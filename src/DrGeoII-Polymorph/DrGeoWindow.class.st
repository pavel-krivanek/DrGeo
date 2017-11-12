"
A DrGeoWindow is xxxxxxxxx.

Instance Variables
	app:		<Object>
	area:		<Object>
	curveToolbar:		<Object>
	macroToolbar:		<Object>
	miscToolbar:		<Object>
	numericToolbar:		<Object>
	pointToolbar:		<Object>
	statusbar:		<Object>
	toolbars:		<Object>
	transformationToolbar:		<Object>
	sideContainer:	a row alignement morph


sideContainer 
	- holds in a row the drawing area and the toolbox to edit object attributes

app
	- xxxxx

area
	- the drawing area

curveToolbar
	- xxxxx

macroToolbar
	- xxxxx

miscToolbar
	- xxxxx

numericToolbar
	- xxxxx

pointToolbar
	- xxxxx

statusbar
	- xxxxx

toolbars
	- xxxxx

transformationToolbar
	- xxxxx

"
Class {
	#name : #DrGeoWindow,
	#superclass : #StandardWindow,
	#instVars : [
		'app',
		'area',
		'statusbar',
		'sideContainer',
		'macroMenu',
		'scriptMenu',
		'tree'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #initialize-release }
DrGeoWindow class >> for: aDrGeo [ 
	"A new model with an existing domain. For multiple MVP on a same
	Domain "
	^ super basicNew app: aDrGeo;
		 initialize
]

{ #category : #accessing }
DrGeoWindow >> app [ 
	^ app 
]

{ #category : #accessing }
DrGeoWindow >> app: aDrgeo [
	app := aDrgeo
]

{ #category : #accessing }
DrGeoWindow >> area [
	^ area
]

{ #category : #accessing }
DrGeoWindow >> controls [ 
	^ self presenter controlsManager
]

{ #category : #open/close }
DrGeoWindow >> delete [
	(app notNil and: [app isSaved not]) ifTrue: [
		(self 
			questionWithoutCancel: 'Are you sure to close this sketch?' translated 
			title: 'Closing sketch' translated) ifFalse: [ ^ self ]].
	super delete.
	app ifNotNil: [app release]
]

{ #category : #open/close }
DrGeoWindow >> deleteWithoutConfirmation [
	super delete.
	app release 
]

{ #category : #accessing }
DrGeoWindow >> domain [
	^ app domain 
]

{ #category : #services }
DrGeoWindow >> fileOpen: title extensions: exts path: path preview: preview [
	"Answer the result of a file open dialog with the given title, extensions to show, path and preview type."
	|fd|
	fd := DrGFileDialog basicNew
		previewType: preview;
		initialize;
		title: title;
		answerOpenFile.
	exts ifNotNil: [fd validExtensions: exts].
	path ifNotNil: [fd selectPathName: path].
	^ [(self openModal: fd) answer] 
		on: Error
		do: [fd answer]

]

{ #category : #initialization }
DrGeoWindow >> initialize [
	super initialize.
	self model: self domain.
	self setLabel: 'Dr. Geo --  ' , Date today yyyymmdd.
	area := DrGDrawable newOn: app.
	self setProperty: #morphicLayerNumber toValue: 110.
]

{ #category : #testing }
DrGeoWindow >> isApplication [ 
	^true
]

{ #category : #testing }
DrGeoWindow >> isService [
	^false
]

{ #category : #accessing }
DrGeoWindow >> macroMenu [
	^ macroMenu
]

{ #category : #accessing }
DrGeoWindow >> macroMenu: aMenu [
	macroMenu := aMenu 
]

{ #category : #'*DrGeoII-Polymorph-Widgets' }
DrGeoWindow >> newTabGroupTool: labelsAndPages [
"Answer tab grouped tools with a the given tab labels associated with pages of tools"
	^(TabGroupToolMorph new
		font: self theme labelFont;
		cornerStyle: (self theme tabGroupCornerStyleIn: self);
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		labelsAndPages: labelsAndPages)
		selectedPageIndex: (labelsAndPages isEmpty ifTrue: [0] ifFalse: [1])
]

{ #category : #'*DrGeoII-Polymorph-Widgets' }
DrGeoWindow >> newTable: controls [
"Answer a morph laid out with a table of controls, in row and wrapped in column."
	|answer|
	answer := PanelMorph new
		changeTableLayout;
		cellInset: 2;
		listDirection: #leftToRight;
		wrapDirection: #topToBottom;
		hResizing: #spaceFill;
		vResizing: #shrinkWrap;
		fillStyle: Color transparent; "non pane color tracking"
		cellPositioning: #topLeft.
	controls do: [:m | answer addMorphBack: m].
	^answer
			
]

{ #category : #'*DrGeoII-Polymorph-Widgets' }
DrGeoWindow >> openModal: aSystemWindow [
	DrGDefault ifTablet: [
		aSystemWindow 
			extent: aSystemWindow initialExtent;
			topCentered;
			activate].
	^ super openModal: aSystemWindow.
]

{ #category : #menus }
DrGeoWindow >> popupMenu [ 
"we don't want the popup menu when using the rich UI"
]

{ #category : #accessing }
DrGeoWindow >> presenter [ 
	^ app presenter
]

{ #category : #'as yet unclassified' }
DrGeoWindow >> relabel [
	| newLabel |
	newLabel := UIManager default 
		request: 'New title for this window' translated
		initialAnswer: app title.
	newLabel isEmptyOrNil ifTrue: [^self].
	app isSaved ifFalse: [ newLabel := '* ' , newLabel].
	self setLabel: newLabel.
]

{ #category : #initialization }
DrGeoWindow >> release [
	super release.
	self presenter ifNotNil: [self presenter removeActionsWithReceiver: self].
	area release.
	tree release.
	tree := area := nil.
	app := nil
]

{ #category : #accessing }
DrGeoWindow >> scriptMenu [
	^ scriptMenu
]

{ #category : #accessing }
DrGeoWindow >> scriptMenu: aMenu [
	scriptMenu := aMenu 
]

{ #category : #accessing }
DrGeoWindow >> setStyler: morph [
"set a morph to edit the style of an object, it can replace an existing one or add one such morph"
	sideContainer submorphsDo: [:aMorph|
			aMorph class ~= AthensWrapMorph  ifTrue: [sideContainer removeMorph: aMorph]].
	morph 
		ifNotNil: [
			morph hResizing: #shrinkWrap; vResizing: #spaceFill.
			sideContainer submorphs size = 1 ifTrue: [sideContainer addMorph: self newVerticalSeparator].
			sideContainer addMorph: morph.
			self updatePaneColors]
]

{ #category : #accessing }
DrGeoWindow >> sideContainer [
	^ sideContainer
]

{ #category : #accessing }
DrGeoWindow >> sideContainer: aMorph [
	sideContainer := aMorph
]

{ #category : #toolbars }
DrGeoWindow >> statusMessage: aString [
	self statusbar submorphs first 
		contentsWrapped: aString
]

{ #category : #toolbars }
DrGeoWindow >> statusbar [
	^ statusbar
		ifNil: [| statuslabel |
			statusbar := self newPanel
				cellPositioning: #topRight;
				layoutInset: 0;
				cellInset: 0.
			statuslabel := self newText: ''.
			statuslabel autoFit: false;
				wrapFlag: true;
				vResizing: #spaceFill;
				hResizing: #spaceFill.
"			statuslabel hasDropShadow: true;
				 shadowColor: Color gray;
				 shadowOffset: 1 @ 1."
			statusbar addMorphBack: statuslabel;
				vResizing: #shrinkWrap.
			statusbar]
]

{ #category : #stepping }
DrGeoWindow >> step [
	DrGDefault ifTablet: [
		"track device rotation"
		self fullscreen].
]

{ #category : #stepping }
DrGeoWindow >> stepTime [
	^ 1000

]

{ #category : #services }
DrGeoWindow >> textEditor: aStringOrText title: aString entryText: defaultEntryText [
|editor|
	"Answer the result of a text editor (multiline) dialog ( a string or nil if cancelled)
	with the given label and title."
	editor := TextEditorDialogWindow new
		textFont: self theme textFont;
		title: aString;
		text: aStringOrText;
		entryText: defaultEntryText;
		entryHeight: 150.
	DrGDefault ifTablet: [editor topCentered].
	^(self openModal: editor) entryText
]

{ #category : #services }
DrGeoWindow >> textEntry: aStringOrText title: aString xEntryText: xEntryText yEntryText: yEntryText [
	|dialog|
	dialog := CoordinatesEditorDialog new textFont: self theme textFont;
		title: aString; text: aStringOrText;
		xEntryText: xEntryText;	yEntryText: yEntryText.
	DrGDefault ifTablet: [dialog topCentered].
	"Open a text entry dialog."
	dialog := self openModal: dialog.
	^ {dialog xEntryText . dialog yEntryText}
]

{ #category : #accessing }
DrGeoWindow >> tree [
	^ tree
]

{ #category : #accessing }
DrGeoWindow >> tree: aTree [
	tree := aTree
]

{ #category : #stepping }
DrGeoWindow >> wantsSteps [
	^ DrGDefault isTablet
]

{ #category : #accessing }
DrGeoWindow >> wantsToBeTopmost [
	^ true
]
