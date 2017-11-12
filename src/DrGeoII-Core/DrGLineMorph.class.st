"
A DGLineMorph is extented to the boundary of its parent morph, a drawable in Dr. Geo jargon.
"
Class {
	#name : #DrGLineMorph,
	#superclass : #DrGSegmentMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'instance creation' }
DrGLineMorph class >> from: startPoint to: endPoint color: lineColor width: lineWidth [
| instance |
	instance := self vertices: {startPoint. endPoint}
			color: Color black borderWidth: lineWidth borderColor: lineColor.
	instance blink: false.
	^ instance 
]

{ #category : #layout }
DrGLineMorph >> extendFrom: aPoint direction: u [
| p1 p2 drawable r|
	drawable := self costume drawable.
	r := u x asFloat / u y.
	p1 := Point x: ((drawable top - aPoint y) * r + aPoint x)  y: drawable top.
	p2 := Point x: ((drawable bottom - aPoint y) * r + aPoint x)
		y: drawable bottom.
	super from: p1 to: p2.
]

{ #category : #layout }
DrGLineMorph >> extendHorizontally: aPoint [
| p1 p2 drawable|
	drawable := self costume drawable.
	p1 := Point x: drawable left y: aPoint y.
	p2 := Point x: drawable right y: aPoint y.
	super from: p1 to: p2
]

{ #category : #accessing }
DrGLineMorph >> from: aPoint direction: u [
	u y abs < 0.001 
		ifTrue: [self extendHorizontally: aPoint]
		ifFalse: [self extendFrom: aPoint direction: u]
]
