Class {
	#name : #DrGSelectToolStateNeutral,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGSelectToolStateNeutral >> handleMouseAt: aPoint [
	 (super handleMouseAt: aPoint)
		ifTrue: [
			Cursor webLink isCurrent ifFalse: [ 
				self currentHand showTemporaryCursor: Cursor webLink]] 
		ifFalse: [
			Cursor normal isCurrent ifFalse: [ 
				self currentHand showTemporaryCursor: Cursor normal]]
]

{ #category : #handling }
DrGSelectToolStateNeutral >> handlePress: aPoint [ 
	| costumes griddedPoint|
	self area hideTip.
	griddedPoint := self context gridPoint: aPoint.
	costumes := self context costumesAt: aPoint.
	costumes size = 1 
		ifTrue: 
			[self context last: griddedPoint.
			self context costume: costumes first.
			self context updateDirtyItemsList.
			self switchState: DrGSelectToolStateGrabbed.
			^true].
	"More than one math item under mouse"
	costumes size > 1 
		ifTrue: 
			[self context last: griddedPoint.
			self context chooseCostume: costumes.
			^true].
	"The user clicked in the background, clear the selection"
	self context reset.
	^false
]

{ #category : #handling }
DrGSelectToolStateNeutral >> handlePressShiftKey: aPoint [ 
	| costumes griddedPoint|
	self area hideTip.
	griddedPoint := self context gridPoint: aPoint.
	costumes := self context mutableCostumesAt: aPoint.
	costumes size = 1 
		ifTrue: 
			[self context last: griddedPoint.
			self context costume: costumes first.
			self context updateDirtyItemsList.
			self switchState: DrGMutatorToolStateGrabbed. 
			^true].
	"More than one math item under mouse"
	costumes size > 1 
		ifTrue: 
			[self context last: griddedPoint.
			(self context chooseCostume: costumes) 
				ifTrue: [self switchState: DrGMutatorToolStateSelected].
			^true].
	"The user clicked in the background, clear the selection"
	self context reset.
	^false
]

{ #category : #handling }
DrGSelectToolStateNeutral >> handleShiftKeyMouseAt: aPoint [
	"Let's inform about the mutate mode"
	| costumes aTip |
	costumes := self context mutableCostumesAt: aPoint.
	costumes ifEmpty: [
		aTip := 'Pressing down the [Shift] key you can drag and change the nature of free point or intersection point.' translated].
	costumes size = 1 ifTrue: [
		aTip := 'Drag this point to change its nature.' translated].
	costumes size > 1 ifTrue: [
		aTip := 'Several objects can be selected. Please, select one clicking the mouse.' translated. ].
	self area tip: aTip at: aPoint.
	^ aTip notNil
]

{ #category : #testing }
DrGSelectToolStateNeutral >> isSelectNeutral [
	^ true
]
