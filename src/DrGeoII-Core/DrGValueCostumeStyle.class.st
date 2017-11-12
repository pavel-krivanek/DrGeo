Class {
	#name : #DrGValueCostumeStyle,
	#superclass : #DrGCostumeStyle,
	#category : #DrGeoII-Core-Item-View
}

{ #category : #initialize-release }
DrGValueCostumeStyle >> initialize [ 
	super initialize.
	self color: DrGStylePreference current valueColor.

]

{ #category : #widget }
DrGValueCostumeStyle >> nameWidget [
	^ 'Name' translated ->
		((self view
			newTextEntryFor: self mathItem 
			getText: #name 
			setText: #name: 
			help: 'Rename this object.' translated) minWidth: 10;
				changedAction: [:text| 
					self mathItem name: text asString.
					costume redraw])
]

{ #category : #accessing }
DrGValueCostumeStyle >> rename [
|answer|
	DrGDefault showVirtualKeyboard: true.
	self mathItem name 
		ifNotNil:	[
			answer := self view 
				textEntry:  'Rename this value' translated 
				title: 'Rename this value' translated 
				entryText: self mathItem name.]
		ifNil: [
			answer := self view 
				textEntry:  'Name this value' translated 
				title: 'Name this value' translated].
	answer ifNil: [^self].
	answer size = 0 ifTrue: [answer := nil].
	self mathItem name: answer.
	costume redraw.
	self changed
]
