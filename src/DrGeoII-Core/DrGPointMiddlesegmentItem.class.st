Class {
	#name : #DrGPointMiddlesegmentItem,
	#superclass : #DrGPointMiddle2ptsItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #'xml writing' }
DrGPointMiddlesegmentItem >> nodeType [
	^ #'Middle_segment'
]

{ #category : #comparing }
DrGPointMiddlesegmentItem >> parentsEqual: aMathItem [ 
	^ parents first = aMathItem parents first
]

{ #category : #updating }
DrGPointMiddlesegmentItem >> update [
	self doParentsExist ifTrue:
		[self point: (parents first origin + (parents first direction / 2))].

]
