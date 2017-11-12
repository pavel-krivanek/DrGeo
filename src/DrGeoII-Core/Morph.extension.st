Extension { #name : #Morph }

{ #category : #'*DrGeoII-Core' }
Morph >> isMorphCostume [
	^false
]

{ #category : #'*DrGeoII-Core' }
Morph >> topCentered [
	self position: Display width - self width // 2 @ 0
]
