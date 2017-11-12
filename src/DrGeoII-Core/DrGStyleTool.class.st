"
A tool to edit the style of the costume.
"
Class {
	#name : #DrGStyleTool,
	#superclass : #DrGDynamicTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #documentation }
DrGStyleTool class >> description [ 
	^ 'Edit an object style.' translated
]

{ #category : #documentation }
DrGStyleTool class >> title [
	^ 'Edit Style' translated
]

{ #category : #accessing }
DrGStyleTool >> costumeStyle [
	^ self costume style
]

{ #category : #accessing }
DrGStyleTool >> costumesAt: aPoint [
	^self pointCostumesFirstAt: aPoint 
]

{ #category : #accessing }
DrGStyleTool >> description [ 
	^ self class description
]

{ #category : #initialize-release }
DrGStyleTool >> initialize [
	super initialize.
	self reset.
]

{ #category : #private }
DrGStyleTool >> myCostumesAt: aPoint [
"return the list of costume at position aPoint"
	^self app costumes select: [:aCostume |
		(self isWanted: aCostume mathItem)
		and: [aCostume containsPoint: aPoint]]
]

{ #category : #accessing }
DrGStyleTool >> presenter: aPresenter [
	super presenter: aPresenter.
	self app forceVisible: true.
]

{ #category : #initialize-release }
DrGStyleTool >> release [
	self app forceVisible: false.
	self presenter view setStyler: nil.
	DrGDefault showVirtualKeyboard: false.
	super release.
]

{ #category : #updating }
DrGStyleTool >> reset [
	super reset.
	self switchState: DrGStyleToolState
]
