Class {
	#name : #DrGSegmentMorph,
	#superclass : #DrGPolylineMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGSegmentMorph >> from: startPoint to: endPoint [  
	vertices at: 1 put: startPoint.
	vertices at: 2 put: endPoint.
	self computeBounds

]

{ #category : #initializing }
DrGSegmentMorph >> initialize [
	super initialize.
	vertices := Array with: 0@0 with: 0@0.
]
