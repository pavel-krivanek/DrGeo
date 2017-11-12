Class {
	#name : #DrGStringMorph,
	#superclass : #StringMorph,
	#instVars : [
		'costume',
		'blink'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'geometry testing' }
DrGStringMorph >> containsPoint: aPoint [
	^ (self bounds expandBy: 20) containsPoint: aPoint
]

{ #category : #accessing }
DrGStringMorph >> costume [
	"Answer the value of costume"

	^ costume
]

{ #category : #accessing }
DrGStringMorph >> costume: anObject [
	"Set the value of costume"

	costume := anObject
]

{ #category : #drawing }
DrGStringMorph >> drawOnAthensCanvas: aCanvas [
"Work around for the conflicting size font problem"
	aCanvas pathTransform restoreAfter: [
	aCanvas pathTransform scaleBy: 1.00001.
		"draw text here"
		super drawOnAthensCanvas: aCanvas].

]

{ #category : #'event handling' }
DrGStringMorph >> handlesMouseDown: evt [
	^true
]

{ #category : #initialization }
DrGStringMorph >> initialize [
	super initialize.
	blink := false.
	self font: DrGDefault canvasFont

]

{ #category : #'stepping and presenter' }
DrGStringMorph >> startBlinking [
	blink := true.
	self startStepping 
]

{ #category : #'stepping and presenter' }
DrGStringMorph >> step [
	blink ifFalse: [^self].
	super step.
	self color = DrGStylePreference blinkingColor 
		ifTrue: [self color: costume style color]
		ifFalse: [self color: DrGStylePreference blinkingColor]
]

{ #category : #testing }
DrGStringMorph >> stepTime [
	^500
]

{ #category : #'stepping and presenter' }
DrGStringMorph >> stopBlinking [
	blink := false.
	self stopStepping.
]

{ #category : #'stepping and presenter' }
DrGStringMorph >> stopStepping [
	super stopStepping.
	self color: costume style color.
]

{ #category : #'geometry testing' }
DrGStringMorph >> strickContainsPoint: aPoint [
	^ self bounds containsPoint: aPoint
]
