Class {
	#name : #DrGSelectToolStateSelected,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGSelectToolStateSelected >> handleMouseAt: aPoint [
	|costumes|
	costumes := self context costumesAt: aPoint.
	^ (costumes includes: self context costume)
		ifTrue:
			[self area 
				tip: self mathItem descriptiveName
				at: aPoint.
			true]
		ifFalse: [self area hideTip.
			false]
]

{ #category : #handling }
DrGSelectToolStateSelected >> handlePress: aPoint [ 
	| costumes |
	self area hideTip.
	costumes := self context costumesAt: aPoint.
	(costumes includes: self context costume) 
		ifTrue: [
			self context updateDirtyItemsList.
			self switchState: DrGSelectToolStateGrabbed.
			^true]
		ifFalse: [ 
			self context reset.
			^false]
]
