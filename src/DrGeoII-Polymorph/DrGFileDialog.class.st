"
A DrGFileDialogWindow is filebrowser to keep sketch the old way.

"
Class {
	#name : #DrGFileDialog,
	#superclass : #FileDialogWindow,
	#category : #DrGeoII-Polymorph
}

{ #category : #'as yet unclassified' }
DrGFileDialog >> newPreviewMorph [
	"Answer a new preview morph."
	| aMorph |
	aMorph := super newPreviewMorph.
	self previewType == #drgeo ifTrue: [aMorph := self newImagePreviewMorph].
	^ aMorph.
]

{ #category : #'as yet unclassified' }
DrGFileDialog >> previewSize [
	| aSize |
	aSize := super previewSize.
	self previewType == #drgeo ifTrue: [aSize := DrGeo previewSize].
	^ aSize
]

{ #category : #'as yet unclassified' }
DrGFileDialog >> updateDrGeoPreview [
	| str aDrgeo |
	str := self openSelectedFile.
	str ifNil: [^self]. 
	[[aDrgeo := (DrGeoXml new loadOnlyFigureFrom: str for: #service) first.
	  aDrgeo view openInWorld; delete]
		on: Error do: []]
		ensure: [str close].
	self previewMorph
		image: (aDrgeo ifNil: [Form extent: 1@1] ifNotNil: [ |aForm  |
			aForm := (Form extent: aDrgeo area extent depth: 32) fillWhite .
			aDrgeo area owner fullDrawOn: aForm getCanvas.
			aForm])
		size: DrGeo previewSize.
]

{ #category : #'as yet unclassified' }
DrGFileDialog >> updatePreview [
	super updatePreview.
	self previewType == #drgeo ifTrue: [self updateDrGeoPreview]
	
]
