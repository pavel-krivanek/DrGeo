"
This is the domain object for DrGeo, aka the top level Model instance for one DrGeo instance
"
Class {
	#name : #DrGeoDomain,
	#superclass : #Model,
	#instVars : [
		'factory',
		'cmdManager',
		'actionMap'
	],
	#category : #DrGeoII-Core-App
}

{ #category : #event }
DrGeoDomain >> actionMap [
	actionMap ifNil: [^self createActionMap].
	^ actionMap 
]

{ #category : #'user interface' }
DrGeoDomain >> addModelItemsToWindowMenu: aMenu [ 
	aMenu addLine.
	aMenu
		add: 'About Dr. Geo...'
		target: self
		selector: #inform:
		argument: DrGeo drgeoCopyright
]

{ #category : #building }
DrGeoDomain >> createCompositeItem: aMathItemSelection [
	cmdManager compositeCommandFor: aMathItemSelection.
]

{ #category : #building }
DrGeoDomain >> createFromMathItem: aMathItem [
	"return the mathItem (newly created or the one in the pool, 
in case the caller want to do something with it"
	(factory pushAsLastWhenInPool: aMathItem) ifTrue:
		[^{factory last. false}].
	"create a new command and execute it"
	cmdManager buildCommandFor: aMathItem.
	^{ aMathItem. true }
]

{ #category : #building }
DrGeoDomain >> createFromMathItemNoStack: aMathItem [
	"return the mathItem (newly created or the one in the pool, 
in case the caller want to do something with it, without stacking in the undo/redo stack"
	(factory pushAsLastWhenInPool: aMathItem) ifTrue: [^factory last].
	factory add: aMathItem.
	self triggerEvent: #newMathItem with: aMathItem.
	^aMathItem
]

{ #category : #building }
DrGeoDomain >> createFromMathItemNoStackNoFactoryCheck: aMathItem [
	"return the mathItem. we do not check in the facory pool, without stacking in the undo/redo stack"
	factory add: aMathItem.
	self triggerEvent: #newMathItem with: aMathItem.
	^aMathItem
]

{ #category : #building }
DrGeoDomain >> createMacro: aBuilder [ 
	(DrGMacroFactory new pushAsLastWhenInPool: (aBuilder getItem: self)) ifFalse: 
		[ "Create macro and register it in the factory"
		DrGMacroFactory new add: (aBuilder getItem: self) ]
]

{ #category : #building }
DrGeoDomain >> createMathItem: aBuilder [ 
	"return the mathItem (newly created or the one in the pool, 
in case the caller want to do something with it"
	(factory pushAsLastWhenInPool: aBuilder getItem first) ifTrue: 
		[ ^ {  (factory last). false  } ].
	"create a new command and execute it"
	^ {  (cmdManager buildCommandWith: aBuilder). true  }
]

{ #category : #building }
DrGeoDomain >> deleteMathItem: aMathItem [ 
	"create a delete command and execute it"
	cmdManager deleteCommandFor: aMathItem
]

{ #category : #accessing }
DrGeoDomain >> factory [
	^factory
]

{ #category : #building }
DrGeoDomain >> in: macroTree replaceParent: item with: newItem [ 
	| index |
	macroTree do: [ :anItem | 
		(anItem parents notNil and: [ (index := anItem parents indexOf: item) ~= 0 ])
			ifTrue: [anItem parents at: index put: newItem ] ]
]

{ #category : #initialize-release }
DrGeoDomain >> initialize [
	super initialize.
	factory := DrGMathItemFactory new.
	cmdManager := DrGCommandManager new domain: self
]

{ #category : #accessing }
DrGeoDomain >> labelString [
	^ 'Dr. Geo -- ', Date today asString
]

{ #category : #building }
DrGeoDomain >> merge: aMathItem with: aTarget [
	"create a merge command"
	cmdManager mergeCommandFor: aMathItem with: aTarget
]

{ #category : #updating }
DrGeoDomain >> moveEvent: aMathItem at: aPoint [
	aMathItem moveAt: aPoint.
	self updateAllMathItems
]

{ #category : #updating }
DrGeoDomain >> moveEvent: aMathItem at: aPoint withDirty: mathItems [
	aMathItem moveAt: aPoint.
	self updateDirty: mathItems
]

{ #category : #updating }
DrGeoDomain >> moveEvent: aMathItem inDirection: aPoint [ 
	aMathItem moveEvent: aPoint.
	self updateAllMathItems 
]

{ #category : #updating }
DrGeoDomain >> moveEvent: aMathItem inDirection: aPoint withDirty: mathItems [
	aMathItem moveEvent: aPoint.
	self updateDirty: mathItems
]

{ #category : #building }
DrGeoDomain >> moveMathItem: aMathItem with: aPoint [
	"create a move command"
	cmdManager moveCommandFor: aMathItem with: aPoint
]

{ #category : #updating }
DrGeoDomain >> mutate: aPointItem asFreeOn: aCurveItem at: aPosition [
	|item|
	item := DrGPointOncurveItem newWith: {aCurveItem .  aPosition}.
	item name: aPointItem name.
	item actionMap: aPointItem actionMap.
	aPointItem become: item.
	self updateAllMathItems 
]

{ #category : #updating }
DrGeoDomain >> mutate: aPointItem asIntersectionWith: curveA and: curveB at: aPosition [
	|item|
	item :=  DrGPointIntersectionItem newWith: {curveA. curveB.  aPosition}.
	item name: aPointItem name.
	item actionMap: aPointItem actionMap.
	aPointItem become: item.
	self updateAllMathItems.
]

{ #category : #updating }
DrGeoDomain >> mutateAsFreePoint: aPointItem [
	|freePointItem|
	(aPointItem isFreePointItem and: [aPointItem isPointItemOnCurve not]) ifTrue: [^aPointItem].
	freePointItem := DrGPointFreeItem new point: aPointItem point.
	freePointItem name: aPointItem name.
	freePointItem actionMap: aPointItem actionMap.
	aPointItem become: freePointItem.
	^ freePointItem
]

{ #category : #building }
DrGeoDomain >> playMacro: aBuilder in: app [ 
	| answer macroTree |
	macroTree := aBuilder getItem.
	macroTree 
		with: aBuilder constructedNodes
		do: 
			[ :item :node | 
			answer := self createFromMathItem: item.
			answer last 
				ifTrue: 
					[ node isHiddenNode ifTrue: 
						[ (app costumeOf: item) ifNotNilDo: 
							[ :aCostume | 
							aCostume style hidden: true.
							aCostume forceVisible: false ] ] ]
				ifFalse: 
					[ "item twin in the factory, use it in the macro tree"
					self 
						in: macroTree
						replaceParent: item
						with: answer first ] ]
]

{ #category : #building }
DrGeoDomain >> propertyCommandFor: aMathItem with: aProperty [ 
	"create a move command"
	cmdManager propertyCommandFor: aMathItem with: aProperty 
]

{ #category : #accessing }
DrGeoDomain >> redo [
	cmdManager redo
]

{ #category : #initialize-release }
DrGeoDomain >> release [
	super release.
	factory release.
	cmdManager release.
]

{ #category : #event }
DrGeoDomain >> releaseActionMap [
	actionMap := nil
]

{ #category : #accessing }
DrGeoDomain >> undo [
	cmdManager undo
]

{ #category : #updating }
DrGeoDomain >> update: object [
 	(object class == MethodModified and: [object methodClass superclass = DrGeoUserScript]) 
		ifTrue: [self updateAllMathItems]
]

{ #category : #updating }
DrGeoDomain >> updateAllMathItems [
	factory updateAllMathItems.
	self triggerEvent: #updatedItems
]

{ #category : #updating }
DrGeoDomain >> updateAllMathItemsButLocus [
	factory updateAllMathItemsButLocus.
	"We don't need to update the costumem we just want updated mathiteem'"
	"self triggerEvent: #updatedItems"
]

{ #category : #updating }
DrGeoDomain >> updateDirty: mathItems [
	mathItems do: [:item | item update].
	self triggerEvent: #updatedDirtyItems
]

{ #category : #event }
DrGeoDomain >> updateableActionMap [
	actionMap ifNil:
		[actionMap := self createActionMap].
	^actionMap
]
