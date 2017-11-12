"
I am the installer for Workstations image.
"
Class {
	#name : #DrGeoInstallerWorksation,
	#superclass : #DrGeoInstaller,
	#category : #DrGeoII-Installer
}

{ #category : #actions }
DrGeoInstallerWorksation >> install [
	super install.
	DrGDefault beWorkstation.
	self cleanUpForRelease.
	Smalltalk saveAs: 'drgeo'.
	World submorphs 
		select: [:m | m class == (Smalltalk at: #DrGeoWindow)]
		thenDo: [:drMorph | drMorph deleteWithoutConfirmation ].

	self cleanMySelf.
	Smalltalk fixObsoleteReferences.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.
	Smalltalk garbageCollect.

	PharoChangesCondenser condense.
	ExternalDropHandler registerHandler: 
		(ExternalDropHandler 
			type: nil 
			extension: 'fgeo' 
			action: [ :stream | DrGeo fullscreenOn: stream ]).
	
	Smalltalk snapshot: true andQuit: true.

]
