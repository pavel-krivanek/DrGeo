"
I represent a free point in the plane
"
Class {
	#name : #DrGPointFreeItem,
	#superclass : #DrGPointItem,
	#instVars : [
		'locked'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #testing }
DrGPointFreeItem >> doParentsExist [
	^ true
]

{ #category : #initialize-release }
DrGPointFreeItem >> initialize: theParents [
	super initialize: theParents.
	self point: theParents first.
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPointFreeItem >> isFreePointItem [
	^true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPointFreeItem >> isFreePointOnPlaneItem [
	^true
]

{ #category : #testing }
DrGPointFreeItem >> isLockable [ 
	^ true
]

{ #category : #accessing }
DrGPointFreeItem >> isLocked [
	^ locked ifNil: [locked := false]
]

{ #category : #accessing }
DrGPointFreeItem >> locked: aBoolean [
	locked := aBoolean 
]

{ #category : #updating }
DrGPointFreeItem >> move: aPoint [
	self isLocked ifFalse: [
		self point: point + aPoint]
	
]

{ #category : #updating }
DrGPointFreeItem >> moveAt: aPoint [
	self isLocked ifFalse: [
		self point: aPoint]
	
]

{ #category : #'xml writing' }
DrGPointFreeItem >> nodeType [
	^#Free
]

{ #category : #accessing }
DrGPointFreeItem >> parents: aCollection [
	parents := nil.

]

{ #category : #comparing }
DrGPointFreeItem >> parentsEqual: aMathItem [
	^ self point = aMathItem point
]

{ #category : #accessing }
DrGPointFreeItem >> point: aPoint [
	super point: aPoint.
	self rehash 
]

{ #category : #updating }
DrGPointFreeItem >> property [ 
	^ self point
]

{ #category : #updating }
DrGPointFreeItem >> property: aProperty [ 
	self point: aProperty.
]

{ #category : #comparing }
DrGPointFreeItem >> rehash [
	^hash := super rehash bitXor: point hash
]

{ #category : #'xml writing' }
DrGPointFreeItem >> writeAsXmlTo: aNode [
	"It is important to return the node"
	| node|
	node :=  super writeAsXmlTo: aNode.
	node addElement:  ((XMLElement named: #x) addContent: (XMLStringNode string: point x asString));
		addElement: ((XMLElement named: #y) addContent: (XMLStringNode string: point y asString)).
	^node
]

{ #category : #accessing }
DrGPointFreeItem >> x: aNumber [
	self point: aNumber @ self point y

]

{ #category : #accessing }
DrGPointFreeItem >> y: aNumber [
	self point: self point x @ aNumber

]
