Class {
	#name : #DrGPolygoneMorph,
	#superclass : #DrGPolylineMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'as yet unclassified' }
DrGPolygoneMorph >> containsPoint: aPoint [
	(self bounds containsPoint: aPoint) ifFalse: [^ false].
	
	^ (self filledForm pixelValueAt: aPoint - bounds topLeft + 1) > 0
]

{ #category : #initialization }
DrGPolygoneMorph >> initialize [
	super initialize.
	self makeClosed.
]

{ #category : #'as yet unclassified' }
DrGPolygoneMorph >> isCurvier [
	^ false
]
