"
A DrGMorph is xxxxxxxxx.

Instance Variables
	blink:		<Object>
	costume:		<Object>

blink
	- xxxxx

costume
	- xxxxx

"
Class {
	#name : #DrGMorph,
	#superclass : #BorderedMorph,
	#instVars : [
		'costume',
		'blink'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #geometry }
DrGMorph >> center [
"We want float computation"
	^ bounds topLeft + bounds bottomRight / 2
]

{ #category : #accessing }
DrGMorph >> costume [
	^costume
]

{ #category : #accessing }
DrGMorph >> costume: aCostume [
	costume := aCostume
]

{ #category : #'event handling' }
DrGMorph >> handlesMouseDown: evt [
	^ false
]

{ #category : #initialization }
DrGMorph >> initialize [
	super initialize.
	blink := false.

]

{ #category : #'*DrGeoII-Core-testing' }
DrGMorph >> isMorphCostume [
	^true
]

{ #category : #geometry }
DrGMorph >> leftCenter [
"We want float computation"

	^ self left @ self center y
]

{ #category : #geometry }
DrGMorph >> rightCenter [
"We want float computation"

	^ self right @ self center y
]

{ #category : #'stepping and presenter' }
DrGMorph >> startBlinking [
	blink := true.
	self startStepping 
]

{ #category : #'stepping and presenter' }
DrGMorph >> step [
	blink ifFalse: [^self].
	super step.
	self color = DrGStylePreference blinkingColor 
		ifTrue: [self color: costume style color]
		ifFalse: [self color: DrGStylePreference blinkingColor]
]

{ #category : #'stepping and presenter' }
DrGMorph >> stepTime [
	^500
]

{ #category : #'stepping and presenter' }
DrGMorph >> stopBlinking [
	blink := false.
	self stopStepping.
]

{ #category : #'stepping and presenter' }
DrGMorph >> stopStepping [
	super stopStepping.
	self color: costume style color.
]
