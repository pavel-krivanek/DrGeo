Extension { #name : #DrGWrappedSegment }

{ #category : #'*DrGeo-French' }
DrGWrappedSegment >> marquerAucun [
	^ self noMark 
]

{ #category : #'*DrGeo-French' }
DrGWrappedSegment >> marquerAvecCercle [
	^ self circleMark 
]

{ #category : #'*DrGeo-French' }
DrGWrappedSegment >> marquerAvecDisque [
	^ self discMark 
]

{ #category : #'*DrGeo-French' }
DrGWrappedSegment >> marquerAvecDoubleTrait [
	^ self doubleMark 
]

{ #category : #'*DrGeo-French' }
DrGWrappedSegment >> marquerAvecSimpleTrait [
	^ self simpleMark 
]

{ #category : #'*DrGeo-French' }
DrGWrappedSegment >> marquerAvecTripleTrait [
	^ self tripleMark 
]
