Class {
	#name : #MatchCVMetaclass,
	#superclass : #MatchMetaclass,
	#category : #'LanguageMetamodels-Match'
}

{ #category : #'bootstrap - build kernel classes' }
MatchCVMetaclass >> bindingOf: varName [
	^ self soleInstance bindingOf: varName
]

{ #category : #'bootstrap - build kernel classes' }
MatchCVMetaclass >> innerBindingOf: varName [
	^ self soleInstance innerBindingOf: varName
]
