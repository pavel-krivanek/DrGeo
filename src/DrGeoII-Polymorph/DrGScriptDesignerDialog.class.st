"
I am a dialog to design a DrGeo script: 
- its name
- its description
- its attributes types
"
Class {
	#name : #DrGScriptDesignerDialog,
	#superclass : #DialogWindow,
	#instVars : [
		'scriptName',
		'description',
		'scriptNameMorph',
		'descriptionMorph',
		'addArgumentButton',
		'argumentsMorph'
	],
	#category : #DrGeoII-Polymorph
}

{ #category : #'as yet unclassified' }
DrGScriptDesignerDialog class >> indexOfLabel: string [
	^ self labels indexOf: string
]

{ #category : #'as yet unclassified' }
DrGScriptDesignerDialog class >> labelToType [
	^ Dictionary newFrom: {
		'Any type' translated -> DrGMathItem.
		'Point' translated -> DrGPointItem.
		'Direction' translated -> DrGDirectionItem.
		'Line' translated -> DrGLineItem.
		'Ray' translated -> DrGRayItem.
		'Segment' translated -> DrGSegmentItem.
		'Polygon' translated -> DrGPolygonItem.
		'Vector' translated -> DrGVectorItem.
		'Circle' translated -> DrGCircleItem.
		'Arc' translated -> DrGArcItem.
		'Locus' translated -> DrGLocus2ptsItem.
		'Value' translated -> DrGValueItem.
		'Angle' translated -> DrGAngleItem}
]

{ #category : #'as yet unclassified' }
DrGScriptDesignerDialog class >> labels [
	^ self labelToType keys sorted
]

{ #category : #'as yet unclassified' }
DrGScriptDesignerDialog class >> typeToLabel [
	| dict |
	dict := Dictionary new.
	self labelToType associationsDo: [ :assoc | 
		dict add: assoc value -> assoc key ].
	^ dict
	
]

{ #category : #actions }
DrGScriptDesignerDialog >> addArgument [
"user just request for a new argument: add a del button and a droplist with the argument type the user can select"
	| button dropList alignment|
	alignment := AlignmentMorph newRow color: Color transparent; wrapCentering: #center; cellPositioning: #center.
	dropList := self newDropListFor: (ListModel new items: self class labels; setSelectedIndex: (self class indexOfLabel: 'Any type' translated))
		list: #getList
		getSelected: #selectedIndex
		setSelected: #setSelectedIndex:
		help: 'Select the type of this script argument.' translated.
	dropList minWidth: 80.
	button := self newButtonFor: self 
		getState: nil 
		action: #removeArgument: 
		arguments: {alignment} 
		getEnabled: nil
		labelForm: Smalltalk ui icons smallCancelIcon
		help: 'Remove this script argument.' translated.
	alignment addMorphBack: button; addMorphBack: dropList.
	argumentsMorph addMorph: alignment inFrontOf: addArgumentButton
	
]

{ #category : #accessing }
DrGScriptDesignerDialog >> arguments [ 
"The arguments as selected by the user"
|alignments|
	alignments := self argumentsMorph submorphs select: [ :morph | morph class = AlignmentMorph].
	^  alignments collect: [ :each | each submorphs second selectedItem].
	
]

{ #category : #accessing }
DrGScriptDesignerDialog >> argumentsMorph [
	^ argumentsMorph 
]

{ #category : #accessing }
DrGScriptDesignerDialog >> argumentsMorph: aMorph [
	argumentsMorph := aMorph 
]

{ #category : #accessing }
DrGScriptDesignerDialog >> argumentsType [
"The arguments type as selected by the user, tpye=class from the MathItem hierarchy"
|dict|
	dict := self class labelToType.
	^ self arguments collect: [:aLabel | dict at: aLabel]
]

{ #category : #'focus handling' }
DrGScriptDesignerDialog >> defaultFocusMorph [
	^ self scriptNameMorph textMorph
]

{ #category : #accessing }
DrGScriptDesignerDialog >> description [
	^ description
]

{ #category : #accessing }
DrGScriptDesignerDialog >> description: anObject [
	description := anObject.
	self changed: #description
]

{ #category : #accessing }
DrGScriptDesignerDialog >> descriptionMorph [
	^ descriptionMorph 
]

{ #category : #accessing }
DrGScriptDesignerDialog >> descriptionMorph: anObject [
	descriptionMorph := anObject
]

{ #category : #initialization }
DrGScriptDesignerDialog >> initialize [
	super initialize.
	self title: 'Build a new script' translated.
	self addCornerGrips.
]

{ #category : #testing }
DrGScriptDesignerDialog >> isValid [
"respond wheter the given input data is valid to build a script"
| name |
	name := self scriptNameMorph textMorph contents asString.
	name withBlanksCondensed isEmpty ifTrue: [ ^ false ].
	self descriptionMorph textMorph contents asString withBlanksCondensed isEmpty ifTrue: [ ^ false ].
	(Smalltalk hasClassNamed: #DrGeoScript, name hash printString) ifTrue: [ ^ false ].
	^ true
]

{ #category : #geometry }
DrGScriptDesignerDialog >> minimumExtent [
	^ 620@300
]

{ #category : #'instance creation' }
DrGScriptDesignerDialog >> newAddArgumentButton [
	^ self newButtonFor: self 
		getState: nil 
		action: #addArgument
		arguments: nil
		getEnabled: nil
		label: 'Add argument' translated
		help: 'Add an argument to this script.' translated.
]

{ #category : #'instance creation' }
DrGScriptDesignerDialog >> newArgumentsMorph [
	^ (AlignmentMorph inARow: {addArgumentButton := self newAddArgumentButton})
		borderWidth: 0;
		wrapDirection: #topToBottom;
		hResizing: #spaceFill;
		yourself.
]

{ #category : #'as yet unclassified' }
DrGScriptDesignerDialog >> newButtons [
	"Answer new buttons as appropriate."

	^{self newOKButton isDefault: false. self newCancelButton}
]

{ #category : #actions }
DrGScriptDesignerDialog >> newContentMorph [
	self scriptNameMorph: self newScriptNameMorph.
	self descriptionMorph: self newDescriptionMorph.
	self argumentsMorph: self newArgumentsMorph .
	^ self newLabelGroup: {
		'Name' translated -> self scriptNameMorph.
		'Description' translated -> self descriptionMorph.
		'Arguments' translated -> self argumentsMorph}
]

{ #category : #'instance creation' }
DrGScriptDesignerDialog >> newDescriptionMorph [
	^(self
		newTextEditorFor: self
		getText: #description
		setText: #description:
		getEnabled: nil)
		acceptOnCR: false;
		setBalloonText: 'A description of the script. To help the user, describe carefully what the script does and the input arguments to select to use it.' translated;
		changedAction: [:text | self changed: #isValid ];
		selectAll
]

{ #category : #'instance creation' }
DrGScriptDesignerDialog >> newOKButton [
	^ self newButtonFor: self
		getState: nil
		action: #ok
		arguments: nil
		getEnabled: #isValid
		label: 'Build' translated 
		help: 'Build a script with these settings.'
]

{ #category : #'instance creation' }
DrGScriptDesignerDialog >> newScriptNameMorph [
	^(self
		newTextEntryFor: self
		getText: #scriptName
		setText: #scriptName:
		getEnabled: nil
		help: 'The name of the script.' translated)
		acceptOnCR: false;
		changedAction: [:text | self changed: #isValid ];
		selectAll
]

{ #category : #actions }
DrGScriptDesignerDialog >> removeArgument: alignment [
	argumentsMorph removeMorph: alignment 
]

{ #category : #accessing }
DrGScriptDesignerDialog >> scriptName [
	^ scriptName
]

{ #category : #accessing }
DrGScriptDesignerDialog >> scriptName: anObject [
	scriptName := anObject.
	self changed: #scriptName.
	self scriptNameMorph selectAll
]

{ #category : #accessing }
DrGScriptDesignerDialog >> scriptNameMorph [
	^ scriptNameMorph 
]

{ #category : #accessing }
DrGScriptDesignerDialog >> scriptNameMorph: anObject [
	scriptNameMorph := anObject
]
