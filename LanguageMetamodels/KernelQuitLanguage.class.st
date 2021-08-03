"
quit destroy.
quit := (KernelQuitLanguage  
	newWithName:  'Quit3' withEntryPoint:  'Metaclass quit.').
quit generate.
quit destroy.
quit := nil.
quit writeImage.
quit imageInDisk executeInVM.

quit debugEntryPoint .
quit imageInMemory.
"
Class {
	#name : #KernelQuitLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-KernelQuit'
}

{ #category : #'hooks-api' }
KernelQuitLanguage class >> classModel [
	^ KernelQuitClass
]

{ #category : #'hooks-api' }
KernelQuitLanguage class >> globalModel [
	^KernelQuitGlobal
]

{ #category : #hooks }
KernelQuitLanguage >> createInitialObjects [
	^ nil
]

{ #category : #hooks }
KernelQuitLanguage >> createRemoteSystemDictionary [
	^nil
]

{ #category : #roles }
KernelQuitLanguage >> customClassRoles [
	^nil
]

{ #category : #hooks }
KernelQuitLanguage >> entryPointClass [
	^ self classClass
]

{ #category : #hooks }
KernelQuitLanguage >> entryPointCode [ 
	^ entryPointCode := 'Metaclass quit'
]

{ #category : #hooks }
KernelQuitLanguage >> entryPointReceiver [
	^ 'Class'
]

{ #category : #hooks }
KernelQuitLanguage >> firstMetaclasses [
	^ {self classClass}
]

{ #category : #hooks }
KernelQuitLanguage >> hookSetSpecialObjectsArray: anEP2RemoteArray [
	^ nil
]

{ #category : #hooks }
KernelQuitLanguage >> initializeSpecialObjectsArray [
	^ nil
]

{ #category : #hooks }
KernelQuitLanguage >> installClasses [
	self classClass install
]

{ #category : #hooks }
KernelQuitLanguage >> installMethods [
	self classClass installMethods
]

{ #category : #hooks }
KernelQuitLanguage >> loadGlobalVariables [
	^ nil
]

{ #category : #roles }
KernelQuitLanguage >> testRemote [
	self classClass testRemote
]

{ #category : #hooks }
KernelQuitLanguage >> transform [
	(self classClass 
		ensureLocalMethodNamed: #quit)
		sourceCode:
			'quit
	<primitive: 113>
	';
		selector: #quit;
		yourself
]
