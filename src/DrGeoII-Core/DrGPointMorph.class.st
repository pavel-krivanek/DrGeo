Class {
	#name : #DrGPointMorph,
	#superclass : #DrGMorph,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'geometry testing' }
DrGPointMorph >> containsPoint: aPoint [
	^(self bounds expandBy: 20) containsPoint: aPoint
]

{ #category : #drawing }
DrGPointMorph >> drawOn: aCanvas [
|shape|
	shape := costume style shape.
	shape == #square ifTrue:
		[aCanvas fillRectangle: self bounds color: self color].
	shape == #round ifTrue:
		[aCanvas fillOval: self bounds color: self color].
	shape == #cross ifTrue:
		[aCanvas 
			line: self topLeft + (1@1) 
			to: self bottomRight - (1@1) 
			width: 2 
			color: self color.
		aCanvas 
			line: self topRight + (-1@1) 
			to: self bottomLeft - (-1@1) 
			width: 2	
			color: self color]
]

{ #category : #drawing }
DrGPointMorph >> drawOnAthensCanvas: aCanvas [
| shape |
	shape := costume style shape.
	shape == #square ifTrue:
		[shape := self bounds. 
		aCanvas setPaint: self color].
	shape == #round ifTrue:
		[aCanvas setPaint: self color.
		shape := aCanvas createPath: [ :builder |
			builder absolute;
				moveTo: self leftCenter;
				cwArcTo: self rightCenter angle: Float pi;
				cwArcTo: self leftCenter angle: Float pi].
			aCanvas setPaint: self color].
	shape == #cross ifTrue:
		[shape := aCanvas createPath: [ :builder |
			builder absolute;
				moveTo: self topLeft;
				lineTo: self bottomRight;
				moveTo: self topRight;
				lineTo: self bottomLeft].
		(aCanvas setStrokePaint: self color) width: 2].
	aCanvas setShape: shape .
	aCanvas draw
]

{ #category : #initializing }
DrGPointMorph >> initialize [
	super initialize.
	self extent: 4@4
]

{ #category : #'change reporting' }
DrGPointMorph >> invalidRect: damageRect [
	^ super invalidRect: (damageRect  expandBy:  2)
]
