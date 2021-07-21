Class {
	#name : #ProtectLanguage,
	#superclass : #CandleLanguage,
	#category : #'LanguageMetamodels-Protect'
}

{ #category : #'hooks-api' }
ProtectLanguage class >> classModel [
	^ ProtectClass
]

{ #category : #'hooks-api' }
ProtectLanguage class >> packageModel [
	^ ProtectPackage
]
