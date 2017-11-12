Extension { #name : #DrGWrappedCurve }

{ #category : #'*DrGeo-French' }
DrGWrappedCurve >> epais [
	^ self large
]

{ #category : #'*DrGeo-French' }
DrGWrappedCurve >> fin [
	^ self small
]

{ #category : #'*DrGeo-French' }
DrGWrappedCurve >> plein [
	^ self plain
]

{ #category : #'*DrGeo-French' }
DrGWrappedCurve >> pointille [
	^ self dotted
]

{ #category : #'*DrGeo-French' }
DrGWrappedCurve >> tiret [
	^ self dashed 
]
