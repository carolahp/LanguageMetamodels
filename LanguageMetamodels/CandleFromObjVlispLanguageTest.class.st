Class {
	#name : #CandleFromObjVlispLanguageTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
CandleFromObjVlispLanguageTest >> languageModelClass [
	^ CandleFromObjVLispLanguage 
]

{ #category : #'instance creation' }
CandleFromObjVlispLanguageTest >> sourcesPath [
	" same as objvlispMin "
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
CandleFromObjVlispLanguageTest >> testNewModel [
	entryPointCode:= 'System quit'.
	self newModel.
]
