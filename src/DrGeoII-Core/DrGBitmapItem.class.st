"
- data : an athens paint containing the original bitmap
- canvasScaleAtInsertion : the canvas scale at which the bitmap was dropped in the canvas. it is the scale reference for the rest of the bitmap life
- scale : a Float, bitmap can be scaled by this scale factor
"
Class {
	#name : #DrGBitmapItem,
	#superclass : #DrGMathItem,
	#instVars : [
		'data',
		'locked',
		'position',
		'canvasScaleAtInsertion',
		'magnifyBy'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #comparing }
DrGBitmapItem >> = aMathItem [ 
	^ super = aMathItem 
		and: [position = aMathItem position and:
			[data = aMathItem data]]
]

{ #category : #private }
DrGBitmapItem >> adaptiveDescriptiveName [ 
	^ 'This picture' translated
]

{ #category : #accessing }
DrGBitmapItem >> basicType [
	^ #bitmap
]

{ #category : #accessing }
DrGBitmapItem >> costumeClass [
	^ DrGBitmapCostume
]

{ #category : #accessing }
DrGBitmapItem >> data [
	^ data
]

{ #category : #accessing }
DrGBitmapItem >> data: anAthensPaint [
	data := anAthensPaint 
]

{ #category : #accessing }
DrGBitmapItem >> descriptiveName [ 
	^ self adaptiveDescriptiveName 
]

{ #category : #testing }
DrGBitmapItem >> doParentsExist [ 
	^ true
]

{ #category : #accessing }
DrGBitmapItem >> height [
	"height in the world coordinates system"
	^ data extent y * self magnifiedScale 
]

{ #category : #initialize-release }
DrGBitmapItem >> initialize [
	super initialize.
	magnifyBy := 1.
]

{ #category : #initialize-release }
DrGBitmapItem >> initialize: theParents [
	super initialize: theParents.
	self position: theParents last
]

{ #category : #accessing }
DrGBitmapItem >> insertAtScale [
	^ canvasScaleAtInsertion  
]

{ #category : #accessing }
DrGBitmapItem >> insertAtScale: aScale [
	canvasScaleAtInsertion  := aScale 
]

{ #category : #'*DrGeoII-Core-testing' }
DrGBitmapItem >> isBitmapItem [
	^ true
]

{ #category : #testing }
DrGBitmapItem >> isLockable [ 
	^ true
]

{ #category : #accessing }
DrGBitmapItem >> isLocked [
	^ locked ifNil: [locked := false]
]

{ #category : #testing }
DrGBitmapItem >> isPropertyEditable [ 
	^ false
]

{ #category : #accessing }
DrGBitmapItem >> locked: aBoolean [
	locked := aBoolean 
]

{ #category : #accessing }
DrGBitmapItem >> magnifiedScale [
	"Scale factor accordingly to the canvas scale at insertion and the magnify factor"
	^ (magnifyBy / canvasScaleAtInsertion ) asFloat
]

{ #category : #accessing }
DrGBitmapItem >> magnifyBy [ 
	^ magnifyBy 
]

{ #category : #accessing }
DrGBitmapItem >> magnifyBy: aFloat [
	magnifyBy := aFloat 
]

{ #category : #updating }
DrGBitmapItem >> move: aPoint [
	self isLocked ifFalse: [position := position + aPoint]
]

{ #category : #updating }
DrGBitmapItem >> moveParent: aPoint [
	^ false
]

{ #category : #'xml writing' }
DrGBitmapItem >> nodeType [
	^#free
]

{ #category : #accessing }
DrGBitmapItem >> parents: aCollection [
	parents := nil.

]

{ #category : #accessing }
DrGBitmapItem >> position [
	^ position
]

{ #category : #accessing }
DrGBitmapItem >> position: aPoint [ 
	position := aPoint.
]

{ #category : #'as yet unclassified' }
DrGBitmapItem >> printOn: aStream [
	self printType: 'Picture' translated on: aStream.
	self printCoordinates: position on: aStream 
]

{ #category : #comparing }
DrGBitmapItem >> rehash [
	^ hash := data hash bitXor: position hash
]

{ #category : #accessing }
DrGBitmapItem >> topCenter [
	"top center position in the world coordinates system"
	^ position + (0@(self height / 2))
]

{ #category : #'xml writing' }
DrGBitmapItem >> writeAsXmlPositionTo: aNode [ 
	"return the newly created element"
	aNode
		addNode: ((XMLElement named: #x)
				addContent: (XMLString string: position x asString));
		addNode: ((XMLElement named: #y)
				addContent: (XMLString string: position y asString)).
	^ aNode
]

{ #category : #'xml writing' }
DrGBitmapItem >> writeAsXmlTo: aNode [
	|node stream |
	stream := ByteArray new writeStream.
	PNGReadWriter putForm: data asForm onStream: stream.
	DrGLoader stop.
	node := super writeAsXmlTo: aNode.
	self writeAsXmlPositionTo: node.
	node
		addNode: ((XMLElement named: #insertAtScale) 
			addContent: (XMLString string: canvasScaleAtInsertion asString));
		addNode: ((XMLElement named: #magnify) 
			addContent: (XMLString string: magnifyBy asString));
		addNode:  ((XMLElement named: #data) 
			addContent: (XMLString string: stream contents base64Encoded)).
	^ node

]
