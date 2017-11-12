Class {
	#name : #DrGFlyBuildTouchToolState,
	#superclass : #DrGFlyBuildToolState,
	#category : #DrGeoII-Core-Tool
}

{ #category : #handling }
DrGFlyBuildTouchToolState >> handlePress: aPoint [
	| answer |
	answer := super handlePress: aPoint.
	self switchState: DrGFlyBuildTouchToolStateGrabbed.
	^ answer
]
