Extension { #name : #DrGWrappedFilledCurve }

{ #category : #'*DrGeo-French' }
DrGWrappedFilledCurve >> remplir [
	^ self filled
]

{ #category : #'*DrGeo-French' }
DrGWrappedFilledCurve >> transparent [
	^ self translucent
]

{ #category : #'*DrGeo-French' }
DrGWrappedFilledCurve >> vider [
	^ self unfilled
]
