"
start					- the position where start the dragging
mathItems                    - the mathItems impacted by the dragging operation
costumes                     - the costumes impacted by the draggin opration
builder 				- we have the clone builder, ready to serve, so we have to instantiate it.
"
Class {
	#name : #DrGSelectTool,
	#superclass : #DrGDynamicTool,
	#instVars : [
		'start',
		'mathItems',
		'costumes',
		'builder'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #documentation }
DrGSelectTool class >> description [
	^ 'Select and move an object.' translated
]

{ #category : #documentation }
DrGSelectTool class >> title [ 
	^ 'Select and Move' translated
]

{ #category : #accessing }
DrGSelectTool >> builder [
	^ builder
]

{ #category : #accessing }
DrGSelectTool >> costumes [
	^ costumes 
]

{ #category : #accessing }
DrGSelectTool >> costumesAt: aPoint [
	^ self pointCostumesFirstAt: aPoint
]

{ #category : #accessing }
DrGSelectTool >> description [
	^ self class description
]

{ #category : #updating }
DrGSelectTool >> grabClone: clone [
"We cloned! We want to grab the clone to let the user move it somewhere in the canvas"
	self costume: (self app costumeOf: clone).
	builder reset.
	self switchState: DrGSelectToolStateDragged.

]

{ #category : #initialize-release }
DrGSelectTool >> initialize [
	self reset.
	builder := DrGCloneBuilder new.
]

{ #category : #testing }
DrGSelectTool >> isCloning [
	^ builder readyToBuild 
]

{ #category : #accessing }
DrGSelectTool >> mathItems [ 
	^ mathItems 
]

{ #category : #accessing }
DrGSelectTool >> mutableCostumesAt: aPoint [
"select the costume we can mutate"
	^ (self costumesAt: aPoint) select: [:aCostume | |item|
		item := aCostume mathItem.
		item isFreePointOnPlaneItem 
			or: [(item isPointItemOnCurve and: [(self factory is: item parentWithTest: #isLocusItem) not])
				or: [item isIntersectionPointItem]]]
]

{ #category : #private }
DrGSelectTool >> myCostumesAt: aPoint [
"	Only costumes where feedback and action are wished, 
	not hidden, wanted and under mouse cursor"
	^self app costumes select: [:aCostume | 
		aCostume style isNotHidden 
			and: [(self isWanted: {aCostume mathItem})
			and: [aCostume containsPoint: aPoint]]]
]

{ #category : #'as yet unclassified' }
DrGSelectTool >> pointCostumeToMergeWithAt: aPoint [
"A collection of point we can merge with. Only free point on plane are merge-able, and the merger should not depend on the initial point as well"
	| dependents myCostumes |
	^ costume mathItem isFreePointOnPlaneItem 
		ifTrue: [
			dependents := self app domain factory dependentMathItem: costume mathItem.
			myCostumes := self pointCostumesAt: aPoint.
			myCostumes select: [:aCostume | aCostume mathItem  ~~ costume mathItem 
					and: [(dependents includes: aCostume mathItem) not]]]
		ifFalse: [#()]
]

{ #category : #initialize-release }
DrGSelectTool >> registerDependant: anObject [
	builder when: #readyToBuild send: #readyToBuildClone to: anObject
]

{ #category : #updating }
DrGSelectTool >> reset [
	super reset.
	start := nil.
	self switchState: DrGSelectToolStateNeutral.
	costumes := nil.
	mathItems := nil.
	builder ifNotNil: [builder reset].
]

{ #category : #accessing }
DrGSelectTool >> start [
	^start
]

{ #category : #accessing }
DrGSelectTool >> start: aPoint [
	start := aPoint 
]

{ #category : #accessing }
DrGSelectTool >> targetMutationCostumeAt: aPoint [
	"Only the relevant item as target to mute a point, in our case curve,
	We need to fine tune this target list"
	| curves intersectables |
	curves := (self myCostumesAt: aPoint) select: [:aCostume |
		aCostume mathItem isCurveItem 
		and: [self domain factory is: aCostume mathItem before: self mathItem]].
	"if several curves check for the intersectables"
	^ curves size > 1 
		ifTrue: [  
			intersectables := curves select: [ :aCostume |  aCostume mathItem isIntersectableItem].
			intersectables size > 1
				ifTrue: [intersectables]
				ifFalse: [#()]]
		ifFalse: [ curves ]
]

{ #category : #'as yet unclassified' }
DrGSelectTool >> updateDirtyItemsList [
"dirty items are the one needing update, both model and view"
"	mathItems := self factory dirtyItemsWhen: costume mathItem.
	costumes := self app costumesOf: mathItems. "
	mathItems := self factory pool.
	costumes := self app costumes
]
