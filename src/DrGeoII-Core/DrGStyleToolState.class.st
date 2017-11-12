Class {
	#name : #DrGStyleToolState,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #'as yet unclassified' }
DrGStyleToolState >> costumeStyle [
	^ self context costumeStyle
]

{ #category : #handling }
DrGStyleToolState >> handleChoice: aCostumeCollection [
	aCostumeCollection 
		ifNotEmpty: 
			[self context costume: aCostumeCollection first.
			self view setStyler: self costumeStyle styleWidget].
	self context reset
]

{ #category : #handling }
DrGStyleToolState >> handlePress: aPoint [
	|costumes|
	self area hideTip.
	costumes := self context costumesAt: aPoint.
	costumes size = 1 ifTrue:
		[self context last: aPoint.
		self handleChoice: costumes.
		^true].
	"More than one math item under mouse"
	costumes size > 1 ifTrue:
		[self context last: aPoint.
		self context chooseCostume: costumes.
		^true].
	"The user clicked in the background, clear the selection"
	self context reset.
	^false
]
