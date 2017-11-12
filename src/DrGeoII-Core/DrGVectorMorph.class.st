Class {
	#name : #DrGVectorMorph,
	#superclass : #DrGSegmentMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGVectorMorph >> from: startPoint to: endPoint [
	"We don't calculate clipped vector, otherwise the arrow may be misplaced when part of the vector extremity is outisde the drawing area'"
	vertices at: 1 put: startPoint.
	vertices at: 2 put: endPoint.
	self computeBounds

]

{ #category : #initializing }
DrGVectorMorph >> initialize [
	super initialize.
	arrows := #forward.
]
