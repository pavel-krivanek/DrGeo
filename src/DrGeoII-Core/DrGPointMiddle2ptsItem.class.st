Class {
	#name : #DrGPointMiddle2ptsItem,
	#superclass : #DrGPointItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'*DrGeoII-Core-testing' }
DrGPointMiddle2ptsItem >> isConstrainedPointItem [
	^true
]

{ #category : #'xml writing' }
DrGPointMiddle2ptsItem >> nodeType [
	^#'Middle_2pts'
]

{ #category : #comparing }
DrGPointMiddle2ptsItem >> parentsEqual: aMathItem [
"	^ self parents asSet = aMathItem parents asSet"
	((parents first = aMathItem parents first) and: [parents second = aMathItem parents second]) 
		ifTrue: [^true].
	((parents first = aMathItem parents second) and: [parents second = aMathItem parents first]) 
		ifTrue: [^true].
	^ false

]

{ #category : #updating }
DrGPointMiddle2ptsItem >> update [
	self doParentsExist ifTrue:
		[self point: (parents first point + parents second point) / 2].

]
