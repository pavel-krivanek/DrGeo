"
Define a geometric angle in the range  [0 ; 180] given three points
"
Class {
	#name : #DrGAngle3ptsItem,
	#superclass : #DrGAngleItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #private }
DrGAngle3ptsItem >> adaptiveDescriptiveName [
	^ 'This geometric angle %1' translated
]

{ #category : #accessing }
DrGAngle3ptsItem >> costumeClass [
	^ DrGAngle3PointsCostume 
]

{ #category : #testing }
DrGAngle3ptsItem >> isLockable [ 
	^ false
]

{ #category : #updating }
DrGAngle3ptsItem >> move: aPoint [
"Don't move when user drag around"
]

{ #category : #'xml writing' }
DrGAngle3ptsItem >> nodeType [
	^#'3pts'
]

{ #category : #'as yet unclassified' }
DrGAngle3ptsItem >> position [ 
	^ self summit point
]

{ #category : #accessing }
DrGAngle3ptsItem >> side1 [
	^ parents first
]

{ #category : #accessing }
DrGAngle3ptsItem >> side2 [
	^ parents third
]

{ #category : #accessing }
DrGAngle3ptsItem >> summit [
	^ parents second
]

{ #category : #updating }
DrGAngle3ptsItem >> update [
|u v center|
	self doParentsExist ifTrue:
		[center := parents second point.
		u := parents first point - center.
		v := parents third point - center.
		(u = (0@0) or: [v = (0@0)]) 
			ifTrue: [exist := false]
			ifFalse:
				[radianValue := value := ((u crossProduct: v) asFloat arcTan2: (u dotProduct: v)) abs.
				degreeValue := radianValue radiansToDegrees]].
]
