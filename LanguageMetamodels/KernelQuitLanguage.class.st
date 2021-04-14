Class {
	#name : #KernelQuitLanguage,
	#superclass : #LanguageModel,
	#category : #'LanguageMetamodels-KernelQuit'
}

{ #category : #'hooks-api' }
KernelQuitLanguage class >> classMetaclass [
	^ KernelQuitClass
]

{ #category : #hooks }
KernelQuitLanguage >> entryPointCode [ 
	^ 'System quit'
]

{ #category : #hooks }
KernelQuitLanguage >> hookInitializeSpecialObjectsArray [
	^ nil
]

{ #category : #hooks }
KernelQuitLanguage >> hookSetSpecialObjectsArray: anEP2RemoteArray [
	^ nil
]
