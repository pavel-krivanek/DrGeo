Class {
	#name : #DrGArcSymmetryItem,
	#superclass : #DrGArcItem,
	#category : #DrGeoII-Core-Item
}

{ #category : #updating }
DrGArcSymmetryItem >> moveParent: aPoint [
	^false
]

{ #category : #'xml writing' }
DrGArcSymmetryItem >> nodeType [
	^#Symmetry
]

{ #category : #updating }
DrGArcSymmetryItem >> update [
	self doParentsExist 
		ifTrue: 
			[origin := parents first origin + Float pi.
			origin > Float pi ifTrue: [origin := origin - DrGDirectionItem twoPi].
			radius := parents first radius.
			center := 2 * parents second point - parents first center.
			length := parents first length].

]
