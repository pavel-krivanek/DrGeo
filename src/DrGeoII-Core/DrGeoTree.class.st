"
I am the construction tree of an interactive sketch. I list, in the order of construction, the items composing a sketch. From me, the user can also edit the items' attributs: property and style.
"
Class {
	#name : #DrGeoTree,
	#superclass : #MorphTreeModel,
	#instVars : [
		'app',
		'factory'
	],
	#category : #DrGeoII-Core-UI
}

{ #category : #'instance creation' }
DrGeoTree class >> on: aDrgeoApp [
	^ self new app: aDrgeoApp 
]

{ #category : #accessing }
DrGeoTree >> app: aDrgeoApp [
	app := aDrgeoApp.
	factory := app domain factory 
]

{ #category : #'as yet unclassified' }
DrGeoTree >> initialize [
	super initialize.
	self wrapBlockOrSelector: [ :item |
		item printString truncateWithElipsisTo: 30]
]

{ #category : #'as yet unclassified' }
DrGeoTree >> open [
	^ self openDialogWindowIn: World title: app title
]

{ #category : #'dependents access' }
DrGeoTree >> release [
	super release.
	app := factory := nil
]

{ #category : #accessing }
DrGeoTree >> rootItems [ 
"Return only the visible items"
	 ^ app costumes 
		select: [ :aCostume | aCostume mathItem exist and: [aCostume style isNotHidden] ]
		thenCollect: [ :aCostume | aCostume mathItem ]
]

{ #category : #accessing }
DrGeoTree >> rootNodeClassFromItem: anItem [
	^ DrGeoNode 
]

{ #category : #accessing }
DrGeoTree >> treeMorphClass [
	^ DrGTreeMorph 
]
