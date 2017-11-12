Extension { #name : #DrGLocus2ptsItem }

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isCurveItem [
	^ true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isGeometricItem [
	^ true
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isIntersectableItem [
	^ false
]

{ #category : #'*DrGeoII-Core-testing' }
DrGLocus2ptsItem >> isLocusItem [
	^ true
]
