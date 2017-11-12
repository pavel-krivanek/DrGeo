Class {
	#name : #DrGPointOncurveItem,
	#superclass : #DrGPointItem,
	#instVars : [
		'abscissa',
		'locked'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #comparing }
DrGPointOncurveItem >> = aMathItem [
	^ super = aMathItem 
		and: [self abscissa = aMathItem abscissa ]
]

{ #category : #accessing }
DrGPointOncurveItem >> abscissa [
	^abscissa
]

{ #category : #accessing }
DrGPointOncurveItem >> abscissa: anAbscissa [
	abscissa := anAbscissa.
	abscissa > 1 ifTrue: [abscissa := 1].
	abscissa < 0 ifTrue: [abscissa := 0].
	self rehash
]

{ #category : #initialize-release }
DrGPointOncurveItem >> initialize: theParents [
	super initialize: theParents. 
	self doParentsExist ifTrue:
		[self point: (theParents first closestPointTo: theParents second).
		self abscissa: (theParents first abscissaOf: self point)].
	self rehash
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPointOncurveItem >> isFreePointItem [
	^true
]

{ #category : #testing }
DrGPointOncurveItem >> isLockable [ 
	^ true
]

{ #category : #accessing }
DrGPointOncurveItem >> isLocked [
	^ locked ifNil: [locked := false]
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPointOncurveItem >> isPointItemOnCurve [
	^true
]

{ #category : #accessing }
DrGPointOncurveItem >> locked: aBoolean [
	locked := aBoolean 
]

{ #category : #updating }
DrGPointOncurveItem >> move: aPoint [
	self isLocked ifFalse: [
		self point: (parents first closestPointTo: point + aPoint).
		self abscissa: (parents first abscissaOf: self point)]

]

{ #category : #updating }
DrGPointOncurveItem >> moveAt: aPoint [
	self isLocked ifFalse: [
		self point: (parents first closestPointTo: aPoint).
		self abscissa: (parents first abscissaOf: self point)]

]

{ #category : #scripting }
DrGPointOncurveItem >> moveTo: aPoint [
	self point: (parents first closestPointTo: aPoint).
	self abscissa: (parents first abscissaOf: self point).
]

{ #category : #'xml writing' }
DrGPointOncurveItem >> nodeType [
	^#'On_curve'
]

{ #category : #accessing }
DrGPointOncurveItem >> parents: aCollection [
"We only need the first mathItem in the collection. 
The second one is a Point instance (position the user clicked) only used at initialization time"
	aCollection isEmptyOrNil ifTrue: 
		[parents := aCollection.
		^self].
	parents := OrderedCollection new add: aCollection first;yourself.

]

{ #category : #accessing }
DrGPointOncurveItem >> property [ 
	^ self abscissa 
]

{ #category : #accessing }
DrGPointOncurveItem >> property: aProperty [ 
	self setCurveAbscissa: aProperty.
]

{ #category : #comparing }
DrGPointOncurveItem >> rehash [
	^hash := super rehash bitXor: abscissa hash
]

{ #category : #scripting }
DrGPointOncurveItem >> setCurveAbscissa: aFloat [ 
	self abscissa: aFloat.
	self update
]

{ #category : #updating }
DrGPointOncurveItem >> update [
	self doParentsExist ifTrue:
		[self point: (parents first pointAt: abscissa).
		(point x isInfinite or: [point y isInfinite ]) ifTrue: [exist := false]].

]

{ #category : #'xml writing' }
DrGPointOncurveItem >> writeAsXmlTo: aNode [
	"It is important to return the node"
	| node|
	node := super writeAsXmlTo: aNode.
	node addNode:  ((XMLElement named: #value) addContent: (XMLString string: abscissa  asString)).
	^node
]
