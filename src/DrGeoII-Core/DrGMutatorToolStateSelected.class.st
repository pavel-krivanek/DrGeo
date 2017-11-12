Class {
	#name : #DrGMutatorToolStateSelected,
	#superclass : #DrGSelectToolStateSelected,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGMutatorToolStateSelected >> handlePress: aPoint [ 
	| costumes |
	self area hideTip.
	costumes := self context costumesAt: aPoint.
	(costumes includes: self context costume) 
		ifTrue: [
			self context updateDirtyItemsList.
			self switchState: DrGMutatorToolStateGrabbed.
			^true]
		ifFalse: [ 
			self context reset.
			^false]
]
