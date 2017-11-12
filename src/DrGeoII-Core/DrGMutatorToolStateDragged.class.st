Class {
	#name : #DrGMutatorToolStateDragged,
	#superclass : #DrGSelectToolStateDragged,
	#instVars : [
		'mutator',
		'originalPointClass'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGMutatorToolStateDragged >> context: aContext [
	super context: aContext.
	originalPointClass := context mathItem class.
]

{ #category : #handling }
DrGMutatorToolStateDragged >> handleMouseAt: aPoint [
	|costumes aTip|
	"First handle the redraw"
	super handleMouseAt: aPoint.
	"Detect for mutation candidate"
	costumes := self context targetMutationCostumeAt: aPoint.
	(costumes isEmpty and: [self isMutantFreePoint not]) ifTrue: [
		aTip := 'Change as a free point on the plane.' translated].
	costumes size = 1 ifTrue: [
		aTip := 'Change as a free point on this curve.' translated].
	costumes size > 1 ifTrue: [
		aTip := 'Change as this intersection.' translated].
	aTip 
		ifNil: [self area hideTip]
		ifNotNil: [self area tip: aTip at: aPoint].
	^ aTip isNil not
]

{ #category : #handling }
DrGMutatorToolStateDragged >> handleRelease: aPoint [
	|costumes|
	self area hideTip.
	"Detect for mutation candidate"
	costumes := self context targetMutationCostumeAt: aPoint.
	costumes size = 1 ifTrue: [
		self context domain
			mutate: self mathItem 
			asFreeOn: costumes first mathItem 
			at: (self area gridWorldPoint: aPoint)].
	costumes size > 1 ifTrue: [
		self context domain 
			mutate: self mathItem 
			asIntersectionWith: costumes first mathItem  
			and: costumes second mathItem  
			at: (self area gridWorldPoint: aPoint)]. 
	self app saved: false.
	self switchState: DrGSelectToolStateNeutral.
	self context reset

]

{ #category : #'as yet unclassified' }
DrGMutatorToolStateDragged >> isMutantFreePoint [
	^ originalPointClass = DrGPointFreeItem
]
