"
A tool to select an item to open its viewer
"
Class {
	#name : #DrGViewerTool,
	#superclass : #DrGStyleTool,
	#category : #DrGeoII-Core-Tool
}

{ #category : #documentation }
DrGViewerTool class >> description [ 
	^ 'Open the Etoys script viewer for a given geometric object.' translated
]

{ #category : #documentation }
DrGViewerTool class >> title [
	^'Etoys Viewer' translated  
]

{ #category : #updating }
DrGViewerTool >> reset [
	super reset.
	self switchState: DrGViewerToolState
]
