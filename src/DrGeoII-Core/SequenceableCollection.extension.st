Extension { #name : #SequenceableCollection }

{ #category : #'*DrGeoII-Core' }
SequenceableCollection >> shiftRight [
	^ self allButFirst, (Array with: self first)
]
