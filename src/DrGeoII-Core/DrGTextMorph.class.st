Class {
	#name : #DrGTextMorph,
	#superclass : #TextMorph,
	#instVars : [
		'costume',
		'blink',
		'myForm'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGTextMorph >> backgroundColor: newColor [
	super backgroundColor: newColor.
	myForm := nil
]

{ #category : #accessing }
DrGTextMorph >> borderColor: newColor [
	super borderColor: newColor.
	myForm := nil
]

{ #category : #accessing }
DrGTextMorph >> color: aColor [
	self textColor: aColor.
	myForm := nil
]

{ #category : #accessing }
DrGTextMorph >> contents: stringOrText [
	self contents = stringOrText ifTrue: [ ^ self ].
	myForm := nil.
	^ super contents: stringOrText
]

{ #category : #accessing }
DrGTextMorph >> costume [
	^ costume
]

{ #category : #accessing }
DrGTextMorph >> costume: aDrGTextCostume [ 
	costume := aDrGTextCostume
]

{ #category : #drawing }
DrGTextMorph >> drawOnAthensCanvas: aCanvas [
	| cached |
	myForm ifNil: [myForm := self imageForm].
	cached := aCanvas cacheAt: myForm ifAbsentPut: [
		myForm asAthensPaintOn: aCanvas.	].
	aCanvas setPaint: cached.
	aCanvas paintTransform restoreAfter: [
		aCanvas paintTransform translateBy: self fullBounds origin truncated.
		aCanvas drawShape: self fullBounds].	
	
]

{ #category : #'as yet unclassified' }
DrGTextMorph >> font: aFont [
	| theContents theColor|
	"Text morph sucks..."
	theColor := self color.
	theContents := self contents.
	self contents: ''.
	super font: aFont.
	self contents: theContents.
	self color: theColor.
	

]

{ #category : #events-processing }
DrGTextMorph >> handleMouseMove: anEvent [
	^ false
]

{ #category : #events-processing }
DrGTextMorph >> handlesMouseDown: anEvent [
	^ false
]

{ #category : #events-processing }
DrGTextMorph >> handlesMouseOver: anEvent [
	^ false
]

{ #category : #initialization }
DrGTextMorph >> initialize [ 
	super initialize.
	blink := false.
	self borderWidth: 3.
	self margins: 2.
	"self crAction: (MessageSend receiver: self selector: #ok)."
]

{ #category : #'stepping and presenter' }
DrGTextMorph >> startBlinking [
	blink := true.
	self startStepping 
]

{ #category : #'stepping and presenter' }
DrGTextMorph >> step [
	blink ifFalse: [^self].
	super step.
	self color = DrGStylePreference blinkingColor 
		ifTrue: [self color: costume style color]
		ifFalse: [self color: DrGStylePreference blinkingColor]
]

{ #category : #'stepping and presenter' }
DrGTextMorph >> stepTime [
	^500
]

{ #category : #'stepping and presenter' }
DrGTextMorph >> stopBlinking [
	blink := false.
	self stopStepping.
]

{ #category : #'stepping and presenter' }
DrGTextMorph >> stopStepping [
	super stopStepping.
	self color: costume style color.
]
