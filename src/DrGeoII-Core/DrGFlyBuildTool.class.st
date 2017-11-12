"
This tool is designed with a flying object representing the object in construction.
"
Class {
	#name : #DrGFlyBuildTool,
	#superclass : #DrGDynamicTool,
	#instVars : [
		'flyPointTool',
		'mathItemTool'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #'as yet unclassified' }
DrGFlyBuildTool class >> with: aBuilderClassName [
	^self new mathItemTool: aBuilderClassName	
]

{ #category : #adding }
DrGFlyBuildTool >> add: aCostume [
	mathItemTool add: aCostume 
]

{ #category : #accessing }
DrGFlyBuildTool >> builder [
"We have two builder, the flyPointBuilder and the other one (line, segment,...)"
	flyPointTool builder readyToBuild 
		ifTrue: [^flyPointTool builder]
		ifFalse: [^mathItemTool builder]
]

{ #category : #accessing }
DrGFlyBuildTool >> builder: aBuilder [
	mathItemTool builder: aBuilder.
]

{ #category : #accessing }
DrGFlyBuildTool >> description [ 
	^ mathItemTool builder class description 
]

{ #category : #accessing }
DrGFlyBuildTool >> flyPointTool [
	^flyPointTool
]

{ #category : #initialize-release }
DrGFlyBuildTool >> initialize [
	super initialize.
	self switchState: DrGFlyBuildToolState.
	flyPointTool := DrGFlyPointBuildTool with: DrGFlyPointBuilder
]

{ #category : #testing }
DrGFlyBuildTool >> isWanted: aMathItem [
	^mathItemTool isWanted: aMathItem
]

{ #category : #accessing }
DrGFlyBuildTool >> mathItemTool [
	^mathItemTool
]

{ #category : #accessing }
DrGFlyBuildTool >> mathItemTool: aBuilderClassName [
	mathItemTool ifNil: 
		[mathItemTool := DrGBuildTool with: aBuilderClassName] 
]

{ #category : #accessing }
DrGFlyBuildTool >> presenter: aPresenter [
	super presenter: aPresenter.
	mathItemTool presenter: aPresenter.
	flyPointTool presenter: aPresenter.
	mathItemTool builder app: self app
]

{ #category : #updating }
DrGFlyBuildTool >> redrawFlyingCostume [
	mathItemTool builder redrawFlyingCostume 
]

{ #category : #initialize-release }
DrGFlyBuildTool >> registerDependant: anObject [
	mathItemTool registerDependant: anObject.
	flyPointTool registerDependant: anObject
]

{ #category : #initialize-release }
DrGFlyBuildTool >> release [
	super release
	mathItemTool release.
	flyPointTool release.
]

{ #category : #updating }
DrGFlyBuildTool >> reset [
"Why do we reset?"
	"because intermediate point where created"
	flyPointTool builder readyToBuild ifTrue: [flyPointTool reset].
	"or the final mathItem was created"
	mathItemTool builder readyToBuild ifTrue:	
		[self resetForFreshStart].


]

{ #category : #updating }
DrGFlyBuildTool >> resetForFreshStart [
"Reset to restart over the user  build process"
	mathItemTool reset.
	flyPointTool reset.
]
