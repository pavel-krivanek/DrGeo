"
The context is a tool (selectTool, buildTool, ...) where the state operate.
"
Class {
	#name : #DrGDynamicToolState,
	#superclass : #Object,
	#instVars : [
		'context'
	],
	#category : #DrGeoII-Core-Tool
}

{ #category : #accessing }
DrGDynamicToolState >> app [
	^self context app
]

{ #category : #accessing }
DrGDynamicToolState >> area [
	^self context area
]

{ #category : #accessing }
DrGDynamicToolState >> context [
	^context
]

{ #category : #accessing }
DrGDynamicToolState >> context: aContext [
	context := aContext 
]

{ #category : #handling }
DrGDynamicToolState >> handleChoice: aCostumeCollection [
	^false
]

{ #category : #handling }
DrGDynamicToolState >> handleMouseAt: aPoint [ 
	"Return true if we can process something or we are over something"
	| costumes aTip feedback |
	feedback := true.
	costumes := self context costumesAt: aPoint.
	costumes size = 1
		ifTrue: [
			aTip := costumes first mathItem descriptiveName.
			feedback := costumes first style isFeedback].
	costumes size > 1
		ifTrue: [aTip := 'Several objects can be selected. Please, choose one.' translated. ].
	(aTip isNil or: [ feedback not ])
		ifTrue: [self area hideTip]
		ifFalse: [self area tip: aTip at: aPoint].
	^ aTip notNil
]

{ #category : #handling }
DrGDynamicToolState >> handlePress: aPoint [
	^ false
]

{ #category : #handling }
DrGDynamicToolState >> handlePressShiftKey: aPoint [
"handle pressed mouse bouton with shift key, by default  just handle mouse button press"
	^ self handlePress: aPoint
]

{ #category : #handling }
DrGDynamicToolState >> handleRelease: aPoint [ 

]

{ #category : #handling }
DrGDynamicToolState >> handleReleaseShiftKey: aPoint [ 
" handle mouse bouton release while shift key down, by default only handle release"
	self handleRelease: aPoint
]

{ #category : #handling }
DrGDynamicToolState >> handleShiftKey: aPoint [
"handle shift key down, do nothing by default"
	^ false
]

{ #category : #handling }
DrGDynamicToolState >> handleShiftKeyMouseAt: aPoint [ 
"handle moved mouse while shift key down, by default just handle mouse at"
	^ self handleMouseAt: aPoint
]

{ #category : #handling }
DrGDynamicToolState >> handleStillPress: aPoint [
	"A 2s mouse down evt, by default do nothing"
]

{ #category : #state }
DrGDynamicToolState >> switchState: aStateClass [
	self context switchState: aStateClass
]

{ #category : #accessing }
DrGDynamicToolState >> view [
	^self context presenter view
]
