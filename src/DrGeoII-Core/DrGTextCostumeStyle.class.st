Class {
	#name : #DrGTextCostumeStyle,
	#superclass : #DrGCostumeStyle,
	#instVars : [
		'backgroundColor',
		'borderColor',
		'fontSize'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'as yet unclassified' }
DrGTextCostumeStyle class >> backgroundColorSymbols [
	^ OrderedCollection new
		add: #transparent;
		addAll: DrGStylePreference colorSymbols;
		yourself 
]

{ #category : #'as yet unclassified' }
DrGTextCostumeStyle class >> backgroundColors [
	^ self backgroundColorSymbols collect: [:symbol | Color perform: symbol]
]

{ #category : #accessing }
DrGTextCostumeStyle >> backgroundColor [
	^ backgroundColor 
]

{ #category : #accessing }
DrGTextCostumeStyle >> backgroundColor: aColor [
	backgroundColor := aColor.
	costume backgroundColor: aColor muchLighter.
	self changed
]

{ #category : #accessing }
DrGTextCostumeStyle >> backgroundColorIndex [
	^ self class backgroundColors indexOf: self baseBackgroundColor
	
]

{ #category : #accessing }
DrGTextCostumeStyle >> backgroundColorIndex: index [
	| aColor |
	aColor := Color perform: (self class backgroundColorSymbols at: index).
	self setTranslucent: aColor

]

{ #category : #widget }
DrGTextCostumeStyle >> backgroundMorphCollection [
	^ self class backgroundColors collect: [:aColor |
		(DrGIcons colorForm: aColor) asMorph]
]

{ #category : #widget }
DrGTextCostumeStyle >> backgroundWidget [
	^  'Background' translated ->
		((self view
			newMorphDropListFor: self 
			list: #backgroundMorphCollection
			getSelected: #backgroundColorIndex 
			setSelected: #backgroundColorIndex:
			help: 'Set the background colour.' translated) minWidth: DrGIcons menuExtent x+35)
]

{ #category : #accessing }
DrGTextCostumeStyle >> baseBackgroundColor [ 
"This color whithout transparency"
	^ backgroundColor isTransparent 
		ifFalse: [backgroundColor alpha: 1.0] 
		ifTrue: [backgroundColor]
]

{ #category : #accessing }
DrGTextCostumeStyle >> borderColor [
	^ borderColor 
]

{ #category : #accessing }
DrGTextCostumeStyle >> borderColor: aColor [
	borderColor := aColor.
	costume borderColor: aColor.
	self changed
]

{ #category : #accessing }
DrGTextCostumeStyle >> borderColorIndex [
	^ self class backgroundColors indexOf: borderColor
]

{ #category : #accessing }
DrGTextCostumeStyle >> borderColorIndex: index [
	| aColor |
	aColor := Color perform: (self class backgroundColorSymbols at: index).
	self borderColor: aColor

]

{ #category : #widget }
DrGTextCostumeStyle >> borderWidget [
	^  'Border' translated ->
		((self view
			newMorphDropListFor: self 
			list: #backgroundMorphCollection
			getSelected: #borderColorIndex 
			setSelected: #borderColorIndex:
			help: 'Set the border colour.' translated) minWidth: DrGIcons menuExtent x+35)
]

{ #category : #accessing }
DrGTextCostumeStyle >> fontSize: integer [
	fontSize := integer.
	costume fontSize: integer.
	self changed
]

{ #category : #accessing }
DrGTextCostumeStyle >> fontSizeIndex [
	^ self fontSizes indexOf: fontSize
	
]

{ #category : #accessing }
DrGTextCostumeStyle >> fontSizeIndex: index [
	self fontSize: (self fontSizes at: index)

]

{ #category : #widget }
DrGTextCostumeStyle >> fontSizeWidget [
	^  'Font size' translated ->
		((self view
			newDropListFor: self 
			list: #fontSizes
			getSelected: #fontSizeIndex 
			setSelected: #fontSizeIndex:
			help: 'Set the font size.' translated) minWidth: DrGIcons menuExtent x+35)
]

{ #category : #accessing }
DrGTextCostumeStyle >> fontSizes [
	^#(9 10 12 14 16)
]

{ #category : #initialize-release }
DrGTextCostumeStyle >> initialize [ 
	super initialize.
	self color: DrGStylePreference current textColor.
	self backgroundColor: DrGStylePreference current textBackgroundColor.
	self borderColor: DrGStylePreference current textBorderColor.
	fontSize := DrGDefault canvasFontSize.
]

{ #category : #accessing }
DrGTextCostumeStyle >> setTranslucent: aColor [
	aColor isTransparent 
		ifFalse: [self backgroundColor: (aColor alpha: "0.3" 1)] 
		ifTrue: [self backgroundColor:" aColor" Color white]

]

{ #category : #widget }
DrGTextCostumeStyle >> styleWidget [
| controls |
	controls := 	OrderedCollection new
		add: self fontSizeWidget;
		add: self colorWidget;
		add: self backgroundWidget;
		add: self borderWidget;
		yourself.
	controls addAll: self myWidgets.
	controls add: self feedbackWidget. 
	controls add: self hiddenWidget.
	costume isLockable ifTrue: [controls add: self lockedWidget].
	^ (self view newLabelGroup: controls) layoutInset: 4
]

{ #category : #'xml writing' }
DrGTextCostumeStyle >> writeAttributesTo: aNode [
	super writeAttributesTo: aNode.
	aNode attributeAt: #background put: self baseBackgroundColor name asString capitalized.
	aNode attributeAt: #border put: self borderColor name asString capitalized.
	aNode attributeAt: #fontSize put: fontSize asString
]
