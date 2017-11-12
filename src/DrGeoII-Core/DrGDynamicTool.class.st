"
The root of the class hierarchy to handle tool

 state 					- 	state of the tool
 presenter 				- 	from which presenter is used this tool
 spot 					- 	xy-postition of the selected item when selecting one among several
 last 					- 	last mouse xy-position (used during drag)
 costume 				- 	selected costume during the last multiple choice selection
 mathItemUnderMouse 	- 	mathItem under mouse
 
"
Class {
	#name : #DrGDynamicTool,
	#superclass : #Object,
	#instVars : [
		'state',
		'presenter',
		'spot',
		'last',
		'costume',
		'mathItemUnderMouse'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGDynamicTool >> app [ 
	^presenter app
]

{ #category : #accessing }
DrGDynamicTool >> area [ 
	^presenter area
]

{ #category : #handling }
DrGDynamicTool >> chooseCostume: costumes [ 
	^ self chooseCostume: costumes title: 'Select an object' translated.
]

{ #category : #handling }
DrGDynamicTool >> chooseCostume: costumes title: aTitle [
	| aChoice |
	aChoice := DrGCanvasMenuMorph
		chooseFrom: costumes
		lines: #()
		title: aTitle.
	aChoice isZero
		ifTrue: [^ self handleChoice: {}].
	^ self handleChoice: {costumes at: aChoice}
]

{ #category : #accessing }
DrGDynamicTool >> costume [
	^costume 
]

{ #category : #accessing }
DrGDynamicTool >> costume: aCostume [
	costume ifNotNil: [costume stopBlinking].
	costume := aCostume.
	costume ifNotNil: [costume startBlinking]
	
]

{ #category : #accessing }
DrGDynamicTool >> costumesAt: aPoint [
"return the list of costume at position aPoint relevant to me, override if needed"
	^self myCostumesAt: aPoint 
]

{ #category : #accessing }
DrGDynamicTool >> description [ 
	^ self subclassResponsibility
]

{ #category : #accessing }
DrGDynamicTool >> domain [ 
	^presenter domain
]

{ #category : #accessing }
DrGDynamicTool >> factory [  
	^self domain factory
]

{ #category : #updating }
DrGDynamicTool >> gridPoint: ungriddedPoint [
	^ self area gridPoint: ungriddedPoint.
]

{ #category : #handling }
DrGDynamicTool >> handleChoice: aCostumeCollection [
	^ self state handleChoice: aCostumeCollection 
]

{ #category : #handling }
DrGDynamicTool >> handleMouseAt: aPoint [
	^self state handleMouseAt: aPoint
]

{ #category : #handling }
DrGDynamicTool >> handlePress: aPoint [
	^self state handlePress: aPoint 
]

{ #category : #handling }
DrGDynamicTool >> handlePressShiftKey: aPoint [
	^self state handlePressShiftKey: aPoint 
]

{ #category : #handling }
DrGDynamicTool >> handleRelease: aPoint [
	self state handleRelease: aPoint 
]

{ #category : #handling }
DrGDynamicTool >> handleReleaseShiftKey: aPoint [
	self state handleReleaseShiftKey: aPoint 
]

{ #category : #handling }
DrGDynamicTool >> handleShiftKey: aPoint [
	^self state handleShiftKey: aPoint 
]

{ #category : #handling }
DrGDynamicTool >> handleShiftKeyMouseAt: aPoint [
	^self state handleShiftKeyMouseAt: aPoint
]

{ #category : #handling }
DrGDynamicTool >> handleStillPress: aPoint [
	self state handleStillPress: aPoint
]

{ #category : #initialize-release }
DrGDynamicTool >> initialize [
	costume := nil.
	self last: 0@0.
]

{ #category : #testing }
DrGDynamicTool >> isCloning [
	^ false
]

{ #category : #testing }
DrGDynamicTool >> isGridded [
	^presenter isGridded
]

{ #category : #testing }
DrGDynamicTool >> isWanted: aMathItem [
	^true
]

{ #category : #accessing }
DrGDynamicTool >> last [
	^last
]

{ #category : #accessing }
DrGDynamicTool >> last: aPoint [
	last := aPoint
]

{ #category : #accessing }
DrGDynamicTool >> mathItem [
	^self costume mathItem
]

{ #category : #private }
DrGDynamicTool >> myCostumesAt: aPoint [
"return the list of costume at position aPoint"
	^self app costumes select: [:aCostume | 
		aCostume style isNotHidden 
			and: [(self isWanted: {aCostume mathItem})
				and: [aCostume containsPoint: aPoint]]]
]

{ #category : #private }
DrGDynamicTool >> pointCostumesAt: aPoint [ 
	"List of point under the mouse cursor"
	| myCostumes |
	myCostumes := self myCostumesAt: aPoint.
	^ myCostumes select: [:aCostume | aCostume isPointCostume].
]

{ #category : #private }
DrGDynamicTool >> pointCostumesFirstAt: aPoint [ 
	"When the user moves the mouse over a collection of geometric items, if there
are any point items, we discard all the other geometric items"
	| myCostumes pointCostumes |
	myCostumes := self myCostumesAt: aPoint.
	pointCostumes := myCostumes select: [:aCostume | aCostume isPointCostume].
	pointCostumes ifNotEmpty: [ ^ pointCostumes ].
	^ myCostumes
]

{ #category : #accessing }
DrGDynamicTool >> presenter [
	^presenter 
]

{ #category : #accessing }
DrGDynamicTool >> presenter: aPresenter [
	presenter := aPresenter 
]

{ #category : #updating }
DrGDynamicTool >> redrawFlyingCostume [
]

{ #category : #initialize-release }
DrGDynamicTool >> registerDependant: anObject [
]

{ #category : #initialize-release }
DrGDynamicTool >> release [
	super release.
	self reset.
]

{ #category : #initialize-release }
DrGDynamicTool >> reset [
	self costume: nil;
		last: nil;
		spot: nil.
	mathItemUnderMouse := nil
]

{ #category : #initialize-release }
DrGDynamicTool >> resetForFreshStart [ 
	self reset.
]

{ #category : #accessing }
DrGDynamicTool >> spot [
	^spot
]

{ #category : #accessing }
DrGDynamicTool >> spot: aPoint [
	spot := aPoint 
]

{ #category : #accessing }
DrGDynamicTool >> state [
	^state
]

{ #category : #accessing }
DrGDynamicTool >> state: aState [
	state :=	aState 
]

{ #category : #updating }
DrGDynamicTool >> switchState: aStateClass [
	self state: (aStateClass new context: self)
]
