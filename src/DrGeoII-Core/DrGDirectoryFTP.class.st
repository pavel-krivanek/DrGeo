"
I access DrGeo sketches located in a FTP server. 
	- client : the FTP connection client
"
Class {
	#name : #DrGDirectoryFTP,
	#superclass : #DrGDirectory,
	#instVars : [
		'client'
	],
	#category : #DrGeoII-Core-Resources
}

{ #category : #'instance creation' }
DrGDirectoryFTP class >> host: hostName [
	^ self new host: hostName
]

{ #category : #protocol }
DrGDirectoryFTP >> close [
	[client quit] on: Error do: []
]

{ #category : #accessing }
DrGDirectoryFTP >> deleteFile: thisFilename [
	[client deleteFileNamed: thisFilename] on: Error do: [].
]

{ #category : #protocol }
DrGDirectoryFTP >> directory: aPath [
	super directory: aPath.
	[client changeDirectoryTo: aPath] 
		on: TelnetProtocolError 
		do: [:ex | "check error, eventually create directory"
			ex code = 550 
				ifTrue: [
					[self makeDirectory: aPath]
						on: Error
						do: [self close.
							^ false]]
				ifFalse: [self close.
					^ false]].
		^ true
]

{ #category : #protocol }
DrGDirectoryFTP >> ensureConnection [
	client isConnected ifFalse:
		[client ensureConnection.
		self directory: directory]
]

{ #category : #testing }
DrGDirectoryFTP >> fileExists: filename [
	^ self getFileList includes: filename
]

{ #category : #accessing }
DrGDirectoryFTP >> getDirectoryList [
| list file |
	list := (client getDirectory subStrings: String crlf) 
		collect: [:aFilename | aFilename trimBoth] 
		thenSelect: [:aFilename | aFilename notEmpty].
		
	^ list allButFirst 
		select: [:each | each first = $d]
		thenCollect: [:dir | dir substrings last]
]

{ #category : #accessing }
DrGDirectoryFTP >> getFile: filename [
	^ReadStream on: (client getFileNamed: filename) asByteArray
]

{ #category : #accessing }
DrGDirectoryFTP >> getFileList [
	^(client getFileList subStrings: String crlf) 
		collect: [:file | file trimBoth] 
		thenSelect: [:file | file notEmpty]
]

{ #category : #accessing }
DrGDirectoryFTP >> getTextFile: filename [
	^ReadStream on: (client getFileNamed: filename)
]

{ #category : #protocol }
DrGDirectoryFTP >> host: hostName [
	client := FTPClient openOnHostNamed: hostName.
]

{ #category : #testing }
DrGDirectoryFTP >> isRemote [
	^ true
]

{ #category : #protocol }
DrGDirectoryFTP >> login: user password: password [
	client loginUser: user password: password.
	client binary
]

{ #category : #protocol }
DrGDirectoryFTP >> makeDirectory: aString [
	client makeDirectory: aString
]

{ #category : #protocol }
DrGDirectoryFTP >> pathNameDelimiter [
	^ $/
]

{ #category : #accessing }
DrGDirectoryFTP >> put: stream into:  aFilename [
	|readonlyStream|
	[client deleteFileNamed: aFilename] on: Error do: [].
	client binary.
	[readonlyStream := ReadStream  on: stream contents.
	client putFileStreamContents: readonlyStream as: aFilename] ensure: 
		[readonlyStream close]
]

{ #category : #testing }
DrGDirectoryFTP >> shareExists: aShare [
	^ self fileExists: aShare 
]

{ #category : #protocol }
DrGDirectoryFTP >> slash [
	^ $/
]
