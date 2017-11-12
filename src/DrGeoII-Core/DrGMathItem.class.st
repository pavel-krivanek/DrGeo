"
This is the root class of the mathematic items hierarchy.
The classes in this hierarchy are models of the mathematical items like point, line, circle.
These models will have different type of view depending on the ApplicationModel/View/Presenter.

id                            - unique id used when importing Dr. Geo 1.1 files / it is used to cache the index position in the factory pool 
name 				- for example A, (AB), [AD], d
descriptiveName	- 'this point A', 'this line (AB)'
longDescription	- the point A, the symmetric of the point B in respect to O'
basicType 			- object familly the instance belong to (#point, #line,...), it is part of the class name
nodeType 			- the sub type the instance belong to (#2pts, #translation, #intersection), it is the value of XML  'type' attribute

"
Class {
	#name : #DrGMathItem,
	#superclass : #Model,
	#instVars : [
		'parents',
		'name',
		'exist',
		'actionMap',
		'id',
		'hash'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #'instance creation' }
DrGMathItem class >> newWith: theParents [
	"Instantiate this mathItem with these parents
	Parents contains other MathItem instance, sometime it contains other object as Point"
	^self new 
		parents: theParents; 
		initialize: theParents;
		update;
		rehash;
		yourself
]

{ #category : #'instance creation' }
DrGMathItem class >> newWith: theParents in: app [
	"Instantiate this mathItem with these parents
	Parents contains other MathItem instance, sometime it contains other object as Point"
	^self new 
		parents: theParents in: app; 
		initialize: theParents;
		update;
		rehash;
		yourself
]

{ #category : #comparing }
DrGMathItem >> = aMathItem [ 
	^ aMathItem isMathItem 
		ifFalse: [false]
		ifTrue: [self basicType == aMathItem basicType
				and: [self nodeType == aMathItem nodeType
						and: [self parentsEqual: aMathItem]]]
]

{ #category : #computing }
DrGMathItem >> abscissaOf: aPoint [
	self subclassResponsibility
]

{ #category : #event }
DrGMathItem >> actionMap [
	actionMap ifNil: [^self createActionMap].
	^ actionMap 
]

{ #category : #event }
DrGMathItem >> actionMap: anObject [
	actionMap := anObject 
]

{ #category : #private }
DrGMathItem >> adaptiveDescriptiveName [
	^ 'This math item %1' translated
]

{ #category : #accessing }
DrGMathItem >> basicType [
	^#mathItem
]

{ #category : #updating }
DrGMathItem >> changed [
	self triggerEvent: #updateMyView
]

{ #category : #computing }
DrGMathItem >> clone [
"Return a collection with the necessary parents (free points) and a clone of myself"
	self shouldNotImplement
]

{ #category : #computing }
DrGMathItem >> closestPointTo: aPoint [
	self subclassResponsibility 
]

{ #category : #testing }
DrGMathItem >> contains: aPoint [
	self subclassResponsibility 
]

{ #category : #accessing }
DrGMathItem >> costumeClass [
	^ DrGMathItemCostume 
]

{ #category : #accessing }
DrGMathItem >> descriptiveName [
	^ self adaptiveDescriptiveName 
		copyReplaceAll: '%1'
		with: self safeName
]

{ #category : #testing }
DrGMathItem >> doParentsExist [
	exist := true.
	parents 
		ifNotNil: 
			[parents do: [:parent |
			parent exist ifFalse: [^ exist := false]]]
		ifNil: [exist := false].
	^exist
				
]

{ #category : #accessing }
DrGMathItem >> exist [
	^exist
]

{ #category : #accessing }
DrGMathItem >> exist: aBoolean [
	exist := aBoolean
]

{ #category : #comparing }
DrGMathItem >> hash [
	^ hash
]

{ #category : #accessing }
DrGMathItem >> id [
	^id
]

{ #category : #accessing }
DrGMathItem >> id: aSymbol [
	id := aSymbol
]

{ #category : #initialize-release }
DrGMathItem >> initialize [
	parents := nil.
	exist := true.
]

{ #category : #initialize-release }
DrGMathItem >> initialize: theParents [

]

{ #category : #computing }
DrGMathItem >> intersectionWith: aCurveItem [
	^ Array 
		with: (self intersectionWith: aCurveItem flag: 1)
		with: (self intersectionWith: aCurveItem flag: -1)
]

{ #category : #computing }
DrGMathItem >> intersectionWith: aCurveItem flag: aFlag [
	self subclassResponsibility 
]

{ #category : #testing }
DrGMathItem >> isCloneable [
	^ false
]

{ #category : #testing }
DrGMathItem >> isLockable [
	^ false
]

{ #category : #testing }
DrGMathItem >> isMathItem [
	^ true
]

{ #category : #testing }
DrGMathItem >> isPropertyEditable [
	^ false
]

{ #category : #updating }
DrGMathItem >> move: aPoint [

]

{ #category : #updating }
DrGMathItem >> moveAt: aPoint [
	self shouldNotImplement
]

{ #category : #updating }
DrGMathItem >> moveEvent: aPoint [
	(self moveParent: aPoint)
		ifFalse:
			["parents are not moving, we can upate ourself"
			self move: aPoint].

]

{ #category : #updating }
DrGMathItem >> moveParent: aPoint [
"By default we try reverse dragging (move parents).
This behaviour should be overridden for some mathItem, for example a free point on a curve should not reverse dragging the curve it belongs to.
Return true if we are doing reverse dragging, otherwise false"
	parents ifNotNil:
		[parents do: [:parent|
			parent moveEvent: aPoint]].
	^true.
]

{ #category : #accessing }
DrGMathItem >> name [
	^name
]

{ #category : #accessing }
DrGMathItem >> name: aString [
	name := aString 
]

{ #category : #'xml writing' }
DrGMathItem >> nodeType [
	^ #mathItem
]

{ #category : #accessing }
DrGMathItem >> parents [
	^ parents 
]

{ #category : #accessing }
DrGMathItem >> parents: aCollection [
	parents := aCollection.
]

{ #category : #accessing }
DrGMathItem >> parents: aCollection in: app [
	self parents: aCollection
]

{ #category : #comparing }
DrGMathItem >> parentsEqual: aMathItem [ 
	^ self parents = aMathItem parents
]

{ #category : #comparing }
DrGMathItem >> parentsIncludes: aMathItem [ 
"An idendity comparaison"
	^ parents notNil and: [parents anySatisfy: [:each | each == aMathItem]]
]

{ #category : #computing }
DrGMathItem >> pointAt: anAbscissa [
	self subclassResponsibility 
]

{ #category : #accessing }
DrGMathItem >> position [
	self shouldBeImplemented.
]

{ #category : #printing }
DrGMathItem >> printCoordinates: aPoint on: aStream [
	aPoint ifNotNil: [
		aStream nextPut: $(.
		self printDecimal: aPoint x on: aStream.
		aStream nextPutAll: ' ; '.
		self printDecimal: aPoint y on: aStream.
		aStream nextPut: $)].

]

{ #category : #printing }
DrGMathItem >> printDecimal: aValue on: aStream [
	aValue isInfinite 
		ifTrue: [aStream nextPutAll: 'inf.']
		ifFalse: [
			(aValue isInteger or: [aValue isFraction]) 
			ifFalse: [aStream nextPutAll: (aValue printShowingDecimalPlaces: 1)]
			ifTrue: [aStream print: aValue]]
]

{ #category : #printing }
DrGMathItem >> printInteger: aValue on: aStream [
	aStream nextPutAll: aValue rounded asString
]

{ #category : #printing }
DrGMathItem >> printOn: aStream [ 
	aStream 
		nextPutAll: 'a ';
		nextPutAll: self basicType capitalized;
		nextPutAll: self nodeType capitalized;
		nextPut: Character space.

]

{ #category : #printing }
DrGMathItem >> printType: aString on: aStream [
	aStream nextPutAll: aString;
		nextPut: Character space;
		nextPutAll: self safeName
]

{ #category : #updating }
DrGMathItem >> property [
	self subclassResponsibility 
]

{ #category : #updating }
DrGMathItem >> property: aProperty [ 
	self subclassResponsibility 
]

{ #category : #comparing }
DrGMathItem >> rehash [
	^ hash := (self parents hash bitXor: self nodeType hash) bitXor: self basicType hash
]

{ #category : #initialize-release }
DrGMathItem >> release [
	self triggerEvent: #deletedMathItem.
	"Do it last otherwise our deletedMathItem will never be sent"
	super release.
]

{ #category : #event }
DrGMathItem >> releaseActionMap [
	actionMap := nil
]

{ #category : #accessing }
DrGMathItem >> safeName [
	^ (name isNil or: [name isEmpty]) 
		ifTrue: [''] 
		ifFalse: [ name ]
]

{ #category : #updating }
DrGMathItem >> update [

]

{ #category : #event }
DrGMathItem >> updateableActionMap [
	actionMap ifNil:
		[actionMap := self createActionMap].
	^actionMap
]

{ #category : #'xml writing' }
DrGMathItem >> writeAsXmlTo: aNode [
	"return the newly created element"
	| node |
	self rehash.
	node :=  XMLElement name: self basicType attributes: Dictionary new.
	node attributeAt: #type put: self nodeType;
		attributeAt: #name put: (name ifNil: ['']);
		attributeAt: #id put: self hash asString.
	self writeParentsAsXmlTo: node.
	aNode addElement: node.
	^node
]

{ #category : #'xml writing' }
DrGMathItem >> writeParents: collection asXmlTo: aNode [
"write parents reference in the natural order"
|attr|
	collection do: [:each | 
		attr := Dictionary new.
		attr at: #ref put: each hash asString.
		aNode addElement: (XMLElement name: #parent attributes: attr)]
]

{ #category : #'xml writing' }
DrGMathItem >> writeParentsAsXmlTo: aNode [
	parents ifNotNil:
		[self writeParents: self parents asXmlTo: aNode]
]
