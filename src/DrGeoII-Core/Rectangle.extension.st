Extension { #name : #Rectangle }

{ #category : #'*DrGeoII-Core-intersection' }
Rectangle >> intersectionWith: aLineSeg [ 
	| intersections |
	intersections := Set new.
	(aLineSeg
		intersectionWith: (LineSegment from: self origin to: self bottomLeft))
		ifNotNilDo: [:inter | intersections add: inter].
	(aLineSeg
		intersectionWith: (LineSegment from: self origin to: self topRight))
		ifNotNilDo: [:inter | intersections add: inter].
	(aLineSeg
		intersectionWith: (LineSegment from: self corner to: self bottomLeft))
		ifNotNilDo: [:inter | intersections add: inter].
	(aLineSeg
		intersectionWith: (LineSegment from: self corner to: self topRight))
		ifNotNilDo: [:inter | intersections add: inter].
		intersections := intersections asOrderedCollection.
	intersections size = 2
		ifTrue: [^ LineSegment from: intersections first to: intersections second].
	intersections size = 0 
		ifTrue: 
			[(self containsPoint: aLineSeg start) 
				ifTrue: [(self containsPoint: aLineSeg end) ifTrue: [^aLineSeg ]]
				ifFalse: [(self containsPoint: aLineSeg end) ifFalse: [^nil]]].

	(self containsPoint: aLineSeg start) 
		ifTrue: [
			(self containsPoint: aLineSeg start) 
				ifTrue: [^aLineSeg]
				ifFalse: [^LineSegment from: aLineSeg start to: intersections first]].
	(self containsPoint: aLineSeg end) 
		ifTrue: [^LineSegment from: aLineSeg end to: intersections first].
	^nil
]
