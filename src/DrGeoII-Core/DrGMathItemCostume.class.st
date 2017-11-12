"
This is the root of the costumue hierarchy, a simple Adapter to morph.
A costume is a visual representation of a mathItem. The user interact with the mathItem through its costume.
 mathItem 		- a costume need to know its model
 dirty 			- boolean, true if it need udpate (repositionned) (deprecated)
 morph 			- this the adaptee, the graphic representation
 textMorph     - to display the object name, may be nil
 drawable 		- a costume need to know where it is printed
 exist 		   - does the costume exist (ie when its mathItem does or not exist, we need it to keep track when the mathItem exist changed)

"
Class {
	#name : #DrGMathItemCostume,
	#superclass : #Object,
	#instVars : [
		'mathItem',
		'morph',
		'textMorph',
		'textPositionDelta',
		'drawable',
		'exist',
		'style'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'as yet unclassified' }
DrGMathItemCostume class >> basicNew: mathItem [
	^ self basicNew 
]

{ #category : #'instance creation' }
DrGMathItemCostume class >> for: aMathItem in: aDrawable [
	^ (aMathItem costumeClass basicNew: aMathItem)
		drawable: aDrawable;
		mathItem: aMathItem;
		initialize.
]

{ #category : #initialize-release }
DrGMathItemCostume >> addMyMorph [
	exist ifTrue: [
		self isBitmapCostume 
			ifTrue: [drawable addMorphBack: self morph]
			ifFalse: [drawable addMorph: self morph]].
]

{ #category : #accessing }
DrGMathItemCostume >> app [
	^ self drawable app
]

{ #category : #converting }
DrGMathItemCostume >> asString [
	^ mathItem 
		ifNil: ['nil']
		ifNotNil: [mathItem descriptiveName] 
]

{ #category : #testing }
DrGMathItemCostume >> basicType [
	super basicType 
]

{ #category : #accessing }
DrGMathItemCostume >> borderColor: aColor [
	
]

{ #category : #accessing }
DrGMathItemCostume >> color: aColor [
	morph color: aColor 
]

{ #category : #layout }
DrGMathItemCostume >> computeTextPositionDelta: aVector [
|distance|
	textMorph ifNil: [^0@0].
	aVector = (0@0) 
		ifFalse:
			[distance := aVector r.
			distance > 40 ifTrue: [distance := 40].
			^(aVector / aVector r) * distance +
				(textMorph  fullBounds origin - textMorph fullBounds center)]
		ifTrue:
			[^textMorph  fullBounds origin - textMorph fullBounds center].
	
]

{ #category : #layout }
DrGMathItemCostume >> constraintTextPosition: aPoint [
"Force the text arround the mathItemCostume to a position"
	self subclassResponsibility 
]

{ #category : #testing }
DrGMathItemCostume >> containsPoint: aPoint [
	^exist and: [morph visible and: [morph containsPoint: aPoint]]
]

{ #category : #updating }
DrGMathItemCostume >> dash: aDashMotif [
	morph dashedBorder: aDashMotif
]

{ #category : #accessing }
DrGMathItemCostume >> domain [
	^drawable presenter domain
]

{ #category : #accessing }
DrGMathItemCostume >> drawable [
	^drawable
]

{ #category : #accessing }
DrGMathItemCostume >> drawable: aDrawable [
	drawable := aDrawable 
]

{ #category : #updating }
DrGMathItemCostume >> editMyProperty [ 
	self subclassResponsibility 
]

{ #category : #updating }
DrGMathItemCostume >> emphasis [
	morph borderWidth: 8.
	morph color: Color LightRed
]

{ #category : #accessing }
DrGMathItemCostume >> exist [
	^exist
]

{ #category : #accessing }
DrGMathItemCostume >> exist: aBoolean [
	exist := aBoolean 
]

{ #category : #updating }
DrGMathItemCostume >> forceVisible: aBoolean [ 
	(exist not or: [style isNotHidden]) ifTrue: [^false].
	aBoolean 
		ifTrue: 
			[self addMyMorph.
			self redraw.
			morph color: DrGStylePreference hiddenColor.
			textMorph ifNotNil:
				[drawable addMorph: textMorph.
				textMorph position: self textPosition]]
		ifFalse: 
			[drawable removeMorph: morph.
			morph color: style color.
			textMorph ifNotNil:
				[drawable removeMorph: textMorph]].
	^true
]

{ #category : #initialize-release }
DrGMathItemCostume >> initialize [
	"costume should update itself regarding its model (mathItem)"
	self instantiateMorph.
	textPositionDelta := 7 @ 7.
	self morph costume: self.
	exist := mathItem exist.
	self style: (self styleClass newWith: self).
	self addMyMorph.
	self redraw
]

{ #category : #initialize-release }
DrGMathItemCostume >> instantiateMorph [
	self subclassResponsibility 
]

{ #category : #testing }
DrGMathItemCostume >> isAngleCostume [
	^self basicType = #angle
]

{ #category : #testing }
DrGMathItemCostume >> isArcCostume [
	^self basicType = #arc
]

{ #category : #testing }
DrGMathItemCostume >> isBitmapCostume [
	^self basicType = #bitmap
]

{ #category : #testing }
DrGMathItemCostume >> isCircleCostume [
	^self basicType = #circle
]

{ #category : #testing }
DrGMathItemCostume >> isCompositeCostume [
	^self basicType = #composite
]

{ #category : #testing }
DrGMathItemCostume >> isCurveCostume [
	^false
]

{ #category : #testing }
DrGMathItemCostume >> isFinitCurveCostume [
	^self isArcCostume 
		or: [self isCircleCostume
			or: [self isSegmentCostume]]

]

{ #category : #testing }
DrGMathItemCostume >> isForceVisible [
	^ drawable presenter isForceVisible 
]

{ #category : #testing }
DrGMathItemCostume >> isLineCostume [
	^self basicType = #line
]

{ #category : #testing }
DrGMathItemCostume >> isLockable [
	^ mathItem isLockable
]

{ #category : #testing }
DrGMathItemCostume >> isLocked [
	^ mathItem isLocked
]

{ #category : #testing }
DrGMathItemCostume >> isLocusCostume [
	^self basicType = #locus
]

{ #category : #testing }
DrGMathItemCostume >> isPointCostume [
	^self basicType = #point
]

{ #category : #testing }
DrGMathItemCostume >> isRayCostume [
	^self basicType = #ray
]

{ #category : #testing }
DrGMathItemCostume >> isSegmentCostume [
	^self basicType = #segment
]

{ #category : #testing }
DrGMathItemCostume >> isValueCostume [
	^self basicType = #value or: [self basicType = #angle]
]

{ #category : #testing }
DrGMathItemCostume >> isVectorCostume [
	^self basicType = #vector
]

{ #category : #accessing }
DrGMathItemCostume >> locked [
	^ mathItem isLocked
]

{ #category : #accessing }
DrGMathItemCostume >> locked: boolean [
	self isLockable ifTrue: [
		mathItem locked: boolean.
		self update: nil.]
]

{ #category : #updating }
DrGMathItemCostume >> makeBackArrow [
	morph makeBackArrow
]

{ #category : #updating }
DrGMathItemCostume >> makeBothArrows [
	morph makeBothArrows
]

{ #category : #updating }
DrGMathItemCostume >> makeForwardArrow [
	morph makeForwardArrow
]

{ #category : #updating }
DrGMathItemCostume >> makeNoArrows [
	morph makeNoArrows
]

{ #category : #accessing }
DrGMathItemCostume >> mathItem [
	^mathItem 
]

{ #category : #accessing }
DrGMathItemCostume >> mathItem: aMathItem [
	self removeEvents.
	mathItem := aMathItem.
	self registerEvents.
]

{ #category : #accessing }
DrGMathItemCostume >> morph [
	^morph 
]

{ #category : #accessing }
DrGMathItemCostume >> morph: aMorph [
	morph := aMorph 
]

{ #category : #accessing }
DrGMathItemCostume >> name [
	^textMorph ifNotNil: [textMorph contents asString]
		ifNil: ['']
]

{ #category : #scripting }
DrGMathItemCostume >> openViewer [
	morph ifNotNil: [morph beViewed]
]

{ #category : #accessing }
DrGMathItemCostume >> presenter [
	^drawable presenter
]

{ #category : #initialize-release }
DrGMathItemCostume >> reInitialize [
	"we recover from an undo operation, so let's reInitialize some of my
	aspect "
	self registerEvents.
	self addMyMorph.
	self redraw.
	self textMorph: mathItem name.
	self forceVisible: false
]

{ #category : #updating }
DrGMathItemCostume >> redraw [
	(exist and: [style isNotHidden or: [self isForceVisible]]) ifFalse: [^ false].
	textMorph
		ifNotNil: [textMorph position: self textPosition].
	^ true
]

{ #category : #initialize-release }
DrGMathItemCostume >> registerEvents [
	mathItem
		ifNotNil: [
			mathItem
				when: #deletedMathItem
				send: #deleteCostume:
				to: drawable app
				with: self.
			mathItem 
				when: #updateMyView
				send: #updateAllMathItems
				to: self domain]
]

{ #category : #initialize-release }
DrGMathItemCostume >> release [
	super release.
	self morph ifNotNil: [self removeMyMorph.].
	self removeTextMorph.
	self removeEvents.
	style release
]

{ #category : #initialize-release }
DrGMathItemCostume >> releasePropertyWidget [ 

]

{ #category : #initialize-release }
DrGMathItemCostume >> removeEvents [
	mathItem ifNotNil: 
		[mathItem removeActionsWithReceiver: self].
	self breakDependents 
]

{ #category : #initialize-release }
DrGMathItemCostume >> removeMyMorph [
	drawable removeMorph: morph
]

{ #category : #initialize-release }
DrGMathItemCostume >> removeTextMorph [
	textMorph ifNotNil:
		[drawable removeMorph: textMorph.
		textMorph := nil]
]

{ #category : #updating }
DrGMathItemCostume >> startBlinking [
	morph startBlinking
]

{ #category : #updating }
DrGMathItemCostume >> stopBlinking [
	morph stopBlinking
]

{ #category : #accessing }
DrGMathItemCostume >> style [
	^style
]

{ #category : #accessing }
DrGMathItemCostume >> style: aStyle [
	style := aStyle 
]

{ #category : #style }
DrGMathItemCostume >> styleClass [
	^DrGCostumeStyle
]

{ #category : #accessing }
DrGMathItemCostume >> textMorph [
	^textMorph
]

{ #category : #accessing }
DrGMathItemCostume >> textMorph: aString [
	aString ifNil: [^self].
	mathItem name: aString.
	aString size = 0
		ifTrue: 
			[textMorph ifNotNil: [self removeTextMorph]]
		ifFalse:
			[textMorph 
				ifNil: 
					[textMorph := DrGLabelMorph new contents: aString.
					textMorph costume: self.
					exist ifTrue: [drawable addMorph: textMorph.
					textMorph position: self textPosition]]
				ifNotNil: 
					[textMorph contents: aString]].
	self update: nil.
]

{ #category : #layout }
DrGMathItemCostume >> textPosition [
"get an up to date text position"
	self subclassResponsibility
]

{ #category : #accessing }
DrGMathItemCostume >> textPositionDelta: aPoint [
	textPositionDelta := aPoint
]

{ #category : #updating }
DrGMathItemCostume >> toggleLocked [
	self isLockable ifTrue: [
		mathItem locked: mathItem isLocked not]
]

{ #category : #updating }
DrGMathItemCostume >> unhide [
 "make this costume visible in case it was hidden"
	style isHidden ifTrue: [
		self forceVisible: true.
		style hidden: false]
]

{ #category : #updating }
DrGMathItemCostume >> update [
	mathItem exist
		ifTrue: [
			exist ifFalse: [self updateToVisible].
			self redraw]
		ifFalse: [exist ifTrue: [self updateToInvisible]].
]

{ #category : #updating }
DrGMathItemCostume >> update: object [
	self app saved: false.
	morph changed
]

{ #category : #updating }
DrGMathItemCostume >> updateToInvisible [
	self removeMyMorph.
	textMorph ifNotNil:
		[drawable removeMorph: textMorph].
	exist := false
]

{ #category : #updating }
DrGMathItemCostume >> updateToVisible [
	exist := true.
	style isNotHidden 
		ifTrue: [self addMyMorph].
	textMorph ifNotNil:
		[drawable addMorph: textMorph.
		textMorph position: self textPosition].
]

{ #category : #accessing }
DrGMathItemCostume >> view [
	^drawable view
]

{ #category : #updating }
DrGMathItemCostume >> width: anInteger [
	morph borderWidth: anInteger
]

{ #category : #'xml writing' }
DrGMathItemCostume >> writeAsXmlTo: aNode [ 
	"We wrote from the costume because it knows both the model and the
	view of the math item"
	self writeAttributesTo: (mathItem writeAsXmlTo: aNode)
]

{ #category : #'xml writing' }
DrGMathItemCostume >> writeAttributesTo: aNode [ 
	aNode	attributeAt: #delta put: textPositionDelta asString.
	self isLockable ifTrue: [
		aNode attributeAt: #locked put: mathItem isLocked asString capitalized].
	style writeAttributesTo: aNode.

]
