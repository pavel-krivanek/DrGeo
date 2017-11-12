"
This tool lets the user create free point, point on curve and intersection point on the fly.
On the fly means create the point in one-clic operation.
"
Class {
	#name : #DrGFlyPointBuildTool,
	#superclass : #DrGBuildTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGFlyPointBuildTool >> costumesAt: aPoint [
	| intersectables curves| 
	intersectables := self 
		intersectableCurves: (
			(self myCostumesAt: aPoint) select: [:aCostume| aCostume mathItem isIntersectableItem])
		at: aPoint.
	"if no intersectable, return the non intersectable only if one, otherwise it is considered for interesction"
	^ intersectables ifEmpty: [
		curves := (self myCostumesAt: aPoint) select: [:aCostume| aCostume isCurveCostume].
		curves size > 1 
			ifTrue: [ #() ]
			ifFalse: [ curves]]
]

{ #category : #initialize }
DrGFlyPointBuildTool >> initialize [
	super initialize.
	self switchState: DrGFlyPointBuildToolState
]

{ #category : #accessing }
DrGFlyPointBuildTool >> intersectableCurves: aCollection at: aPoint [ 
	"As long as we can't get proper intersection with the first two, we remove the first one an try again "
	aCollection size <= 1 ifTrue: [ ^ aCollection ].
	^ (	DrGFlyPointBuilder new isCurveIntersectionValid: { 
			(aCollection first mathItem).
			(aCollection second mathItem).
			aPoint}) 
		ifTrue: [ aCollection ]
		ifFalse: [self intersectableCurves: aCollection allButFirst at: aPoint ]
]
