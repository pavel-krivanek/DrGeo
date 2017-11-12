Class {
	#name : #DrGBuildToolState,
	#superclass : #DrGDynamicToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGBuildToolState >> handleChoice: aCostumeCollection [
|aMathItemCollection|
	aMathItemCollection := OrderedCollection new.
	aCostumeCollection do: [:aCostume|
		aMathItemCollection add: aCostume mathItem.
		self context add: aCostume].
	^ self context builder 
		add: aMathItemCollection 
		at: (self area gridWorldPoint: self context last).
]

{ #category : #handling }
DrGBuildToolState >> handlePress: aPoint [ 
	"return true if we process something (including additional user choice)"

	| costumes |
	self area hideTip.
	self context last: aPoint.
	costumes := self context costumesAt: aPoint.
	costumes size = 1 
		ifTrue: 
			[self handleChoice: costumes.
			^true].
	(costumes size = 0 and: [self context isWanted: { }]) 
		ifTrue: 
			[self handleChoice: costumes.
			^true].
	"More than one math item under mouse, user must choose one item"
	costumes size >= 2 
		ifTrue: 
			["Display a pop-up menu to select one item"
			self context chooseCostume: costumes.
			^true].
	^false
]
