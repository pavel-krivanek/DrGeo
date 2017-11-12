Class {
	#name : #DrGPointCostume,
	#superclass : #DrGMathItemCostume,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGPointCostume >> basicType [
	^#point
]

{ #category : #layout }
DrGPointCostume >> constraintTextPosition: aPoint [
|center vector|
	center := drawable worldToMorph: mathItem point.
	vector := aPoint - center.
	^textPositionDelta := self computeTextPositionDelta: vector
	
]

{ #category : #layout }
DrGPointCostume >> distanceTo: aPoint [
	^morph center dist: aPoint  
]

{ #category : #updating }
DrGPointCostume >> editFreePointOnCurveProperty [
	| answer |
	answer := self view 
		textEntry:  'Edit this curvilinear abscissa in [0;1]' translated 
		title: 'Edit this value' translated 
		entryText: mathItem abscissa asString.
	answer isEmptyOrNil ifTrue: [^self]. " cancelled"
	[answer := answer asNumber]
		on: Error
		do: [^ self view alert: 'I can''t read your value.' translated].
	self domain propertyCommandFor: mathItem with: answer
]

{ #category : #updating }
DrGPointCostume >> editFreePointProperty [
	| answer |
	answer := self view 
		textEntry:  'Edit the coordinates' translated 
		title: 'Edit the coordinates' translated 
		xEntryText: mathItem point x
		yEntryText: mathItem point y.
	(answer anySatisfy: [:each | each isNil]) ifTrue: [^self]. " cancelled"
	[answer := answer first asNumber @ answer second asNumber]
		on: Error
		do: [^ self view alert: 'I can''t read your value.' translated].
	self domain propertyCommandFor: mathItem with: answer
]

{ #category : #updating }
DrGPointCostume >> editMyProperty [
	| answer |
	mathItem isPropertyEditable ifFalse: [^self].
	DrGDefault showVirtualKeyboard: true.
	mathItem isPointItemOnCurve 
		ifTrue: [self editFreePointOnCurveProperty]
		ifFalse: [self editFreePointProperty].
	DrGDefault showVirtualKeyboard: false.

]

{ #category : #initialize-release }
DrGPointCostume >> initialize [ 
	super initialize.
	self textMorph: ' '.
	self presenter tool isCloning ifTrue: [^self].
	"We do not want anymore on-the-fly namming scheme for point
	DrGDefault ifTablet: [^ self]. 
	(ActiveEvent isNil or: [ActiveEvent hand isNil]) 
		ifFalse: [self textMorph launchMiniEditor: ActiveEvent].    "
]

{ #category : #initialize-release }
DrGPointCostume >> instantiateMorph [
	morph := DrGPointMorph new
]

{ #category : #updating }
DrGPointCostume >> pointSize: anExtent [
	morph extent: anExtent.
	exist ifTrue: [morph center: (drawable worldToMorph: mathItem point)].
]

{ #category : #updating }
DrGPointCostume >> redraw [
	super redraw 
		ifFalse: [^ self].
	morph
		center: (drawable worldToMorph: mathItem point)
]

{ #category : #updating }
DrGPointCostume >> shape: aShape [
]

{ #category : #style }
DrGPointCostume >> styleClass [
	^DrGPointCostumeStyle
]

{ #category : #layout }
DrGPointCostume >> textPosition [
	^(drawable worldToMorph: mathItem point) + textPositionDelta
]
