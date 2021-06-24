Class {
	#name : #KernelQuitLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-KernelQuit'
}

{ #category : #'hooks-api' }
KernelQuitLanguage class >> globalModel [
	^KernelQuitGlobal
]

{ #category : #'hooks-api' }
KernelQuitLanguage class >> metaclassModel [
	^ KernelQuitClass
]

{ #category : #'hooks-api' }
KernelQuitLanguage class >> packageModel [
	^PackageModel
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
	^ self classWithRole: #Metaclass
]

{ #category : #hooks }
KernelQuitLanguage >> entryPointCode [ 
	^ entryPointCode := 'Metaclass quit'
]

{ #category : #hooks }
KernelQuitLanguage >> entryPointReceiver [
	^ 'Metaclass'
]

{ #category : #hooks }
KernelQuitLanguage >> firstMetaclasses [
	^ {self classWithRole: #Metaclass}
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
	(self classWithRole: #Metaclass) install
]

{ #category : #hooks }
KernelQuitLanguage >> installMethods [
	(self classWithRole: #Metaclass) installMethods
]

{ #category : #hooks }
KernelQuitLanguage >> loadGlobalVariables [
	^ nil
]

{ #category : #roles }
KernelQuitLanguage >> testRemote [
	(self classWithRole: #Metaclass) testRemote
]

{ #category : #hooks }
KernelQuitLanguage >> transform [
	((self classWithRole: #Metaclass) 
		ensureLocalMethodNamed: #quit)
		sourceCode:
			'quit
	<primitive: 113>
	';
		selector: #quit;
		yourself
]
