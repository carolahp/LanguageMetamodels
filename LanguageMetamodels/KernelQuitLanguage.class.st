"
Minimum kernel that only quits after it starts.

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

{ #category : #hooks }
KernelQuitLanguage >> customClassRoles [
	^ { #ProtoObject -> #Object.
	#Class -> #Metaclass }
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
KernelQuitLanguage >> installClasses [
	self classClass install
]

{ #category : #hooks }
KernelQuitLanguage >> installMethods [
	self classClass installMethods
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
