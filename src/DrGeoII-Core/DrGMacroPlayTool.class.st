Class {
	#name : #DrGMacroPlayTool,
	#superclass : #DrGMacroBuildTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #updating }
DrGMacroPlayTool >> changedMacro [
" the builder inform us the user selected another macro-construction,
do some cleaning"
	self selectNoCostume
]

{ #category : #accessing }
DrGMacroPlayTool >> presenter: aPresenter [
	super presenter: aPresenter.
	self app notInteractive: true.
]

{ #category : #initialize-release }
DrGMacroPlayTool >> registerDependant: anObject [
	builder when: #changedState send: #switchState: to: self.
	builder when: #cancel send: #cancel to: self.
	builder when: #readyToBuild send: #readyToPlayMacro to: anObject.
	builder when: #changedMacro send: #changedMacro to: self
]

{ #category : #initialize-release }
DrGMacroPlayTool >> release [
	super release.
	self app notInteractive: false
]
