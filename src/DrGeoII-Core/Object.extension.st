Extension { #name : #Object }

{ #category : #'*DrGeoII-Core-testing' }
Object >> isAngleItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isArcItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isBitmapItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isCircleItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isCompositeItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isConstrainedPointItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isCurveItem [
"When true, free point can be constrained on this item line"
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isDirectionItem [
"When true, this item are straight line with normal and unit vector"
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isEquation [
	^ false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isFreePointItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isFreePointOnPlaneItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isGeometricItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isIntersectableItem [
"When true, this curve can be intersected"
	^self isCurveItem
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isIntersectionPointItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isLineItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isLocusItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isMathItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isNumberItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isPointItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isPointItemOnCurve [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isPolygonItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isRayItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isScriptItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isSegmentItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isTextItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isValueItem [
	^false
]

{ #category : #'*DrGeoII-Core-testing' }
Object >> isVectorItem [
	^false
]
