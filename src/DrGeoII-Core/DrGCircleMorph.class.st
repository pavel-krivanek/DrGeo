Class {
	#name : #DrGCircleMorph,
	#superclass : #DrGMorph,
	#instVars : [
		'borderDashSpec'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGCircleMorph >> center: aPoint radius: aFloat [
	self bounds: (aPoint - aFloat corner: aPoint + aFloat) 
]

{ #category : #'geometry testing' }
DrGCircleMorph >> containsPoint: aPoint [
	"it is a circle so height and width is the diameter"
"	(bounds containsPoint: aPoint) ifFalse: [^false]."
	^((self center dist: aPoint) - (self height / 2)) abs < 20
]

{ #category : #dashes }
DrGCircleMorph >> dashedBorder [
	^ borderDashSpec
]

{ #category : #dashes }
DrGCircleMorph >> dashedBorder: dashSpec [
	borderDashSpec := dashSpec.
	self changed
]

{ #category : #drawing }
DrGCircleMorph >> drawOn: aCanvas [
	costume style isFilled 
		ifTrue: [aCanvas fillOval: self bounds color: self color borderWidth: self borderWidth borderColor: self borderColor]
		ifFalse:	[aCanvas frameOval: self bounds width: self borderWidth color: self borderColor]
]

{ #category : #drawing }
DrGCircleMorph >> drawOnAthensCanvas: aCanvas [
| path |
	path := aCanvas createPath: [:builder |
		builder absolute;
			moveTo: self leftCenter;
			cwArcTo: self rightCenter angle: Float pi;
			cwArcTo: self leftCenter angle: Float pi].
	aCanvas setShape: path.
	costume style isFilled ifTrue: [aCanvas setPaint: self color. aCanvas draw].
	(aCanvas setStrokePaint: self borderColor) 
		width: self borderWidth;
		dashes: self dashedBorder offset: 0.
	aCanvas draw
]

{ #category : #accessing }
DrGCircleMorph >> fullBounds [
	^ super fullBounds expandBy:  10
]

{ #category : #'change reporting' }
DrGCircleMorph >> invalidRect: damageRect [
	^ super invalidRect: (damageRect  expandBy:  2)
]

{ #category : #'stepping and presenter' }
DrGCircleMorph >> step [
	blink ifFalse: [^self].
	self borderColor = DrGStylePreference blinkingColor 
		ifTrue: [self borderColor: costume style borderColor]
		ifFalse: [self borderColor: DrGStylePreference blinkingColor]
]

{ #category : #'stepping and presenter' }
DrGCircleMorph >> stopStepping [
	super stopStepping.
	self color: (costume style isFilled ifTrue: [costume style color] ifFalse: [Color transparent]).
	self borderColor: costume style borderColor.
]
