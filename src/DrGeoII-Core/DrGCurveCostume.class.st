Class {
	#name : #DrGCurveCostume,
	#superclass : #DrGMathItemCostume,
	#instVars : [
		'anchorAbscissa'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #accessing }
DrGCurveCostume >> anchorAbscissa: number [
	anchorAbscissa := number 
]

{ #category : #accessing }
DrGCurveCostume >> borderColor: aColor [
	morph borderColor: (aColor alpha: 1)
]

{ #category : #layout }
DrGCurveCostume >> constraintTextPosition: aPoint [
|center vector|
	center := mathItem closestPointTo: (drawable morphToWorld: aPoint).
	anchorAbscissa := mathItem abscissaOf: center.
	center := drawable worldToMorph: center.
	vector := aPoint - center.
	^textPositionDelta := self computeTextPositionDelta: vector.

]

{ #category : #initialize-release }
DrGCurveCostume >> initialize [
	super initialize.
	anchorAbscissa := 0.5
]

{ #category : #testing }
DrGCurveCostume >> isCurveCostume [
	^ true
]

{ #category : #layout }
DrGCurveCostume >> textPosition [
	^(drawable worldToMorph: (mathItem pointAt: anchorAbscissa)) + textPositionDelta
]

{ #category : #'xml writing' }
DrGCurveCostume >> writeAttributesTo: aNode [
	aNode attributeAt: #anchor put: anchorAbscissa asString.
	super writeAttributesTo: aNode.

]
