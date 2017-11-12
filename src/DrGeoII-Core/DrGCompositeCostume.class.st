"
I am a costume composed of several costumes
"
Class {
	#name : #DrGCompositeCostume,
	#superclass : #DrGMathItemCostume,
	#instVars : [
		'subCostumes'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'as yet unclassified' }
DrGCompositeCostume class >> for: aMathItem in: aDrawable with: theSubCostumes [
	^ self basicNew 
		drawable: aDrawable;
		mathItem: aMathItem;
		subCostumes: theSubCostumes;
		initialize
]

{ #category : #updating }
DrGCompositeCostume >> addCostume: aCostume [
	mathItem subItems: (mathItem subItems add: aCostume mathItem; yourself).
	drawable app remove: aCostume.
	subCostumes add: aCostume.

	
]

{ #category : #testing }
DrGCompositeCostume >> basicType [
	^#composite
]

{ #category : #updating }
DrGCompositeCostume >> changed [
	subCostumes do: [:costume |
		costume changed]
]

{ #category : #updating }
DrGCompositeCostume >> color: aColor [
	subCostumes do: [:aCostume |	
		aCostume style color: aColor]
]

{ #category : #testing }
DrGCompositeCostume >> containsPoint: aPoint [
	subCostumes do: [:costume|
		(costume containsPoint: aPoint) ifTrue:
			[^true]].
	^false
]

{ #category : #updating }
DrGCompositeCostume >> dash: anObject [
	subCostumes do: [:aCostume|
		aCostume isCurveCostume ifTrue:
			[aCostume dash: anObject]]
]

{ #category : #'as yet unclassified' }
DrGCompositeCostume >> disband [
"Disband this composite item"
	drawable app ungroupCostumes: mathItem
]

{ #category : #updating }
DrGCompositeCostume >> forceVisible: aBoolean [
	subCostumes do: [:costume |
		costume forceVisible: aBoolean]
]

{ #category : #initialize-release }
DrGCompositeCostume >> initialize [
	exist := true.
	self style: (self styleClass newWith: self).

]

{ #category : #updating }
DrGCompositeCostume >> makeBackArrow [
	subCostumes do: [:aCostume|
		aCostume isFinitCurveCostume ifTrue:
			[aCostume makeBackArrow]]
]

{ #category : #updating }
DrGCompositeCostume >> makeBothArrows [
	subCostumes do: [:aCostume|
		aCostume isFinitCurveCostume ifTrue:
			[aCostume makeBothArrows]]
]

{ #category : #updating }
DrGCompositeCostume >> makeForwardArrow [
	subCostumes do: [:aCostume|
		aCostume isFinitCurveCostume ifTrue:
			[aCostume makeForwardArrow]]
]

{ #category : #updating }
DrGCompositeCostume >> makeNoArrows [
	subCostumes do: [:aCostume|
		aCostume isFinitCurveCostume ifTrue:
			[aCostume makeNoArrows]]
]

{ #category : #updating }
DrGCompositeCostume >> redraw [
	super redraw ifFalse: [^ self].
	subCostumes
		do: [:costume | costume redraw]
]

{ #category : #updating }
DrGCompositeCostume >> removeCostume: aCostume [
	mathItem subItems: (mathItem subItems copyWithout: aCostume mathItem).
	drawable app add: aCostume.
	subCostumes remove: aCostume.
]

{ #category : #updating }
DrGCompositeCostume >> shape: anObject [
	subCostumes do: [:aCostume|
		aCostume isPointCostume ifTrue:
			[aCostume style shape: anObject]]
]

{ #category : #updating }
DrGCompositeCostume >> startBlinking [
	subCostumes do: [:costume |
		costume startBlinking ]
]

{ #category : #updating }
DrGCompositeCostume >> stopBlinking [
	subCostumes do: [:costume |
		costume stopBlinking ]
]

{ #category : #style }
DrGCompositeCostume >> styleClass [
	^DrGCompositeStyle
]

{ #category : #accessing }
DrGCompositeCostume >> subCostumes [
	^subCostumes 
]

{ #category : #accessing }
DrGCompositeCostume >> subCostumes: theSubCostumes [
	subCostumes := theSubCostumes 
]

{ #category : #updating }
DrGCompositeCostume >> updateToInvisible [
	subCostumes do: [:costume |
		costume updateToInvisible]
]

{ #category : #updating }
DrGCompositeCostume >> updateToVisible [
	subCostumes do: [:costume |
		costume updateToVisible]
]

{ #category : #updating }
DrGCompositeCostume >> updatedMathItem [
	subCostumes do: [:costume |
		costume update]
]

{ #category : #updating }
DrGCompositeCostume >> width: anInteger [
	subCostumes do: [:aCostume|
		aCostume isCurveCostume ifTrue:
			[aCostume width: anInteger]]
]
