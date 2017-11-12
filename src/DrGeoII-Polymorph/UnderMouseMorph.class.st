"
I display on the top left or right corner of my owner what is under the Active hand
"
Class {
	#name : #UnderMouseMorph,
	#superclass : #BorderedMorph,
	#category : #DrGeoII-Polymorph
}

{ #category : #drawing }
UnderMouseMorph >> drawOn: aCanvas [
	| areaUnderHand |
	super drawOn: aCanvas.
	areaUnderHand := Form fromDisplay: (Rectangle 
			center: ActiveHand position 
			extent: self extent - (self borderWidth * 2)).
	aCanvas drawImage: areaUnderHand at: self position + self borderWidth
]
