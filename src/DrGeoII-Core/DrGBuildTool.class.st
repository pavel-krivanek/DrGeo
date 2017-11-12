Class {
	#name : #DrGBuildTool,
	#superclass : #DrGDynamicTool,
	#instVars : [
		'selectedCostumes',
		'builder'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #'instance creation' }
DrGBuildTool class >> with: aBuilderClassName [
	^self new builder: aBuilderClassName new.
]

{ #category : #adding }
DrGBuildTool >> add: aCostume [
	self stopBlinking.
	selectedCostumes add: aCostume.
	self startBlinking.
]

{ #category : #accessing }
DrGBuildTool >> builder [
	^builder
]

{ #category : #accessing }
DrGBuildTool >> builder: aBuilder [
	builder := aBuilder 
]

{ #category : #accessing }
DrGBuildTool >> description [ 
	^ builder class description
]

{ #category : #initialize-release }
DrGBuildTool >> initialize [
	super initialize.
	self switchState:  DrGBuildToolState.
	selectedCostumes := OrderedCollection new
]

{ #category : #testing }
DrGBuildTool >> isWanted: aMathItemCollection [
	^builder isWanted: aMathItemCollection  
]

{ #category : #accessing }
DrGBuildTool >> presenter: aPresenter [
	super presenter: aPresenter.
	builder app: self app.
]

{ #category : #updating }
DrGBuildTool >> redrawFlyingCostume [
	builder redrawFlyingCostume 
]

{ #category : #initialize-release }
DrGBuildTool >> registerDependant: anObject [
	builder when: #readyToBuild send: #readyToBuild to: anObject
]

{ #category : #initialize-release }
DrGBuildTool >> release [
	super release.
	builder release.
	self releaseActionMap. 
]

{ #category : #updating }
DrGBuildTool >> reset [
	super reset.
	self stopBlinking.
	self builder reset.
	selectedCostumes := OrderedCollection new
]

{ #category : #updating }
DrGBuildTool >> startBlinking [
	selectedCostumes do: [ :aCostume | aCostume startBlinking ]
]

{ #category : #updating }
DrGBuildTool >> stopBlinking [
	selectedCostumes do: [ :aCostume | aCostume stopBlinking ]
]
