Class {
	#name : #DrGPointItem,
	#superclass : #DrGMathItem,
	#instVars : [
		'point'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #private }
DrGPointItem >> adaptiveDescriptiveName [
	^ 'This point %1' translated
]

{ #category : #accessing }
DrGPointItem >> basicType [
	^#point
]

{ #category : #computing }
DrGPointItem >> closestPointTo: aPoint [
	^ self point  
]

{ #category : #accessing }
DrGPointItem >> costumeClass [ 
	^DrGPointCostume 
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPointItem >> isGeometricItem [
	^true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPointItem >> isPointItem [
	^true
]

{ #category : #testing }
DrGPointItem >> isPropertyEditable [
	^ self isFreePointItem 
]

{ #category : #updating }
DrGPointItem >> moveAt: aPoint [

]

{ #category : #updating }
DrGPointItem >> moveParent: aPoint [
	^false
]

{ #category : #scripting }
DrGPointItem >> moveTo: aPoint [
	self moveAt: aPoint.
	self rehash.
]

{ #category : #accessing }
DrGPointItem >> point [
	^point 
]

{ #category : #accessing }
DrGPointItem >> point: aPoint [
	point := aPoint .
]

{ #category : #printing }
DrGPointItem >> printOn: aStream [
	self printType: DrGFlyPointBuilder title on: aStream.
	self printCoordinates: point on: aStream



]
