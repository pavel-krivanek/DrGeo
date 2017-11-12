"
A DrGDirectory is Facade to the DrGeo file on local file system or remotre ressources on sever, as FTP or WebDav.
	- filename : hold a filename for regular use (the user does not have to enter it again)
"
Class {
	#name : #DrGDirectory,
	#superclass : #Object,
	#instVars : [
		'filename',
		'directory'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #protocol }
DrGDirectory >> close [
]

{ #category : #accessing }
DrGDirectory >> deleteFile: thisFilename [
	"Delete the file in the given resource"
	self subclassResponsibility 
]

{ #category : #protocol }
DrGDirectory >> directory [
	^ directory 
]

{ #category : #protocol }
DrGDirectory >> directory: aDirectory [
	directory := aDirectory
]

{ #category : #protocol }
DrGDirectory >> ensureConnection [ 
]

{ #category : #accessing }
DrGDirectory >> fgeoFiles [
	"return only the drgeo files"
	^ (self getFileList select: [:aFilename | aFilename endsWith: '.fgeo' ]) sort: 
		[:a :b | a asLowercase <= b asLowercase ]
]

{ #category : #testing }
DrGDirectory >> fileExists: filename [
	self subclassResponsibility 
]

{ #category : #accessing }
DrGDirectory >> filename [
	^ filename
]

{ #category : #accessing }
DrGDirectory >> filename: string [
	filename := string
]

{ #category : #accessing }
DrGDirectory >> getDirectoryList [
	"return an array with file list entry"
	self subclassResponsibility 
]

{ #category : #accessing }
DrGDirectory >> getFile: filename [
	"return a stream on filename content"
	self subclassResponsibility 
]

{ #category : #accessing }
DrGDirectory >> getFileList [
	"return an array with file list entry"
	self subclassResponsibility 
]

{ #category : #accessing }
DrGDirectory >> getTextFile: filename [
	self subclassResponsibility 
]

{ #category : #protocol }
DrGDirectory >> goParentDirectory [
	self deprecated: 'Not used and probably not working.'.
	self directory: self parentDirectory
]

{ #category : #testing }
DrGDirectory >> isLocal [
	^ false
]

{ #category : #testing }
DrGDirectory >> isRemote [
	^ false
]

{ #category : #testing }
DrGDirectory >> isValid [
	^ true
]

{ #category : #protocol }
DrGDirectory >> makeDirectory: aString [
	self subclassResponsibility 
]

{ #category : #accessing }
DrGDirectory >> parentDirectoriesUpTo: dirName [
	"return an array with parent directories up to dirName"
	self deprecated: 'Not used and probably not working.'.
]

{ #category : #protocol }
DrGDirectory >> parentDirectory [
	| index | 
	self deprecated: 'Not used and probably not working.'.
	^ (index := self directory findLast: [:each | each = self pathNameDelimiter]) = 0
		ifTrue: [self pathNameDelimiter asString]
		ifFalse: [self directory copyFrom: 1 to: (index - 1 max: 1)]
		
]

{ #category : #protocol }
DrGDirectory >> pathNameDelimiter [
	self subclassResponsibility
]

{ #category : #accessing }
DrGDirectory >> put: stream [
	filename ifNotNil: [self put: stream into: filename]
]

{ #category : #accessing }
DrGDirectory >> put: stream into: filename [
	self subclassResponsibility 
]
