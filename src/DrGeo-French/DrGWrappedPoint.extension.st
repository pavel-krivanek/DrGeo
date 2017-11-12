Extension { #name : #DrGWrappedPoint }

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> carre [
	^ self square
]

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> coordonnees [
	^ self coordinates
]

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> croix [
	^ self cross
]

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> deplacerA: aPoint [
	^ self moveTo: aPoint
]

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> moyen [
	^ self medium
]

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> petit [
	^ self small
]

{ #category : #'*DrGeo-French' }
DrGWrappedPoint >> rond [
	^ self round
]
