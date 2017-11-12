Class {
	#name : #DrGMacroBuildTool,
	#superclass : #DrGBuildTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #updating }
DrGMacroBuildTool >> cancel [
	"the builder informs us the user wants to cancel the macro building process"
	presenter move.
]

{ #category : #accessing }
DrGMacroBuildTool >> costumesAt: aPoint [
	^self pointCostumesFirstAt: aPoint 
]

{ #category : #initialization }
DrGMacroBuildTool >> initialize [
	super initialize.
	self switchState: DrGMacroToolStateNeutral 
]

{ #category : #initialize-release }
DrGMacroBuildTool >> registerDependant: anObject [
	builder when: #changedState send: #switchState: to: self.
	builder when: #cancel send: #cancel to: self.
	builder when: #readyToBuild send: #readyToBuildMacro to: anObject
]

{ #category : #accessing }
DrGMacroBuildTool >> selectCostumesFrom: aMathItemCollection [ 
	presenter ifNil: [^self].
	self stopBlinking.
	selectedCostumes := self app costumesOf: aMathItemCollection.
	self startBlinking
]

{ #category : #accessing }
DrGMacroBuildTool >> selectInputCostume [
	self selectCostumesFrom: builder input
]

{ #category : #accessing }
DrGMacroBuildTool >> selectNoCostume [
	self selectCostumesFrom: OrderedCollection new
]

{ #category : #accessing }
DrGMacroBuildTool >> selectOutputCostume [
	self selectCostumesFrom: builder output
]
