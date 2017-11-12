Class {
	#name : #DrGEditGroupTool,
	#superclass : #DrGDynamicTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGEditGroupTool >> compositeCostumesAt: aPoint [
	^self myCostumesAt: aPoint
]

{ #category : #accessing }
DrGEditGroupTool >> costumesAt: aPoint [
	^self pointCostumesFirstAt: aPoint
]

{ #category : #initialization }
DrGEditGroupTool >> initialize [
	super initialize.
	self reset
]

{ #category : #private }
DrGEditGroupTool >> myCostumesAt: aPoint [
	^self app costumes select: [:aCostume |
		aCostume style isNotHidden
			and: [aCostume isCompositeCostume
				and: [aCostume containsPoint: aPoint]]]
]

{ #category : #private }
DrGEditGroupTool >> pointCostumesFirstAt: aPoint [
	^(super pointCostumesFirstAt: aPoint) select: [:aCostume |
		aCostume isCompositeCostume not]
]

{ #category : #initialize-release }
DrGEditGroupTool >> release [
	costume ifNotNil:
		[costume stopBlinking].
	super release.
]

{ #category : #updating }
DrGEditGroupTool >> reset [
	super reset.
	self switchState:  DrGEditGroupToolStateNeutral
]
