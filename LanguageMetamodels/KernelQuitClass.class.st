Class {
	#name : #KernelQuitClass,
	#superclass : #ClassModel,
	#category : #'LanguageMetamodels-KernelQuit'
}

{ #category : #binding }
KernelQuitClass >> bindingOf: aSymbol [

	^ nil
]

{ #category : #hooks }
KernelQuitClass >> extendWithMonticelloCustom: anEP2MCClassDefinition [ 
	^ self 
]

{ #category : #initialization }
KernelQuitClass >> initializeWithTemplateCustom: aClass [ 
	self deprecated: 'this code should be called from initialize'.
	^ self 
]

{ #category : #hooks }
KernelQuitClass >> innerBindingOf: aSymbol [ 
	^ nil
]

{ #category : #install }
KernelQuitClass >> installCustom [
	^ self remote
]

{ #category : #'accessing backend' }
KernelQuitClass >> metaclass [
	^ self parent classClass
]
