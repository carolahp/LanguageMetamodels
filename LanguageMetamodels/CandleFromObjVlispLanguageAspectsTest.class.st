Class {
	#name : #CandleFromObjVlispLanguageAspectsTest,
	#superclass : #LanguageTest,
	#category : #'LanguageMetamodels-Tests'
}

{ #category : #'instance creation' }
CandleFromObjVlispLanguageAspectsTest >> languageModelClass [
	^ CandleFromObjVLispLanguage 
]

{ #category : #'instance creation' }
CandleFromObjVlispLanguageAspectsTest >> sourcesPath [
	" same as objvlispMin "
	^ '/Users/carolina.hernandez/Documents/restaurado/bootstrap/language-definitions/ObjVLispMin'
]

{ #category : #'instance creation' }
CandleFromObjVlispLanguageAspectsTest >> testNewModel [
	| systemDict |
	entryPointCode := '
	System log: ''hola''.
	.System quit'.
	expectedResult:= 'hola'.
	[ systemDict := SystemDictionaryAspect new.
	systemDict install.
	Transcript
		show: 'SystemDictionary test';
		cr.
	self inVMExecuteEntryPoint ]
		ensure: [ systemDict uninstall ].
]
