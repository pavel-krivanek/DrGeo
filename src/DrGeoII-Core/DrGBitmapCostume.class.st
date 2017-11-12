Class {
	#name : #DrGBitmapCostume,
	#superclass : #DrGMathItemCostume,
	#instVars : [
		'previousScale',
		'previousMagnify'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #testing }
DrGBitmapCostume >> basicType [ 
	^ #bitmap
]

{ #category : #'as yet unclassified' }
DrGBitmapCostume >> color: aColor [
	morph borderColor: aColor
]

{ #category : #layout }
DrGBitmapCostume >> constraintTextPosition: aPoint [
|center vector|
	center := drawable worldToMorph: mathItem topCenter.
	vector := aPoint - center.
	^textPositionDelta := self computeTextPositionDelta: vector
	
]

{ #category : #initialize-release }
DrGBitmapCostume >> initialize [ 
	super initialize.
	previousScale := mathItem insertAtScale.
	previousMagnify := mathItem magnifyBy.
	self style color: Color black
]

{ #category : #initialize-release }
DrGBitmapCostume >> instantiateMorph [ 
	morph := DrGBitmapMorph new paintResource: mathItem data
]

{ #category : #testing }
DrGBitmapCostume >> isAnyCornerIn: aPoint [
	"is aPoint belong to one of the corners of extent 24, if so return its symbole otherwise nil"
	((morph position extent: 24@24) containsPoint: aPoint) ifTrue: [^#topLeft].
	((morph topRight - (24@0) extent: 24@24) containsPoint: aPoint) ifTrue: [^#topRight].
	((morph bottomRight -  24 extent: 24@24) containsPoint: aPoint) ifTrue: [^ #bottomRight].
	((morph bottomLeft - (0@16) extent: 24@24) containsPoint: aPoint) ifTrue: [^ #bottomLeft].
	^ nil
]

{ #category : #'as yet unclassified' }
DrGBitmapCostume >> myScale [
	^ drawable scale * mathItem magnifiedScale
]

{ #category : #updating }
DrGBitmapCostume >> redraw [ 
	super redraw 
		ifFalse: [^self].
	morph center: (drawable worldToMorph: mathItem position).
]

{ #category : #layout }
DrGBitmapCostume >> textPosition [
	^(drawable worldToMorph: mathItem topCenter) + textPositionDelta 
]
