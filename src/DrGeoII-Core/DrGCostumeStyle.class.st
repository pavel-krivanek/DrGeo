Class {
	#name : #DrGCostumeStyle,
	#superclass : #Object,
	#instVars : [
		'costume',
		'color',
		'hidden',
		'feedback'
	],
	#category : #DrGeoII-Core-Item-View
}

{ #category : #'instance creation' }
DrGCostumeStyle class >> newWith: aCostume [
	^self basicNew costume: aCostume; initialize
]

{ #category : #accessing }
DrGCostumeStyle >> baseColor [
	"Answer color whatever it is hidden or not"

	^ color alpha: 1
]

{ #category : #accessing }
DrGCostumeStyle >> borderColor [
	self shouldNotImplement 
]

{ #category : #accessing }
DrGCostumeStyle >> color [
	"Answer the value of color"

	^hidden ifTrue: [DrGStylePreference hiddenColor] ifFalse: [color]
]

{ #category : #accessing }
DrGCostumeStyle >> color: anObject [
	"Set the value of color"
	color := anObject.
	self isHidden ifFalse: [costume color: color].
	self changed
]

{ #category : #accessing }
DrGCostumeStyle >> colorIndex [
	^DrGStylePreference colorIndexOf: self color
]

{ #category : #accessing }
DrGCostumeStyle >> colorIndex: index [
	self color: (DrGStylePreference colorFor: index)
]

{ #category : #widget }
DrGCostumeStyle >> colorMorphCollection [
	^ DrGStylePreference colorMorphCollection
]

{ #category : #widget }
DrGCostumeStyle >> colorWidget [
	^ 'Colour' translated ->
		((self view
			newMorphDropListFor: self
			list: #colorMorphCollection
			getSelected: #colorIndex
			setSelected: #colorIndex:
			help: 'Set the colour.' translated) minWidth: DrGIcons menuExtent x + 35)
]

{ #category : #accessing }
DrGCostumeStyle >> costume [
	"Answer the value of costume"

	^ costume
]

{ #category : #accessing }
DrGCostumeStyle >> costume: anObject [
	"Set the value of costume"

	costume := anObject
]

{ #category : #accessing }
DrGCostumeStyle >> feedback [
	^ feedback
]

{ #category : #accessing }
DrGCostumeStyle >> feedback: aBoolean [
" Do I provide feedback when mouse over me?"
	feedback := aBoolean.
	self changed
]

{ #category : #widget }
DrGCostumeStyle >> feedbackWidget [
	^ 'Feedback' translated ->
		(self view
			newCheckboxFor: self 
			getSelected: #feedback
			setSelected: #feedback: 
			label:  '          ' 
			help:  'Toggle to provide feedback and interaction when the mouse cursor is over the object.' translated)
]

{ #category : #accessing }
DrGCostumeStyle >> hidden [
	^ self isHidden
]

{ #category : #accessing }
DrGCostumeStyle >> hidden: anObject [ 
	"Set the value of isHidden"
	hidden := anObject.
	hidden 
		ifTrue: 
			[costume stopBlinking.
			costume color: DrGStylePreference hiddenColor;
				borderColor: DrGStylePreference hiddenColor]
		ifFalse: [self color: self color].
	self changed
]

{ #category : #widget }
DrGCostumeStyle >> hiddenWidget [
	^ 'Hide' translated ->
		(self view
			newCheckboxFor: self 
			getSelected: #hidden
			setSelected: #hidden: 
			label:  '          ' 
			help:  'Toggle to hide the object.' translated)
]

{ #category : #initialize-release }
DrGCostumeStyle >> initialize [
	feedback := true.
	hidden := false.
	self addDependent: costume
]

{ #category : #testing }
DrGCostumeStyle >> isFeedback [
	^ feedback 
]

{ #category : #testing }
DrGCostumeStyle >> isFilled [
	^ false
]

{ #category : #accessing }
DrGCostumeStyle >> isHidden [
	"Answer the value of isHidden"

	^ hidden ifNil: [hidden := false]
]

{ #category : #testing }
DrGCostumeStyle >> isNotHidden [
	"Answer the value of isHidden"

	^ hidden not
]

{ #category : #testing }
DrGCostumeStyle >> isTranslucent [ 
	^ false
]

{ #category : #widget }
DrGCostumeStyle >> lockedWidget [
	^ 'Lock' translated ->
		(self view
			newCheckboxFor: costume
			getSelected: #locked
			setSelected: #locked: 
			label: '          '  
			help:  'Toggle to lock the object to its position.' translated)
]

{ #category : #accessing }
DrGCostumeStyle >> mathItem [
	^ costume mathItem
]

{ #category : #widget }
DrGCostumeStyle >> myWidgets [
"overwrite to add specific widget to edit specific style"
	^ OrderedCollection new
]

{ #category : #widget }
DrGCostumeStyle >> nameWidget [
	^ 'Name' translated ->
		((self view
			newTextEntryFor: costume 
			getText: #name 
			setText: #textMorph: 
			help: 'Rename this object.' translated) minWidth: 10;
				changedAction: [:text| costume textMorph: text asString])
]

{ #category : #initialize-release }
DrGCostumeStyle >> release [
	self breakDependents 
]

{ #category : #accessing }
DrGCostumeStyle >> rename [
	costume textMorph
		ifNil: [costume textMorph: 'edit me' translated].
	DrGDefault isTablet
		ifFalse: [costume textMorph launchMiniEditor: ActiveEvent]
		ifTrue: [	| answer| 
			DrGDefault showVirtualKeyboard: true.
			answer := self view 
				textEntry:  'Rename this object' translated 
				title: 'Rename this object' translated 
				entryText: costume mathItem name.
			DrGDefault showVirtualKeyboard: false.
			answer ifNil: [^self].
			costume textMorph: answer.
			costume redraw]
]

{ #category : #widget }
DrGCostumeStyle >> styleWidget [
| controls |
	controls := 	OrderedCollection new
		add: self nameWidget;
		add: self colorWidget;
		yourself.
	controls addAll: self myWidgets.
	controls add: self feedbackWidget.
	controls add: self hiddenWidget.
	costume isLockable ifTrue: [controls add: self lockedWidget].
	^ (self view newLabelGroup: controls) layoutInset: 4
]

{ #category : #accessing }
DrGCostumeStyle >> toggleHidden [
	self hidden: self isHidden not
]

{ #category : #accessing }
DrGCostumeStyle >> view [
	^ costume view
]

{ #category : #'xml writing' }
DrGCostumeStyle >> writeAttributesTo: aNode [
	aNode 
		attributeAt: #color put: self baseColor name asString capitalized;
		attributeAt: #masked put: hidden asString capitalized;
		attributeAt: #feedback put: feedback asString capitalized
]
