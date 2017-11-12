Class {
	#name : #DrGiPadDemo,
	#superclass : #DrGiPad,
	#category : #DrGeoII-Core-Resources
}

{ #category : #path }
DrGiPadDemo >> mySketchesPath [
	^self rootPath / 'MySketches'
]

{ #category : #path }
DrGiPadDemo >> rootPath [
	^   FileLocator imageDirectory
]

{ #category : #'user interface' }
DrGiPadDemo >> showVirtualKeyboard: boolean [
	"We do no have a virtual keyboard for now"
]

{ #category : #initialize-release }
DrGiPadDemo >> startUp [
	Author fullName: 'DrGeoUser'.
	self installFont.
	self setFontPreferences.
	self checkForPaths.
	self splash.
	(World submorphs anySatisfy: [:morph | morph class == DrGeoWindow]) ifFalse:
		[DrGeo newFullScreen]
]
