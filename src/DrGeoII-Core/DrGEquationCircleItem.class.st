Class {
	#name : #DrGEquationCircleItem,
	#superclass : #DrGEquationItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #accessing }
DrGEquationCircleItem >> equation [
	^ value
]

{ #category : #testing }
DrGEquationCircleItem >> isVerifiedBy: aPoint [
	^ parents first contains: aPoint
]

{ #category : #'xml writing' }
DrGEquationCircleItem >> nodeType [
	^#circle
]

{ #category : #updating }
DrGEquationCircleItem >> update [
	self doParentsExist ifTrue: [| circle |
		circle := parents first.
		value := String streamContents: [:stream |
		 stream nextPutAll: '(x ';
			nextPutAll: (circle center x > 0 ifTrue: [' - '] ifFalse: ['']).
		self printDecimal: circle center x on: stream.
		stream nextPutAll: ')² + (y - '.
		self printDecimal: circle center y on: stream.
		stream nextPutAll: ')² = '.
		self printDecimal: circle radius squared  on: stream]]
]
