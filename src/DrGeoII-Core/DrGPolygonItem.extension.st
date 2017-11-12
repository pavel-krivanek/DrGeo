Extension { #name : #DrGPolygonItem }

{ #category : #'*DrGeoII-Core-testing' }
DrGPolygonItem >> isCurveItem [ 
	^ true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPolygonItem >> isGeometricItem [
	^true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPolygonItem >> isIntersectableItem [
	^ false
]

{ #category : #'*DrGeoII-Core-testing' }
DrGPolygonItem >> isPolygonItem [
	^true
]
