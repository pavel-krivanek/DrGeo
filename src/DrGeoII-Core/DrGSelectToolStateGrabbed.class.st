Class {
	#name : #DrGSelectToolStateGrabbed,
	#superclass : #DrGSelectToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGSelectToolStateGrabbed >> handleMouseAt: aPoint [ 
	"The user is moving, switch to dragging state"
	self context
		start: aPoint;
		last: aPoint.
	self context costume isBitmapCostume 
		ifTrue: [self switchState: DrGSelectToolStateDraggedBitmap] 
		ifFalse: [self area dottedLinesToParentsOf: self  mathItem.
			self switchState: DrGSelectToolStateDragged].
	^ true
]

{ #category : #handling }
DrGSelectToolStateGrabbed >> handleRelease: aPoint [ 
	self switchState: DrGSelectToolStateNeutral.
	self context reset.
	self context factory rehash. "After move event rehash the the free positionnable item"
]

{ #category : #handling }
DrGSelectToolStateGrabbed >> handleStillPress: aPoint [
"The user keeps pressing without moving, he wants a clone"
	self context 
		start: aPoint;
		last: aPoint.
	self context builder 
		add: {self context mathItem}
		at: aPoint.
]
