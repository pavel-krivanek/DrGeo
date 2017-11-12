Class {
	#name : #DrGScriptPlayTool,
	#superclass : #DrGMacroBuildTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #updating }
DrGScriptPlayTool >> changedScript [
" the builder inform us the user selected another script,
do some cleaning"
	self selectNoCostume
]

{ #category : #initialize-release }
DrGScriptPlayTool >> registerDependant: anObject [
	builder when: #changedState send: #switchState: to: self.
	builder when: #cancel send: #cancel to: self.
	builder when: #readyToBuild send: #readyToBuild to: anObject.
	builder when: #changedScript send: #changedScript to: self
]
