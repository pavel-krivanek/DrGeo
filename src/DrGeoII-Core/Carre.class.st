Class {
	#name : #Carre,
	#superclass : #Object,
	#instVars : [
		'canvas'
	],
	#category : #DrGeoII-Core-Script
}

{ #category : #'as yet unclassified' }
Carre >> carre: s1 and: s2 and: s3 and: s4 n: integer [ 
	integer > 0
		ifTrue: [self
				carre: (self segment: s1 and: s2)
				and: (self segment: s2 and: s3)
				and: (self segment: s3 and: s4)
				and: (self segment: s4 and: s1)
				n: integer - 1]
]

{ #category : #initialize-release }
Carre >> initialize [
	| p1 |
	canvas := DrGeoCanvas new.
	self
		carre: (canvas
				segment: (p1 := canvas point: -2 @ 2)
				to: (canvas point: 2 @ 2))
		and: (canvas
				segment: (canvas point: 2 @ 2)
				to: (canvas point: 2 @ -2))
		and: (canvas
				segment: (canvas point: 2 @ -2)
				to: (canvas point: -2 @ -2))
		and: (canvas
				segment: (canvas point: -2 @ -2)
				to: (canvas point: -2 @ 2))
		n: 10.
	"MessageTally
		spyOn: [canvas domain moveEvent: p1 mathItem inDirection: 1 @ -1]"
]

{ #category : #'as yet unclassified' }
Carre >> segment: s1 and: s2 [ 
	| p1 p2 |
	p1 := canvas pointOnCurve: s1 at: 1 / 8.
	p2 := canvas pointOnCurve: s2 at: 1 / 8.
	^ canvas segment: p1 hide to: p2 hide
]
