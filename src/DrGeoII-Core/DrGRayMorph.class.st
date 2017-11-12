"
A DGRayMorph is extended in one 'sens' to the boundary of its parents morph, a drawable in Dr. Geo   jargon.
"
Class {
	#name : #DrGRayMorph,
	#superclass : #DrGSegmentMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #layout }
DrGRayMorph >> extendFrom: origin direction: u [
| border drawable r|
	drawable := costume drawable.
	r := u x asFloat / u y.
	u y > 0
		ifTrue: [border := Point x: ((drawable bottom - origin y) * r + origin x) 
			y: drawable bottom]
		ifFalse: [border := Point x: ((drawable top - origin y) * r + origin x) 
			y: drawable top].
	super from: origin to: border.
]

{ #category : #layout }
DrGRayMorph >> extendHorizontally: origin direction: u [
| border drawable|
	drawable := costume drawable.
	u x > 0
		ifTrue: [border := Point x: drawable right y: origin y]
		ifFalse: [border := Point x: drawable left y: origin y].
	super from: origin to: border
]

{ #category : #accessing }
DrGRayMorph >> from: aPoint direction: u [
	u y abs < 0.001 
		ifTrue: [self extendHorizontally: aPoint direction: u]
		ifFalse: [self extendFrom: aPoint direction: u]
]
