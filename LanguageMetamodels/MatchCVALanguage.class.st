Class {
	#name : #MatchCVALanguage,
	#superclass : #MatchLanguage,
	#category : #'LanguageMetamodels-MatchCVAspects'
}

{ #category : #metamodel }
MatchCVALanguage class >> classModel [
	^ MatchCVAClass
]

{ #category : #metamodel }
MatchCVALanguage class >> customModels [
	^ { MatchCVAMetaclass }
]

{ #category : #metamodel }
MatchCVALanguage class >> metaclassModel [
	^ MatchCVAMetaclass
]
