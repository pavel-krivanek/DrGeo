Class {
	#name : #DrGSelectToolStateDragged,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGSelectToolStateDragged >> handleChoice: aCostumeCollection [ 
"In this state, handle a choice to merge two points"
	aCostumeCollection ifNotEmpty: [
		aCostumeCollection do: [:aCostume | aCostume stopBlinking].
		self context mathItem point: (self area morphToWorld: self context start).
		self context domain 
			merge: self context mathItem with: aCostumeCollection first mathItem.
		self app saved: false].
	self context reset.
]

{ #category : #handling }
DrGSelectToolStateDragged >> handleMouseAt: aPoint [
|griddedPoint|
	griddedPoint := self context gridPoint: aPoint.
	(self context isGridded and: [self mathItem isFreePointItem])
		ifFalse:
			[self context domain 
				moveEvent: self mathItem
				inDirection: (self area morphToVector: 
									griddedPoint - self context last)
				withDirty: self context mathItems.]
		ifTrue:
			[self context domain 
				moveEvent: self mathItem
				at: (self area gridWorldPoint: griddedPoint)
				withDirty: self context mathItems].
	self context last: griddedPoint.
	self area updateDottedLinesToParents.
	self area restartMouseStillDownHandle.
	^ true
]

{ #category : #handling }
DrGSelectToolStateDragged >> handleRelease: aPoint [ 
	self switchState: DrGSelectToolStateNeutral.
	"issue a moveCommand"
	self context domain 
		moveMathItem: self mathItem 
		with: (self area morphToVector: 
			self context last - self context start).
	self area removeDottedLinesToParents.
	self context reset.
	self app saved: false
]

{ #category : #handling }
DrGSelectToolStateDragged >> handleStillPress: aPoint [
	|merger|
	(merger := self context pointCostumeToMergeWithAt: aPoint) notEmpty  ifTrue: 
		["I keep pressing while holding a free point"
		merger size = 1 
			ifTrue: [self handleChoice: merger]
			ifFalse: [self context chooseCostume: merger title: 'Select a point to merge with' translated]]
]
