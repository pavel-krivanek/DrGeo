Class {
	#name : #DrGLocus2ptsItem,
	#superclass : #DrGMathItem,
	#instVars : [
		'sampleNumber',
		'p'
	],
	#category : #DrGeoII-Core-Item
}

{ #category : #accessing }
DrGLocus2ptsItem >> abscissaOf: aPoint [ 
	| i distance |
	distance := self squareNorm: aPoint - (p at: 1).
	i := 1.
	2 to: sampleNumber do: [:n | 
		(self squareNorm: (p at: n) - aPoint)	< distance ifTrue: 
			[distance := self squareNorm: aPoint - (p at: n).
			i := n]].
	^ (i / sampleNumber) asFloat
]

{ #category : #private }
DrGLocus2ptsItem >> adaptiveDescriptiveName [
	^ 'This locus %1' translated
]

{ #category : #accessing }
DrGLocus2ptsItem >> basicType [
	^ #locus
]

{ #category : #accessing }
DrGLocus2ptsItem >> closestPointTo: aPoint [ 
	| distance d m |
	m := p at: 1.
	distance := self squareNorm: aPoint - m.
	2 to: sampleNumber do: [:n | 
		d := self squareNorm: (p at: n) - aPoint.
		d < distance ifTrue: 
			[m := p at: n.
			distance := d]].
	^ m
]

{ #category : #accessing }
DrGLocus2ptsItem >> constrainedPoint [
	^ parents second
]

{ #category : #accessing }
DrGLocus2ptsItem >> costumeClass [ 
	^ DrGLocusCostume 
]

{ #category : #accessing }
DrGLocus2ptsItem >> freePoint [
	^ parents first
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isCurveItem [
	^ true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isGeometricItem [
	^ true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isIntersectableItem [
	^ false
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isLocusItem [
	^ true
]

{ #category : #'xml writing' }
DrGLocus2ptsItem >> nodeType [
	^#'2pts'
]

{ #category : #accessing }
DrGLocus2ptsItem >> pointAt: anAbscissa [ 
	| m |
	sampleNumber ifNil: [^0@0].
	m := (anAbscissa * sampleNumber) rounded.
	m = 0 ifTrue: [m := 1].
	^ p at: m
]

{ #category : #accessing }
DrGLocus2ptsItem >> points [
	^ p
]

{ #category : #accessing }
DrGLocus2ptsItem >> points: aCollection [ 
	p := aCollection
]

{ #category : #printing }
DrGLocus2ptsItem >> printOn: aStream [
	self printType: DrGLocusBuilder title on: aStream
]

{ #category : #accessing }
DrGLocus2ptsItem >> samples [
	^ sampleNumber
]

{ #category : #accessing }
DrGLocus2ptsItem >> samples: aNumber [ 
	sampleNumber := aNumber
]

{ #category : #private }
DrGLocus2ptsItem >> squareNorm: aPoint [ 
	^ aPoint x * aPoint x + (aPoint y * aPoint y)
]

{ #category : #updating }
DrGLocus2ptsItem >> update [
]
