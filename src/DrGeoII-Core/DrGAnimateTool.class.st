"
A tool to animate a free point on a curve.
- animateSpeed: millisecond betwen to animation step
"
Class {
	#name : #DrGAnimateTool,
	#superclass : #DrGDynamicTool,
	#instVars : [
		'animateStep'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #'as yet unclassified' }
DrGAnimateTool class >> description [
	^'Select a free point on a curve to animate it.' translated
]

{ #category : #'as yet unclassified' }
DrGAnimateTool class >> title [
	^ 'Animate' translated
]

{ #category : #'as yet unclassified' }
DrGAnimateTool >> animate [
	state animate
]

{ #category : #accessing }
DrGAnimateTool >> animateStep [
	^ animateStep
]

{ #category : #accessing }
DrGAnimateTool >> animateStep: aFloat [
	animateStep := aFloat 
]

{ #category : #accessing }
DrGAnimateTool >> costumesAt: aPoint [
	^ (self pointCostumesAt: aPoint) select: [:aCostume | aCostume mathItem isPointItemOnCurve]
]

{ #category : #accessing }
DrGAnimateTool >> description [ 
	^ self class description
]

{ #category : #initialize-release }
DrGAnimateTool >> initialize [
	super initialize.
	self reset
]

{ #category : #accessing }
DrGAnimateTool >> isAnimating [
	^ self state isAnimating 
]

{ #category : #initialize-release }
DrGAnimateTool >> reset [
	state ifNotNil: [state stopAnimating].
	super reset.
	self switchState: DrGAnimateToolState.

]
