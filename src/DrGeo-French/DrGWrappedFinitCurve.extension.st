Extension { #name : #DrGWrappedFinitCurve }

{ #category : #'*DrGeo-French' }
DrGWrappedFinitCurve >> flecheDebut [
	^ self backArrow
]

{ #category : #'*DrGeo-French' }
DrGWrappedFinitCurve >> flecheFin [
	^ self forwardArrow
]

{ #category : #'*DrGeo-French' }
DrGWrappedFinitCurve >> fleches [
	costume style arrow: #makeBothArrows
]
